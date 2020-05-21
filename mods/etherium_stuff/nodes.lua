local S = etherium_stuff.intllib

minetest.register_node("etherium_stuff:sand", {
	description = S("Etherium Sand"),
	tiles = {"etherium_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})


minetest.register_node("etherium_stuff:sandstone", {
	description = S("Etherium Sandstone"),
	tiles = {"etherium_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("etherium_stuff:sandstone_brick", {
	description = S("Etherium Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"etherium_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("etherium_stuff:sandstone_block", {
	description = S("Etherium Sandstone Block"),
	tiles = {"etherium_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("etherium_stuff:glass", {
	description = S("Etherium Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"etherium_glass.png", "etherium_glass_detail.png"},
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("etherium_stuff:crystal_glass", {
	description = S("Etherium Crystal Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"etherium_crystal_glass.png", "etherium_crystal_glass_detail.png"},
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	light_source = default.LIGHT_MAX - 1,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("etherium_stuff:sandstone_light_block", {
	description = S("Etherium Sandstone Light Block"),
	tiles = {"etherium_sandstone_light_block.png"},
	paramtype = "light",
	light_source = 12,
	groups = {cracky = 2, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults()
	})

