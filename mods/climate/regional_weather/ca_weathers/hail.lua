local name = "regional_weather:hail"

local conditions = {
	min_height			= regional_weather.settings.min_height,
	max_height			= regional_weather.settings.max_height,
	--min_heat				= -5,
	max_heat				= 20,
	min_humidity			= 40,
	min_windspeed			= 2.5,
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

effects["climate_api:damage"] = {
	rarity = 15,
	value = 3,
	check = {
		type = "raycast",
		height = 7,
		velocity = 20
	}
}

effects["climate_api:sound"] = {
	name = "weather_hail",
	gain = 1
}

effects["regional_weather:lightning"] = 1 / 30

local textures = {}
for i = 1,5 do
	textures[i] = "weather_hail" .. i .. ".png"
end

effects["climate_api:particles"] = {
	boxsize = { x = 18, y = 0, z = 18 },
	v_offset = 7,
	velocity = 20,
	amount = 6,
	expirationtime = 0.7,
	texture = textures,
	glow = 5
}

climate_api.register_weather(name, conditions, effects)
