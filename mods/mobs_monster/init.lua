
local path = minetest.get_modpath("mobs_monster")

-- Intllib
local S
if minetest.global_exists("intllib") then
	if intllib.make_gettext_pair then
		-- New method using gettext.
		S = intllib.make_gettext_pair()
	else
		-- Old method using text files.
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end
mobs.intllib = S

-- TOPOLOGY
-- caverealms  -1500  to -10033
-- CR DM       -8000  to -9999
-- DF level 1  -10033 to -12032
-- DF level 2  -12032 to -14032
-- DF level 3  -14032 to -15072
-- Sunless Sea -15072 to -16000
-- Oil Sea     -16000 to -17000
-- Lava Sea    -17000 to -18000
-- Underworld  -18000 to -19073
-- Primordial  -19073 to -22032
-- Nether      -25000 to -30000

-- throwing
dofile(path .. "/zzzthrowing.lua")

-- bring on the monsters
dofile(path .. "/dirt_monster.lua")              -- 
dofile(path .. "/dungeon_master.lua")            -- caverealms -8000 to -9999
dofile(path .. "/oerkki.lua")                    -- nether -25000 to -30000
dofile(path .. "/sand_monster.lua")              -- 
dofile(path .. "/stone_monster.lua")             -- caverealms
dofile(path .. "/tree_monster.lua")              -- primordial
dofile(path .. "/lava_flan.lua")                 -- lava sea?
-- dofile(path .. "/mese_monster.lua")			 -- not using (silly)
dofile(path .. "/spider.lua")                    -- 
dofile(path .. "/zombie.lua")                    -- underworld -18000 to -19073??
-- dofile(path .. "/ghost.lua") 				 -- not using (texture issue)
dofile(path .. "/slime.lua")                     -- DF L1 and caverealms
dofile(path .. "/skeleton.lua")                  -- skeletons for nether
--  dofile(path .. "/banshee.lua")               -- banshee (WIP)
dofile(path .. "/mothman.lua")                   -- DF L3
dofile(path .. "/creeper.lua")                   -- DF L3



-- put the monsters into the world
dofile(path .. "/zzzspawn.lua")

-- other stuff
dofile(path .. "/lucky_block.lua")

print ("[MOD] Mobs Redo Monsters loaded")
