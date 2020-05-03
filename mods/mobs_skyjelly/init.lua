-- local variables
local l_colors = {
	"#ff0000:150",
	"#00ffff:150",
	"#0000ff:150",
	"#ff00ff:150",
	"#ffff00:150",
}
local l_skins = {
	{
		"(jellyfish.png^[colorize:" .. l_colors[1]
		.. ")"
	},
	{
		"(jellyfish.png^[colorize:" .. l_colors[2]
		.. ")"
	},
	{
		"(jellyfish.png^[colorize:" .. l_colors[3]
		.. ")"
	},
	{
		"(jellyfish.png^[colorize:" .. l_colors[4]
		.. ")"
	},
	{
		"(jellyfish.png^[colorize:" .. l_colors[5]
		.. ")"
	}
}

mobs:register_mob("mobs_skyjelly:jellyfish", {
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	damage = 0,
	reach = 1,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-2, -2, -2, 2, 2, 2},
	visual = "mesh",
	mesh = "jellyfish.b3d",
	visual_size = {x=12, y=12},
	textures = l_skins,
	makes_footstep_sound = false,
	walk_velocity = 0.2,
	run_velocity = 0.2,
	stepheight = 0,
	fall_damage = 0,
	glow = 3,
	fly = true,
	fly_in = "air",
	view_range = 3,
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
})

mobs:spawn({
	name = "mobs_skyjelly:jellyfish",
	nodes = "cloudlands:dirt_with_grass",
	neighbors = "air",
	min_light = 0,
	max_light = 14,
	interval = 30,
	chance = 5000,
	active_object_count = 6,
	min_height = 7000,
	max_height = 7200,
})

mobs:register_egg("mobs_skyjelly:jellyfish", "Skyjelly", "jellyfish_inv.png", 0)
