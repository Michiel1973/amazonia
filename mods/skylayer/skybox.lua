local location_underground = -50
local location_cloudlands_low = 6900 
local location_cloudlands_high = 7500
local location_stars_low = 15500
local location_stars_high = 31000

local is_in_creative = function(name)
	return creative and creative.is_enabled_for
		and creative.is_enabled_for(name)
end
	
local skybox_underground = function(player_name)
	local sl = {}
	sl.name = "underground"
	sl.sky_data = {
		base_color = { r = 0, g = 0, b = 0 },
		clouds = false
	}
	sl.sun_data = {
		visible = false,
		scale = 1.0
	}
	sl.moon_data = {
		visible = false,
		sunrise_visible = false,
		scale = 1.0
	}
	sl.stars_data = {
		visible = false
	}
	skylayer.add_layer(player_name, sl)
end

local skybox_default_sky = function(player_name)
	local sl = {}
	sl.name = "default_sky"
	sl.sky_data = {
		gradient_sky = {
			clouds = true,
			day_sky = {
				{ r = 139, g = 185, b = 249},
			},
			day_horizon = {
				{ r = 154, g = 192, b = 239},
			},
			night_sky = {
				{ r = 0, g = 0, b = 0},
				{ r = 0, g = 0, b = 0},
				{ r = 0, g = 0, b = 0}
			},
			night_horizon = {
				{ r = 0, g = 0, b = 50},
				{ r = 0, g = 0, b = 50},
				{ r = 0, g = 0, b = 50}
			},
		}
	}
	sl.clouds_data = {
			density = 0.4,
			-- color = "#fff0f0e5",
			-- ambient =  "#000000",
			height = 120,
			thickness = 16,
			speed = { x = 0, z = -2 },
	}
	sl.sun_data = {
		visible = true,
		scale = 1.0
	}
	sl.moon_data = {
		visible = true,
		scale = 1.0
	}
	sl.stars_data = {
		visible = true
	}
	skylayer.add_layer(player_name, sl)
end

local skybox_cloudlands_sky = function(player_name)
	local sl = {}
	sl.name = "cloudlands_sky"
	sl.sky_data = {
		clouds = true,
		gradient_sky = {
			day_sky = {
				{ r = 90, g = 0, b = 3},
				{ r = 100,g = 0, b = 6},
				{ r = 90, g = 0, b = 3}
			},
			day_horizon = {
				{ r = 90, g = 46, b = 0},
				{ r = 100,g = 56, b = 0},
				{ r = 90, g = 46, b = 0}
			},
			-- dawn_sky = {
				-- { r = 70, g = 0, b = 0},
				-- { r = 70, g = 0, b = 0},
				-- { r = 70, g = 0, b = 0}
			-- },
			-- dawn_horizon = { 
				-- { r = 80, g = 36, b = 0},
				-- { r = 80, g = 36, b = 0},
				-- { r = 80, g = 36, b = 0},
			-- },
			night_sky = {
				{ r = 80, g = 0, b = 0},
				{ r = 0, g = 0, b = 0},
				{ r = 80, g = 0, b = 0}
			},
			night_horizon = {
				{ r = 80, g = 36, b = 0},
				{ r = 0, g = 0, b = 0},
				{ r = 80, g = 36, b = 0}
			},
		}
	}
	sl.clouds_data = {
			density = 0.4,
			-- color = "#fff0f0e5",
			-- ambient = "#000000",
			height = 7200,
			thickness = 2,
			speed = { x = 0, z = -16 }
	}
	sl.sun_data = {
		visible = true,
		scale = 1.5
	}
	sl.moon_data = {
		visible = true,
		scale = 1.5
	}
	sl.stars_data = {
		visible = true
	}
	skylayer.add_layer(player_name, sl)
end

local skybox_stars = function(player_name)
	local sl = {}
	sl.name = "stars"
	sl.sky_data = {
		clouds = false,
		type = "skybox",
		textures = {
			"skylayer_demo_stars_sky.png",
			"skylayer_demo_stars_sky.png",
			"skylayer_demo_stars_sky.png",
			"skylayer_demo_stars_sky.png",
			"skylayer_demo_stars_sky.png",
			"skylayer_demo_stars_sky.png"
		}
	}
	sl.stars_data = {
		visible = false
	}
	sl.sun_data = {
		visible = true,
		sunrise_visible = false,
		scale = 2
	}
	sl.moon_data = {
		visible = true,
		scale = 2
	}
	skylayer.add_layer(player_name, sl)
end

local remove_layers = function(player_name)
	skylayer.remove_layer(name, underground)
	skylayer.remove_layer(name, default_sky)
	skylayer.remove_layer(name, cloudlands_sky)
	skylayer.remove_layer(name, stars)
end

local timer = 0
local player_list = {} 

minetest.register_globalstep(function(dtime)

	timer = timer + dtime

	if timer < 2 then
		return
	end

	timer = 0

	for _, player in pairs(minetest.get_connected_players()) do

		local name = player:get_player_name()
		local pos = player:getpos()
		local current = player_list[name] or ""

		-- underground
		if pos.y < location_underground and current ~= "underground" then
			player_list[name] = "underground"
			if not is_in_creative(name) then
			remove_layers(name)
			player:set_physics_override({gravity = 1})
			--player:set_sky( {r=0, g=0, b=0}, "plain", nil, false)
			skybox_underground(name)
			end
		-- Earth
		elseif pos.y > location_underground and pos.y < location_cloudlands_low and current ~= "earth" then
			player_list[name] = "earth"
			remove_layers(name)
			player:set_sky( {r=0, g=0, b=0}, "plain", nil, true)
			skybox_default_sky(name)
		-- cloudlands
		elseif pos.y > location_cloudlands_low and pos.y < location_cloudlands_high and current ~= "cloudlands" then
			player_list[name] = "cloudlands"
			remove_layers(name)
			player:set_physics_override({gravity = 0.5})
			player:set_sky( {r=0, g=0, b=0}, "plain", nil, true)
			skybox_cloudlands_sky(name)
		-- stars
		elseif pos.y > location_cloudlands_high and pos.y < location_stars_high and current ~= "stars" then
			player_list[name] = "stars"
			remove_layers(name)
			player:set_physics_override({gravity = 0.2})
			--player:set_sky( {r=0, g=0, b=0}, "plain", nil, false)
			skybox_stars(name)
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_list[name] = nil
	player:set_physics_override({gravity = 1})
end)