local name = "regional_weather:snow_heavy"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	max_heat				= 0,
	min_humidity			= 65,
	daylight				= 15
	has_biome				= {
		"default_icesheet",
		"default_tundra_highland",
		"default_tundra",
		"default_tundra_beach",
		"default_taiga",
		"default_snowy_grassland",
		"ethereal_mountain",
		"ethereal_glacier",
		"ethereal_alpine",
		"ethereal_frost",
		"default_tundra_highland",
		"aotearoa_pahautea_forest",
		"aotearoa_mountain_tussock",
		"aotearoa_mountain_beech_forest",
		"aotearoa_fellfield",
		"aotearoa_alpine_snow",
		"aotearoa_glacier",
		"aotearoa_volcano"
	}
}

local effects = {}

effects["climate_api:skybox"] = {
	cloud_data = {
		color = "#5e676eb5"
	},
	priority = 11
}

effects["climate_api:hud_overlay"] = {
	file = "weather_hud_frost.png",
	z_index = -100,
	color_correction = true
}

effects["climate_api:particles"] = {
	boxsize = { x = 14, y = 3, z = 14 },
	v_offset = 3,
	expirationtime = 7.5,
	size = 15,
	amount = 6,
	velocity = 0.75,
	texture = "weather_snow.png",
	glow = 6
}

climate_api.register_weather(name, conditions, effects)
