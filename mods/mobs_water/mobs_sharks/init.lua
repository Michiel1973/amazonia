
if minetest.get_modpath("mobs") and not mobs.mod and mobs.mod ~= "redo" then
	minetest.log("error", "[mobs_sharks] mobs redo API not found!")
	return
end

-- local variables
local l_colors = {
	"#604000:175",	--brown
	"#ffffff:150",	--white
	"#404040:150",	--dark_grey
	"#a0a0a0:150"	--grey
}
local l_skins = {
	{
		"(shark_first.png^[colorize:" .. l_colors[3]
		.. ")^(shark_second.png^[colorize:" .. l_colors[4]
		.. ")^shark_third.png"
	},
	{
		"(shark_first.png^[colorize:" .. l_colors[1]
		.. ")^(shark_second.png^[colorize:" .. l_colors[2]
		..")^shark_third.png"
	},
	{
		"(shark_first.png^[colorize:" .. l_colors[4]
		.. ")^(shark_second.png^[colorize:" .. l_colors[2]
		.. ")^shark_third.png"
	}
}
local l_anims = {
	speed_normal = 24,	speed_run = 24,
	stand_start = 1,	stand_end = 80,
	walk_start = 80,	walk_end = 160,
	run_start = 80,		run_end = 160
}
local l_model = "mob_shark.b3d"
local l_egg_texture = "mob_shark_shark_item.png"
local l_spawn_in = {"default:water_source"}
local l_spawn_near = {"default:water_source"}
local l_spawn_chance = 60000

-- load settings
dofile(minetest.get_modpath("mobs_sharks").."/SETTINGS.txt")
if not ENABLE_SHARK_LARGE then
	l_spawn_chance = l_spawn_chance - 20000
end
if not ENABLE_SHARK_MEDIUM then
	l_spawn_chance = l_spawn_chance - 20000
end
if not ENABLE_SHARK_SMALL then
	l_spawn_chance = l_spawn_chance - 20000
end

-- large
if ENABLE_SHARK_LARGE then

	mobs:register_mob("mobs_sharks:shark_lg", {
		type = "animal",
		attack_type = "dogfight",
		specific_attack = {"mobs_squid:squid"},
		damage = 10,
		reach = 3,
		hp_min = 20,
		hp_max = 25,
		armor = 150,
		collisionbox = {-0.75, -0.5, -0.75, 0.75, 0.5, 0.75},
		visual = "mesh",
		mesh = l_model,
		textures = l_skins,
		makes_footstep_sound = false,
		walk_velocity = 4,
		run_velocity = 6,
		fly = true,
		fly_in = "default:water_source",
		fall_speed = 0,
		rotate = 270,
		view_range = 6,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = l_anims,
		jump = false,
		stepheight = 0.1,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
		},
	})

	mobs:spawn({
		name = "mobs_sharks:shark_lg",
		nodes = l_spawn_in,
		neighbors = l_spawn_near,
		interval = 60,
		chance = 100,
		max_height = -30,
		min_height = -120,
		active_object_count = 1,
	})

	mobs:register_egg("mobs_sharks:shark_lg", "Shark (large)", l_egg_texture, 0)
end

-- medium
if ENABLE_SHARK_MEDIUM then

	mobs:register_mob("mobs_sharks:shark_md", {
		type = "animal",
		attack_type = "dogfight",
		specific_attack = {"mobs_squid:squid"},
		damage = 8,
		reach = 2,
		hp_min = 15,
		hp_max = 20,
		armor = 125,
		collisionbox = {-0.57, -0.38, -0.57, 0.57, 0.38, 0.57},
		visual = "mesh",
		visual_size = {x = 0.75, y = 0.75},
		mesh = l_model,
		textures = l_skins,
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 4,
		fly = true,
		fly_in = "default:water_source",
		fall_speed = -1,
		rotate = 270,
		view_range = 6,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = l_anims,
		jump = false,
		stepheight = 0.1,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
		},
	})

	mobs:spawn({
		name = "mobs_sharks:shark_md",
		nodes = l_spawn_in,
		neighbors = l_spawn_near,
		interval = 60,
		chance = 100,
		max_height = -20,
		min_height = -150,
		active_object_count = 1,
	})

	mobs:register_egg("mobs_sharks:shark_md", "Shark (medium)", l_egg_texture, 0)
end

-- small
if ENABLE_SHARK_SMALL then

	mobs:register_mob("mobs_sharks:shark_sm", {
		type = "animal",
		attack_type = "dogfight",
		specific_attack = {"mobs_squid:squid"},
		damage = 6,
		reach = 1,
		hp_min = 10,
		hp_max = 15,
		armor = 100,
		collisionbox = {-0.38, -0.25, -0.38, 0.38, 0.25, 0.38},
		visual = "mesh",
		visual_size = {x = 0.5, y = 0.5},
		mesh = l_model,
		textures = l_skins,
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 4,
		fly = true,
		fly_in = "default:water_source",
		fall_speed = -1,
		rotate = 270,
		view_range = 6,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = l_anims,
		jump = false,
		stepheight = 0.1,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
		},
	})

	mobs:spawn({
		name = "mobs_sharks:shark_sm",
		nodes = l_spawn_in,
		neighbors = l_spawn_near,
		interval = 60,
		chance = 500,
		max_height = -15,
		min_height = -100,
		active_object_count = 1,
	})

	mobs:register_egg("mobs_sharks:shark_sm", "Shark (small)", l_egg_texture, 0)
end
