local CONFIG_FILE_PREFIX = "caverealms."

-- caverealms start -1500
-- deep caves       -6000
-- DM realm         -8000 to -9999
-- caverealms end   -10033
-- DF level1 start  -10033
-- DF level2 start  -12032
-- DF level3 start  -14032
-- sunless sea      -15072
-- oil sea          -16000
-- lava sea         -17000
-- underworld       -18000
-- primordial start -19073
-- primordial end   -21032
-- nether           -25000
-- basement floor   -31000


caverealms.config = {}

-- This function based on kaeza/minetest-irc/config.lua and used under the
-- terms of BSD 2-clause license.
local function setting(stype, name, default)
	local value
	if stype == "bool" then
		value = minetest.settings:get_bool(CONFIG_FILE_PREFIX..name)
	elseif stype == "string" then
		value = minetest.settings:get(CONFIG_FILE_PREFIX..name)
	elseif stype == "number" then
		value = tonumber(minetest.settings:get(CONFIG_FILE_PREFIX..name))
	end
	if value == nil then
		value = default
	end
	caverealms.config[name] = value
end

--generation settings
setting("number", "ymin", -10033) --bottom realm limit
setting("number", "ymax", -1500) --top realm limit
setting("number", "tcave", 0.75) --cave threshold

--decoration chances
setting("number", "stagcha", 0.003) --chance of stalagmites
setting("number", "stalcha", 0.003) --chance of stalactites

setting("number", "h_lag", 8) --max height for stalagmites
setting("number", "h_lac", 8) --...stalactites
setting("number", "crystal", 0.0002) --chance of glow crystal formations
setting("number", "h_cry", 8) --max height of glow crystals
setting("number", "h_clac", 8) --max height of glow crystal stalactites

setting("number", "gemcha", 0.03) --chance of small glow gems
setting("number", "mushcha", 0.04) --chance of mushrooms
setting("number", "myccha", 0.03) --chance of mycena mushrooms
setting("number", "wormcha", 0.015) --chance of glow worms
setting("number", "giantcha", 0.001) --chance of giant mushrooms
setting("number", "icicha", 0.035) --chance of icicles
setting("number", "flacha", 0.04) --chance of constant flames

--realm limits for Dungeon Masters' Lair
setting("number", "dm_top", -8000) --upper limit
setting("number", "dm_bot", -9999) --lower limit

--should DMs spawn in DM Lair?
setting("bool", "dm_spawn", true) 

--Deep cave settings
setting("number", "deep_cave", -6000) -- upper limit
