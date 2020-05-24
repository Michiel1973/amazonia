local name = "regional_weather:snow"

local conditions = {
	min_height = regional_weather.settings.min_height,
	max_height = regional_weather.settings.max_height,
	max_heat				= 20,
	min_humidity		= 10,
	max_humidity		= 65,
	daylight				= 15,
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

local textures = {}
for i = 1,12,1 do
	textures[i] = "weather_snowflake" .. i .. ".png"
end

effects["climate_api:particles"] = {
	boxsize = { x = 24, y = 6, z = 24 },
	v_offset = 2,
	amount = 4,
	expirationtime = 7,
	velocity = 0.85,
	acceleration = -0.06,
	texture = textures,
	glow = 6
}

climate_api.register_weather(name, conditions, effects)
