
local S = mobs.intllib


-- Oerkki by PilzAdam

mobs:register_mob("mobs_monster:oerkki", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	--pathfinding = 1,
	reach = 3,
	--nametag = "oerkki test",
	damage = 30,
	hp_min = 50,
	hp_max = 70,
	armor = 95,
	knock_back = false,
	glow = 3,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "mobs_oerkki.b3d",
	textures = {
		{"mobs_oerkki.png"},
		{"mobs_oerkki2.png"},
	},
	blood_amount = 10,
	blood_texture = "mobs_blood_black.png",
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_oerkki",
	},
	walk_velocity = 1,
	run_velocity = 3,
	view_range = 15,
	group_attack = true,
	group_helper = {"mobs_monster:oerkki"},
	jump = true,
	jump_height = 2.1,
	stepheight = 1.1,
	step_height = 1.1,
	drops = {
		{name = "default:obsidian", chance = 3, min = 0, max = 2},
		{name = "default:gold_lump", chance = 2, min = 0, max = 2},
		{name = "mobs_monster:oerkki_heart", chance = 4, min = 0, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	animation = {
		stand_start = 0,
		stand_end = 23,
		walk_start = 24,
		walk_end = 36,
		run_start = 37,
		run_end = 49,
		punch_start = 37,
		punch_end = 49,
		speed_normal = 15,
		speed_run = 15,
	},
	replace_rate = 5,
	replace_what = {"default:torch"},
	replace_with = "air",
	replace_offset = -1,
	immune_to = {
		{"default:default:sword_steel", 20}, -- no damage
		{"default:sword_diamond", 0}, -- no damage
		{"moreores:sword_mithril", 0}, -- no damage
		{"default:gold_lump", -10}, -- heals by 10 points
	},
})


mobs:register_egg("mobs_monster:oerkki", S("Oerkki"), "default_obsidian.png", 1)
mobs:alias_mob("mobs:oerkki", "mobs_monster:oerkki") -- compatiblity
