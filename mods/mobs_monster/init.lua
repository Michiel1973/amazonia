
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

-- Monsters

dofile(path .. "/dirt_monster.lua")              -- PilzAdam
dofile(path .. "/dungeon_master.lua")            -- caverealms -8000 to -9999
dofile(path .. "/oerkki.lua")                    -- nether -25000 to -30000
dofile(path .. "/sand_monster.lua")              -- 
dofile(path .. "/stone_monster.lua")             -- 
dofile(path .. "/tree_monster.lua")              -- primordial -19073 to -22032
dofile(path .. "/lava_flan.lua")                 -- lava sea -17000 to -18000
dofile(path .. "/mese_monster.lua")
dofile(path .. "/spider.lua")                    -- 
dofile(path .. "/zombie.lua")                    -- underworld -18000 to -19073

-- dmobs use
-- stone golem
-- nyan cat
--flying pig
-- ogre + orc need work no damage, too large?
-- skeleton need work




dofile(path .. "/lucky_block.lua")

print ("[MOD] Mobs Redo Monsters loaded")
