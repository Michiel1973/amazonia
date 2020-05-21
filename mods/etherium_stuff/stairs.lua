
local S = etherium_stuff.intllib

-- Stairs Redo
if stairs and stairs.mod and stairs.mod == "redo" then

stairs.register_all("etherium_sandstone", "etherium_stuff:sandstone",
	{crumbly = 1, cracky = 3},
	{"etherium_sandstone.png"},
	S("Etherium Sandstone Stair"),
	S("Etherium Sandstone Slab"),
	default.node_sound_stone_defaults())

stairs.register_all("etherium_sandstone_brick", "etherium_stuff:sandstone_brick",
	{cracky = 2},
	{"etherium_sandstone_brick.png"},
	S("Etherium Sandstone Brick Stair"),
	S("Etherium Sandstone Brick Slab"),
	default.node_sound_stone_defaults())

stairs.register_all("etherium_sandstone_block", "etherium_stuff:sandstone_block",
	{cracky = 2},
	{"etherium_sandstone_block.png"},
	S("Etherium Sandstone Block Stair"),
	S("Etherium Sandstone Block Slab"),
	default.node_sound_stone_defaults())

stairs.register_all("etherium_glass", "etherium_stuff:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"etherium_glass.png"},
	S("Etherium Glass Stair"),
	S("Etherium Glass Slab"),
	default.node_sound_glass_defaults())

stairs.register_all("etherium_crystal_glass", "etherium_stuff:crystal_glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"etherium_crystal_glass.png"},
	S("Etherium Crystal Glass Stair"),
	S("Etherium Crystal Glass Slab"),
	default.node_sound_glass_defaults(),
	default.LIGHT_MAX - 1)


-- Stairs Plus (in More Blocks)
elseif minetest.global_exists("stairsplus") then

stairsplus:register_all("etherium_stuff", "sandstone", "etherium_stuff:sandstone", {
	description = S("Etherium Sandstone"),
	tiles = {"etherium_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

stairsplus:register_all("etherium_stuff", "sandstone_brick", "etherium_stuff:sandstone_brick", {
	description = S("Etherium Sandstone Brick"),
	tiles = {"etherium_sandstone_brick.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

stairsplus:register_all("etherium_stuff", "sandstone_block", "etherium_stuff:sandstone_block", {
	description = S("Etherium Sandstone Block"),
	tiles = {"etherium_sandstone_block.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

stairsplus:register_all("etherium_stuff", "glass", "etherium_stuff:glass", {
	description = S("Etherium Glass"),
	tiles = {"etherium_glass.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	drawtype = "glasslike_framed_optional",
	paramtype = "light",
	--paramtype2 = "glasslikeliquidlevel",
})

stairsplus:register_all("etherium_stuff", "crystal_glass", "etherium_stuff:crystal_glass", {
	description = S("Etherium Crystal Glass"),
	tiles = {"etherium_crystal_glass.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	drawtype = "glasslike_framed_optional",
	paramtype = "light",
	--paramtype2 = "glasslikeliquidlevel",
	light_source = default.LIGHT_MAX - 1,
})

-- Default Stairs
else

stairs.register_stair_and_slab("etherium_sandstone", "etherium_stuff:sandstone",
	{crumbly = 1, cracky = 3},
	{"etherium_sandstone.png"},
	S("Etherium Sandstone Stair"),
	S("Etherium Sandstone Slab"),
	default.node_sound_stone_defaults())

stairs.register_stair_and_slab("etherium_sandstone_brick", "etherium_stuff:sandstone_brick",
	{cracky = 2},
	{"etherium_sandstone_brick.png"},
	S("Etherium Sandstone Brick Stair"),
	S("Etherium Sandstone Brick Slab"),
	default.node_sound_stone_defaults())

stairs.register_stair_and_slab("etherium_sandstone_block", "etherium_stuff:sandstone_block",
	{cracky = 2},
	{"etherium_sandstone_block.png"},
	S("Etherium Sandstone Block Stair"),
	S("Etherium Sandstone Block Slab"),
	default.node_sound_stone_defaults())

stairs.register_stair_and_slab("etherium_glass", "etherium_stuff:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"etherium_glass.png"},
	S("Etherium Glass Stair"),
	S("Etherium Glass Slab"),
	default.node_sound_glass_defaults())

stairs.register_stair_and_slab("etherium_crystal_glass", "etherium_stuff:crystal_glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"etherium_crystal_glass.png"},
	S("Etherium Crystal Glass Stair"),
	S("Etherium Crystal Glass Slab"),
	default.node_sound_glass_defaults(),
	default.LIGHT_MAX - 1)

end