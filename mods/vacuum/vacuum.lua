

minetest.register_node("vacuum:vacuum", {
	description = "Vacuum",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "airlike",
	drowning = 1,
	post_effect_color = {a = 10, r = 0, g = 0, b = 10},
	tiles = {"vacuum_texture.png"},
	alpha = 0,
	--use_texture_alpha  = true,
	groups = {not_in_creative_inventory=1, not_blocking_trains=1, cools_lava=1},
	paramtype = "light",
	--light_source = minetest.LIGHT_MAX,-- TOOD: test
	drop = {},
	sunlight_propagates = true
})
