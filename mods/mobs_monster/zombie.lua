
-- Zombie by BlockMen

mobs:register_mob("mobs_monster:zombie", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	damage = 3,
	hp_min = 12,
	hp_max = 35,
	armor = 150,
	collisionbox = {-0.25, -1, -0.3, 0.25, 0.75, 0.3},
	visual = "mesh",
	mesh = "zombie.x",
	textures = {
		{"mobs_zombie.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_zombie.1",
		damage = "mobs_zombie_hit",
		attack = "mobs_zombie.3",
		death = "mobs_zombie_death",
	},
	walk_velocity = 0.5,
	run_velocity = 0.5,
	jump = true,
	floats = 0,
	view_range = 10,
	drops = {
		{name = "mobs_monster:rotten_flesh",
		chance = 2, min = 3, max = 5,},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 10,		speed_run = 15,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 188,
		run_start = 168,		run_end = 188,
--		punch_start = 168,		punch_end = 188,
	},
})



mobs:register_egg("mobs_monster:zombie", "Zombie", "zombie_head.png", 0)

minetest.register_craftitem("mobs_monster:rotten_flesh", {
	description = "Rotten Flesh",
	inventory_image = "mobs_rotten_flesh.png",
	on_use = minetest.item_eat(-5),
})
