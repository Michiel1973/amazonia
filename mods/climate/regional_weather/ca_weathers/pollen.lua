local name = "regional_weather:pollen"

local conditions = {
	min_height			= regional_weather.settings.min_height,
	max_height			= regional_weather.settings.max_height,
	min_heat				= 40,
	min_humidity			= 30,
	max_humidity			= 40,
	max_windspeed			= 2,
	daylight				= 15,
	has_biome				= {
		"default",
		"default_deciduous_forest",
		"default_deciduous_forest_ocean",
		"default_deciduous_forest_shore",
		"default_grassland",
		"default_grassland_dunes",
		"default_grassland_ocean",
		"default_snowy_grassland",
		"default_snowy_grassland_ocean",
		"ethereal_grassy",
		"ethereal_grassy_ocean",
		"ethereal_grassytwo",
		"ethereal_grassytwo_ocean",
		"ethereal_mushroom",
		"ethereal_mushroom_ocean",
		"ethereal_plains",
		"ethereal_plains_ocean",
		"ethereal_sakura",
		"ethereal_sakura_ocean",
		"ethereal_grove",
		"aotearoa_pohutukawa_forest",
		"aotearoa_kauri_forest",
		"aotearoa_northern_podocarp_forest",
		"aotearoa_tawa_forest",
		"aotearoa_maire_forest",
		"aotearoa_southern_podocarp_forest",
		"aotearoa_hinau_forest",
		"aotearoa_beech_forest",
		"aotearoa_fiordland_forest",
		"aotearoa_kamahi_forest",
		"aotearoa_pohutukawa_forest",
	}
}

local effects = {}

effects["climate_api:particles"] = {
	boxsize = { x = 24, y = 0, z = 24 },
	vbox = 5,
	v_offset = -1,
	velocity = -0.1,
	acceleration = -0.03,
	expirationtime = 5,
	size = 0.8,
	texture = "weather_pollen.png",
	glow = 2
}

climate_api.register_weather(name, conditions, effects)
