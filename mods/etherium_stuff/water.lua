
minetest.register_node("etherium_stuff:crystal_water_source", {
	description = "Crystal Water Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "etherium_crystal_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "etherium_crystal_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	alpha = 200,
	paramtype = "light",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "etherium_stuff:crystal_water_flowing",
	liquid_alternative_source = "etherium_stuff:crystal_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 2, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("etherium_stuff:crystal_water_flowing", {
	description = "Flowing Crystal Water",
	drawtype = "flowingliquid",
	tiles = {"etherium_crystal_water.png"},
	special_tiles = {
		{
			name = "etherium_crystal_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "etherium_crystal_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	alpha = 200,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "etherium_stuff:crystal_water_flowing",
	liquid_alternative_source = "etherium_stuff:crystal_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 2, cools_lava = 1,
		not_in_creative_inventory = 1},
	sounds = default.node_sound_water_defaults(),
})

bucket.register_liquid(
	"etherium_stuff:crystal_water_source",
	"etherium_stuff:crystal_water_flowing",
	"etherium_stuff:bucket_crystal_water",
	"bucket_crystal_water.png",
	"Crystal Water Bucket",
	{tool = 1, water_bucket = 1},
	true
)