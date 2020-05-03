
mobs:register_mob("skywhale:whale", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 25,
	hp_max = 35,
	armor = 100,
	collisionbox = {-8, -4, -8, 8, 4, 8},
	visual = "mesh",
	mesh = "whale.b3d",
	textures = {
		{"whale.png"},
	},
	rotate = 180,
	visual_size = {x=2, y=2},
	makes_footstep_sound = false,
	walk_velocity = 3,
	run_velocity = 3,
	jump = false,	
	stepheight = 0,
	fall_damage = 0,
	glow = 2,
	fly = true,
	fly_in = "air",
	keep_flying = true,
	stand_chance = 0,
	walk_chance = 100,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	view_range = 4,
	-- drops = {
		-- {name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	-- },
	sounds = {
      random = "whale_1",
      death = "whale_1",
      distance = 15,
	},
	animation = {
		speed_normal = 0.1,
		speed_run = 0.5,
		walk_start = 2,
		walk_end = 28,
		stand_start = 30,
		stand_end = 50,
		run_start = 2,
		run_end = 28,

	},
})


mobs:register_egg("skywhale:whale", "Skywhale", "default_water.png", 1)

mobs:spawn({
       name = "skywhale:whale",
       nodes = "air",
	   neighbors = "air",
	   min_light = 0,
       max_light = 14,
	   min_height = 7000,
	   max_height = 7200,
	   active_object_count = 1,
	   interval = 60,
	   chance = 5000,
    })