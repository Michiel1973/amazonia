-------------------------
-- Sky Layers: Demo
-- Allows quickly test skylayer api

-- Demo disabled by default, see init.lua to enable it.
-- Git: https://gitlab.com/rautars/skylayer

-- License: MIT
-- Credits: rautars

-------------------------

local gradient_plain_with_clouds_sky = function(player_name)
	local sl = {}
	sl.name = "gradient_plain_with_clouds_sky"
	sl.sky_data = {
		gradient_colors = {
			{ r = 68, g = 34, b = 153 },
			{ r = 59, g = 12, b = 189 },
			{ r = 51, g = 17, b = 187 },
			{ r = 68, g = 68, b = 221 },
			{ r = 17, g = 170, b = 187 },
			{ r = 18, g = 189, b = 185 },
			{ r = 34, g = 204, b = 170 },
			{ r = 105, g = 208, b = 37 },
			{ r = 170, g = 204, b = 34 },
			{ r = 208, g = 195, b = 16 },
			{ r = 204, g = 187, b = 51 },
			{ r = 254, g = 174, b = 45 },
			{ r = 255, g = 153, b = 51 },
			{ r = 255, g = 102, b = 68 },
			{ r = 255, g = 68, b = 34 },
			{ r = 255, g = 51, b = 17 },
			{ r = 248, g = 12, b = 18 },
			{ r = 255, g = 51, b = 17 },
			{ r = 255, g = 68, b = 34 },
			{ r = 255, g = 102, b = 68 },
			{ r = 255, g = 153, b = 51 },
			{ r = 254, g = 174, b = 45 },
			{ r = 204, g = 187, b = 51 },
			{ r = 208, g = 195, b = 16 },
			{ r = 170, g = 204, b = 34 },
			{ r = 105, g = 208, b = 37 },
			{ r = 34, g = 204, b = 170 },
			{ r = 18, g = 189, b = 185 },
			{ r = 17, g = 170, b = 187 },
			{ r = 68, g = 68, b = 221 },
			{ r = 51, g = 17, b = 187 },
			{ r = 59, g = 12, b = 189 }
		}
	}
	sl.clouds_data = {
			density = 0.4,
			color = "#fff0f0e5",
			ambient =  "#000000",
			height = 120,
			thickness = 16,
			speed = { x = 110, z = -2 },
	}
	sl.sun_data = {
		visible = false
	}
	sl.moon_data = {
		visible = false
	}
	skylayer.add_layer(player_name, sl)
end

local plain_without_clouds_sky = function(player_name)
	local sl = {}
	sl.name = "plain_without_clouds_sky"
	sl.sky_data = {
		base_color = { r = 0, g = 0, b = 0 },
		clouds = false
	}
	skylayer.add_layer(player_name, sl)
end

local skybox_with_defaults_sky = function(player_name)
	local sl = {}
	sl.name = "skybox_with_defaults_sky"
	sl.sky_data = {
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
	skylayer.add_layer(player_name, sl)
end

local custom_moon_with_gradient_stars_sky = function(player_name)
	local sl = {}
	sl.name = "custom_moon_with_gradient_stars_sky"
	sl.moon_data = {
		texture = "skylayer_demo_cold_moon.png",
	}
	sl.stars_data = {
		scale = 2,
		gradient_star_colors = {
			{r=100, g=26, b=0},
			{r=100, g=76, b=0},
			{r=100, g=0, b=24},
		}
	}
	skylayer.add_layer(player_name, sl)
end

local custom_sun_with_default_sky = function(player_name)
	local sl = {}
	sl.name = "custom_sun_with_default_sky"
	sl.sun_data = {
		texture = "skylayer_demo_hot_sun.png",
		scale = 3
	}
	skylayer.add_layer(player_name, sl)
end

local plain_sky_colors_with_defaults_sky = function(player_name)
	local sl = {}
	sl.name = "plain_sky_colors_with_defaults_sky"
	sl.sky_data = {
		sky_color = {
			day_sky = "#FBF704",
			day_horizon = "#F704FB",
			dawn_sky = "#EB1914",
			dawn_horizon = "#49FF00",
			night_sky = "#0F00FF",
			night_horizon = "#FF5200",
			indoors = "#D9EE11",
			fog_sun_tint = "#E0901F",
			fog_moon_tint = "#6E9A65"
		}
	}
	skylayer.add_layer(player_name, sl)
end

local gradient_plain_sky_colors_with_defaults_sky = function(player_name)
	local sl = {}
	sl.name = "gradient_plain_sky_colors_with_defaults_sky"
	sl.sky_data = {
		gradient_sky = {
			day_sky = {
				{ r = 100, g = 0, b = 6},
				{ r = 6, g = 100, b = 0},
				{ r = 0, g = 6, b = 100}
			},
			day_horizon = {
				{ r = 100, g = 56, b = 0},
				{ r = 42, g = 100, b = 0},
				{ r = 92, g = 100, b = 0}
			},
			night_sky = {
				{ r = 0, g = 255, b = 87},
				{ r = 250, g = 187, b = 100},
				{ r = 255, g = 82, b = 0}
			},
			night_horizon = {
				{ r = 87, g = 100, b = 0},
				{ r = 0, g = 87, b = 100},
				{ r = 100, g = 0, b = 87}
			},
		}
	}
	skylayer.add_layer(player_name, sl)
end

local sky_definitions = {}
table.insert(sky_definitions, {name = "gradient_plain_with_clouds_sky", func = gradient_plain_with_clouds_sky})
table.insert(sky_definitions, {name = "plain_without_clouds_sky", func = plain_without_clouds_sky})
table.insert(sky_definitions, {name = "skybox_with_defaults_sky", func = skybox_with_defaults_sky})
table.insert(sky_definitions, {name = "custom_moon_with_gradient_stars_sky", func = custom_moon_with_gradient_stars_sky})
table.insert(sky_definitions, {name = "custom_sun_with_default_sky", func = custom_sun_with_default_sky})
table.insert(sky_definitions, {name = "plain_sky_colors_with_defaults_sky", func = plain_sky_colors_with_defaults_sky})
table.insert(sky_definitions, {name = "gradient_plain_sky_colors_with_defaults_sky", func = gradient_plain_sky_colors_with_defaults_sky})

-- register commands for demo for sky definitions from sky_definitions array
local counter = 1
for key, definition in pairs(sky_definitions) do
	minetest.register_chatcommand("sl_demo" .. counter .. "_on", {
		params = "<player_name>",
		description = "Sets sky ".. definition.name .." for a player",
		func = function(name, player_name)
			if player_name == nil or player_name == "" then
				player_name = name
			end
			definition.func(player_name)
		end
	})
	minetest.register_chatcommand("sl_demo" .. counter .. "_off", {
		params = "<player_name>",
		description = "Turn off sky ".. definition.name .. " for a player",
		func = function(name, player_name)
			if player_name == nil or player_name == "" then
				player_name = name
			end
			skylayer.remove_layer(player_name, definition.name)
		end
	})
	counter = counter + 1
end
