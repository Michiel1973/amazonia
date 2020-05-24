local name = "regional_weather:nether_heavy"

local conditions = {
	min_height = -31000,
	max_height = -25000,
	-- max_heat				= 99,
	min_humidity		= 71,
	-- daylight				= 0
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
	texture = "weather_nether.png",
	glow = 6
}

climate_api.register_weather(name, conditions, effects)
