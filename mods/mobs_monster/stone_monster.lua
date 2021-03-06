
local S = mobs.intllib


-- Stone Monster by PilzAdam

mobs:register_mob("mobs_monster:stone_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 3,
	damage = 20,
	hp_min = 50,
	hp_max = 70,
	armor = 90,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.b3d",
	textures = {
		{"mobs_stone_monster.png"},
		{"mobs_stone_monster2.png"}, -- by AMMOnym
	},
	blood_amount = 15,
	blood_texture = "mobs_blood_stone.png",
	makes_footstep_sound = true,
	sounds = {
		random = {"mobs_stonemonster","mobs_stonemonster2","mobs_stonemonster3","mobs_stonemonster4",},
		war_cry = {"mobs_stonemonster","mobs_stonemonster2","mobs_stonemonster3","mobs_stonemonster4",},
		attack = {"mobs_stonemonster","mobs_stonemonster2","mobs_stonemonster3","mobs_stonemonster4",},
		death = {"mobs_stonemonster","mobs_stonemonster2","mobs_stonemonster3","mobs_stonemonster4",},
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump_height = 0,
	stepheight = 1.1,
	step_height = 1.1,
	floats = 0,
	view_range = 10,
	drops = {
		{name = "default:cobble", chance = 1, min = 0, max = 2},
		{name = "default:coal_lump", chance = 3, min = 0, max = 2},
		{name = "default:coalblock", chance = 3, min = 0, max = 3},
		{name = "default:diamondblock", chance = 9, min = 0, max = 1},
		{name = "default:iron_lump", chance = 5, min = 0, max = 4},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	},
	immune_to = {
		{"default:pick_wood", 0}, -- wooden pick doesnt hurt stone monster
		{"default:pick_stone", 4}, -- picks deal more damage to stone monster
		{"default:pick_bronze", 5},
		{"default:pick_steel", 5},
		{"default:pick_mese", 6},
		{"default:pick_diamond", 7},
	},
})


mobs:register_egg("mobs_monster:stone_monster", S("Stone Monster"), "default_stone.png", 1)
mobs:alias_mob("mobs:stone_monster", "mobs_monster:stone_monster") -- compatibility
