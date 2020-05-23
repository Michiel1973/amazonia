local name = "regional_weather:nether"

local conditions = {
	min_height = -31000,
	max_height = -25000,
	-- max_heat				= 35,
	-- min_humidity		= 50,
	-- max_humidity		= 65,
	-- daylight				= 15
}

local effects = {}

local textures = {}
for i = 1,12,1 do
	textures[i] = "netherflake" .. i .. ".png"
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
