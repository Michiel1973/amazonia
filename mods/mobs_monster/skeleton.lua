--from MCmobs v0.4 by
--maikerumine
--made for MC like Survival game
--License for code WTFPL and otherwise stated in readmes

-- intllib
local MP = minetest.get_modpath(minetest.get_current_modname())
-- local S, NS = dofile(MP.."/intllib.lua")

--###################
--################### SKELETON
--###################



local skeleton = {
	type = "monster",
	hp_min = 40,
	hp_max = 80,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 1.98, 0.3},
	pathfinding = 1,
	group_attack = true,
	visual = "mesh",
	mesh = "mobs_skeleton.b3d",
	textures = {
		{"skeleton.png^skeleton_bow.png"},
	},
	visual_size = {x=3, y=3},
	makes_footstep_sound = true,
	sounds = {
		random = "skeleton1",
		death = "skeletondeath",
		damage = "skeletonhurt",
		distance = 16,
	},
	walk_velocity = 1.2,
	run_velocity = 2.4,
	damage = 25,
	glow = 1,
	reach = 3,
	-- drops = {
		-- {name = mobs_monster.items.arrow,
		-- chance = 1,
		-- min = 0,
		-- max = 2,},
		-- {name = mobs_monster.items.bow,
		-- chance = 11,
		-- min = 1,
		-- max = 1,},
		-- {name = mobs_monster.items.bone,
		-- chance = 1,
		-- min = 0,
		-- max = 2,},
		--},
		--},
	animation = {
		stand_start = 0,
		stand_end = 40,
		stand_speed = 5,
		walk_start = 40,
		walk_end = 60,
	        walk_speed = 15,
		run_start = 40,
		run_end = 60,
		run_speed = 30,
	        shoot_start = 70,
	        shoot_end = 90,
	        punch_start = 70,
	        punch_end = 90,
		-- TODO: Implement and fix death animation
	        --die_start = 120,
	        --die_end = 130,
		--die_loop = false,
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	view_range = 10,
	fear_height = 4,
	attack_type = "dogshoot",
	arrow = "mobs_monster:arrow_entity",
	shoot_interval = 2.5,
	shoot_offset = 1,
	dogshoot_switch = 1,
	dogshoot_count_max =1.8,
	blood_amount = 0,
}

-- compatibility
mobs:alias_mob("mobs:skeleton", "mobs_monster:skeleton")

-- spawn eggs
mobs:register_egg("mobs_monster:skeleton", ("Skeleton"), "spawn_icon_skeleton.png", 0)

