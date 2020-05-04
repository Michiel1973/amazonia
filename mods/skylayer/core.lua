-------------------------
-- Sky Layers: Core

-- Git: https://gitlab.com/rautars/skylayer
-- License: MIT
-- Credits: rautars
-- Thanks: Perkovec for colorise utils (github.com/Perkovec/colorise-lua) 
-------------------------

local modpath = minetest.get_modpath("skylayer");
local colorise = dofile(modpath.."/thirdparty/colorise-lua/colorise.lua")

local core = {}

core.settings = {}

-- flag to disable skylayer at global step
core.settings.enabled = true

-- default gradient interval values
core.settings.gradient_default_min_value = 0
core.settings.gradient_default_max_value = 1000

-- how often sky will be updated in seconds
core.settings.update_interval = 4

-- helps track total dtime
core.timer = 0

core.default_clouds = nil
core.default_moon = nil
core.default_sun = nil
core.default_stars = nil
core.default_sky_color = nil

-- keeps player related data such as player itself and own sky layers
core.sky_players = {}

-- flag for minetest legacy version (< 5.1.1), value will be initialized lazily
core.legacy = nil

-- A helper function to imitate ternary operator for inline if/else checks
core.ternary = function(condition, trueVal, falseVal)
	if condition then
		return trueVal
	end
	return falseVal
end

-- adds player to sky layer affected players list
core.add_player = function(player)
	local data = {}
	data.id = player:get_player_name()
	data.player = player
	data.skylayers = {}
	table.insert(core.sky_players, data)
end

-- remove player from sky layer affected players list
core.remove_player = function(player_name)
	if #core.sky_players == 0 then
		return
	end
	for k, player_data in ipairs(core.sky_players) do
		if player_data.id == player_name then
			reset_sky(player_data.player)
			table.remove(core.sky_players, k)
			return
		end
	end
end

core.get_player_by_name = function(player_name)
	if player_name == nil then
		return nil
	end
	if #minetest.get_connected_players() == 0 then
		return nil
	end
	for i, player in ipairs(minetest.get_connected_players()) do
		if player:get_player_name() == player_name then
			return player
		end
	end
	return nil
end

core.get_player_data = function(player_name)
	if #core.sky_players == 0 then
		return nil
	end
	for k, player_data in ipairs(core.sky_players) do
		if player_data.id == player_name then
			return player_data
		end
	end	
end

core.create_new_player_data = function(player_name)
	local player_data = core.get_player_data(player_name)
	if player_data == nil then
		local player = core.get_player_by_name(player_name)
		if player == nil then
			minetest.log("error", "Fail to resolve player '" .. player_name .. "'")
			return
		end
		core.add_player(player)
		return core.get_player_data(player_name)
	end
	return player_data
end

-- sets default / regular sky for player
core.reset_sky = function(player)
	player:set_clouds(core.default_clouds)
	if core.legacy then
		player:set_sky(nil, "regular", nil)
	else
		player:set_sky({
			base_color = nil,
			type = "regular",
			textures = nil,
			clouds = true,
			sky_color = core.default_sky_color
		})
		player:set_moon(core.default_moon)
		player:set_sun(core.default_sun)
		player:set_stars(core.default_stars)
	end

end

-- resolves latest skylayer based on added layer time
core.get_latest_layer = function(layers)
	if #layers == 0 then
		return nil
	end

	local latest_layer = nil
	for k, layer in ipairs(layers) do
		if latest_layer == nil then
			latest_layer = layer
		else
			if layer.added_time >= latest_layer.added_time then
				latest_layer = layer
			end
		end
	end

	return latest_layer
end

core.convert_to_rgb = function(minval, maxval, current_val, colors)
	local max_index = #colors - 1
	local val = (current_val-minval) / (maxval-minval) * max_index + 1.0

	local index1 = math.floor(val)
	local index2 = math.min(math.floor(val) + 1, max_index + 1)
	local f = val - index1
	local c1 = colors[math.max(index1, 1)]
	local c2 = colors[index2]

	if c2 == nil then -- TODO need dig this case more carefully and improve handling
		c2 = colors[max_index]
	end

	return {
		r = math.floor(c1.r + f * (c2.r - c1.r)),
		g = math.floor(c1.g + f * (c2.g - c1.g)),
		b = math.floor(c1.b + f * (c2.b - c1.b))
	}
end

-- Returns current gradient color in {r, g, b} format
core.calculate_current_gradient_color = function(gradient_colors, min_val, max_val)
	if gradient_colors == nil then return nil end
	if min_val == nil then
		min_val = core.settings.gradient_default_min_value
	end
	if max_val == nil then
		max_val = core.settings.gradient_default_max_value
	end

	local rounded_time = math.floor(minetest.get_timeofday() * max_val)
	return core.convert_to_rgb(min_val, max_val, rounded_time, gradient_colors)
end

-- Returns current sky color in {r, g, b} format
core.get_current_layer_color = function(gradient_colors, min_val, max_val)
	return core.calculate_current_gradient_color(gradient_colors, min_val, max_val)
end

-- Returns current cloud color in hex format
core.calculate_color_hex_value = function(gradient_colors, min_val, max_val)
	local rgb_color = core.calculate_current_gradient_color(gradient_colors, min_val, max_val)
	if rgb_color == nil then return nil end
	return colorise.rgb2hex({rgb_color.r, rgb_color.g, rgb_color.b}) 
end

core.resolve_sky_color = function(sky_data)
	local sky_color = sky_data.sky_color
	local gradient_sky = sky_data.gradient_sky

	if sky_color == nil and gradient_sky == nil then
		return core.default_sky_color
	end

	if sky_color == nil then
		sky_color = {}
	end

	-- merge user set color values with worlds defaults
	local merged_sky_color = {
		day_sky = sky_color.day_sky and sky_color.day_sky or core.default_sky_color.day_sky,
		day_horizon = sky_color.day_horizon and sky_color.day_horizon or core.default_sky_color.day_horizon,
		dawn_sky = sky_color.dawn_sky and sky_color.dawn_sky or core.default_sky_color.dawn_sky,
		dawn_horizon = sky_color.dawn_horizon and sky_color.dawn_horizon or core.default_sky_color.dawn_horizon,
		night_sky = sky_color.night_sky and sky_color.night_sky or core.default_sky_color.night_sky,
		night_horizon = sky_color.night_horizon and sky_color.night_horizon or core.default_sky_color.night_horizon,
		indoors = sky_color.indoors and sky_color.indoors or core.default_sky_color.indoors,
		fog_sun_tint = sky_color.fog_sun_tint and sky_color.fog_sun_tint or core.default_sky_color.fog_sun_tint,
		fog_moon_tint = sky_color.fog_moon_tint and sky_color.fog_moon_tint or core.default_sky_color.fog_moon_tint,
		fog_tint_type = sky_color.fog_tint_type and sky_color.fog_tint_type or core.default_sky_color.fog_tint_type
	}

	if gradient_sky == nil then
		return merged_sky_color
	end

	local time_of_day = math.floor(minetest.get_timeofday() * 1000)

	if gradient_sky.day_sky ~= nil and time_of_day > 190 and time_of_day < 800 then
		merged_sky_color.day_sky = core.calculate_color_hex_value(gradient_sky.day_sky, 200, 750)
	end
	if gradient_sky.day_horizon ~= nil and time_of_day > 190 and time_of_day < 800 then
		merged_sky_color.day_horizon = core.calculate_color_hex_value(gradient_sky.day_horizon, 200, 750)
	end
	if gradient_sky.dawn_sky ~= nil and time_of_day >= 750 and time_of_day <= 850 then
		merged_sky_color.dawn_sky = core.calculate_color_hex_value(gradient_sky.dawn_sky, 750, 850)
	end
	if gradient_sky.dawn_horizon ~= nil and time_of_day >= 750 and time_of_day <= 850 then
		merged_sky_color.dawn_horizon = core.calculate_color_hex_value(gradient_sky.dawn_horizon, 750, 850)
	end
	if time_of_day >= 800 or time_of_day <= 190 then
		local night_sky_min = time_of_day >= 800 and 800 or 0
		local night_sky_max = time_of_day >= 800 and 1000 or 200
		if gradient_sky.night_sky ~= nil then
			merged_sky_color.night_sky = core.calculate_color_hex_value(gradient_sky.night_sky, night_sky_min, night_sky_max)
		end
		if gradient_sky.night_horizon ~= nil then
			merged_sky_color.night_horizon = core.calculate_color_hex_value(gradient_sky.night_horizon, night_sky_min, night_sky_max)
		end
		if gradient_sky.fog_moon_tint ~= nil then
			merged_sky_color.fog_moon_tint = core.calculate_color_hex_value(gradient_sky.fog_moon_tint, night_sky_min, night_sky_max)
		end
		elseif gradient_sky.fog_sun_tint ~= nil then
			merged_sky_color.fog_sun_tint = core.calculate_color_hex_value(gradient_sky.fog_sun_tint, 200, 750)
	end
	if gradient_sky.indoors ~= nil then
		merged_sky_color.indoors = core.calculate_color_hex_value(gradient_sky.indoors)
	end
	return merged_sky_color
end

core.update_sky_details = function(player, sky_layer)
	local sky_data = sky_layer.sky_data

	if sky_data == nil then
		return
	end

	local bg_color = sky_data.base_color and sky_data.base_color or sky_data.bgcolor -- fallback to bgcolor legacy parameter
	if sky_data.gradient_colors ~= nil then
		bg_color = core.get_current_layer_color(
				sky_data.gradient_colors,
				sky_data.gradient_min_value,
				sky_data.gradient_max_value)
	end

	local sky_type = sky_data.type and sky_data.type or "plain"
	if sky_data.type == nil and (sky_data.sky_color ~= nil or sky_data.gradient_sky ~= nil) then
		sky_type = "regular"
	end

	if core.legacy then
		player:set_sky(
			bg_color,
			sky_type,
			sky_data.textures,
			sky_data.clouds
		)
	else
		player:set_sky({
			base_color = bg_color,
			type = sky_type,
			textures = sky_data.textures,
			clouds = sky_data.clouds,
			sky_color = core.resolve_sky_color(sky_data)
		})
	end
end

core.update_moon_details = function(player, sky_layer)
	local moon_data = sky_layer.moon_data
	if moon_data == nil then
		return
	end
	player:set_moon(moon_data)
end

core.update_sun_details = function(player, sky_layer)
	local sun_data = sky_layer.sun_data
	if sun_data == nil then
		return
	end
	player:set_sun(sun_data)
end

core.update_stars_details = function(player, sky_layer)
	local stars_data = sky_layer.stars_data
	if stars_data == nil then
		return
	end

	local _stars_color = core.calculate_color_hex_value(
			stars_data.gradient_star_colors,
			stars_data.gradient_star_min_value,
			stars_data.gradient_star_max_value)
	local star_brightness = stars_data.brightness and stars_data.brightness or "69"

	player:set_stars({
		visible = core.ternary(stars_data.visible, stars_data.visible, core.default_stars.visible),
		count = stars_data.count and stars_data.count or core.default_stars.count,
		star_color = _stars_color and _stars_color .. star_brightness or core.default_stars.star_color,
		scale = stars_data.scale and stars_data.scale or core.default_stars.scale
	})
end

core.update_clouds_details = function(player, sky_layer)
	local clouds_data = sky_layer.clouds_data

	if clouds_data == nil then
		return
	end

	local cloud_color = core.calculate_color_hex_value(
		clouds_data.gradient_colors, 
		clouds_data.gradient_min_value,
		clouds_data.gradient_max_value)

	local ambient_color = core.calculate_color_hex_value(
		clouds_data.gradient_ambient_colors,
		clouds_data.gradient_ambient_min_value,
		clouds_data.gradient_ambient_max_value)

	player:set_clouds({
		color = cloud_color and clouds_data.color or core.default_clouds.color,
		density = clouds_data.density and clouds_data.density or core.default_clouds.density,
		ambient = ambient_color and clouds_data.ambient or core.default_clouds.ambient,
		height = clouds_data.height and clouds_data.height or core.default_clouds.height,
		thickness = clouds_data.thickness and clouds_data.thickness or core.default_clouds.thickness,
		speed = clouds_data.speed and clouds_data.speed or core.default_clouds.speed
	})
end

core.post_update_processing = function(player, player_data, sky_layer)
	if sky_layer.reset_defaults == true then
		core.reset_sky(player)
		sky_layer.reset_defaults = false
	end

	player_data.last_active_layer = sky_layer.name
	if player_data.last_active_layer == nil or player_data.last_active_layer ~= sky_layer.name then
		sky_layer.reset_defaults = true
	end
end

core.update_sky = function(player, timer)
	local player_data = core.get_player_data(player:get_player_name())
	if player_data == nil then return end

	local current_layer = core.get_latest_layer(player_data.skylayers)
	if current_layer == nil then return end

	if current_layer.updated == false or core.timer >= current_layer.update_interval then
		current_layer.updated = os.time()
		core.update_sky_details(player, current_layer)
		core.update_clouds_details(player, current_layer)
		if core.legacy == false then
			core.update_moon_details(player, current_layer)
			core.update_sun_details(player, current_layer)
			core.update_stars_details(player, current_layer)
		end
		core.post_update_processing(player, player_data, current_layer)
	end
end

minetest.register_on_joinplayer(function(player)
	if core.default_clouds == nil then
		core.default_clouds = player:get_clouds()
	end

	if core.legacy == nil then
		core.legacy = player.get_moon == nil and true or false
	end

	if core.default_moon == nil then
		core.default_moon = player.get_moon and player:get_moon() or {}
		core.default_moon.texture = "" -- according set_moon api description, empty string used for setting default texture.
	end
	if core.default_sun == nil then
		core.default_sun = player.get_sun and player:get_sun() or {}
		core.default_sun.texture = ""
	end
	if core.default_stars == nil then
		core.default_stars = player.get_stars and player:get_stars() or {}
	end
	if core.default_sky_color == nil then
		core.default_sky_color = player.get_sky_color and player:get_sky_color() or {}
	end
end)

minetest.register_globalstep(function(dtime)
	if core.settings.enabled == false then
		return
	end

	if #minetest.get_connected_players() == 0 then
		return
	end

	-- timer addition calculated outside of players loop 
	core.timer = core.timer + dtime;

	for k, player in ipairs(minetest.get_connected_players()) do
		core.update_sky(player, core.timer)
	end

	-- reset timer outside of loop to make sure that all players sky will be updated
	if core.timer >= core.settings.update_interval then
		core.timer = 0
	end
end)

return core
