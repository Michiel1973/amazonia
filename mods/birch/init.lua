
--
-- Birch Tree
--

local modname = "birch"
local modpath = minetest.get_modpath(modname)

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

birch = {}


-- birch tree

local ai = {name = "air", param1 = 000}
local tr = {name = "birch:trunk", param1 = 255, force_place = true}
local lp = {name = "birch:leaves", param1 = 255}
local lr = {name = "birch:leaves", param1 = 255}

birch.birchtree = {

	size = {x = 5, y = 7, z = 5},

	data = {

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lr, lp, lp, lp, lr,
		lr, lp, lp, lp, lr,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lp, lp, lp, lp, lp,
		lp, lp, lp, lp, lp,
		ai, lr, lp, lr, ai,
		ai, ai, lp, ai, ai,

		ai, ai, tr, ai, ai,
		ai, ai, tr, ai, ai,
		ai, ai, tr, ai, ai,
		lp, lp, tr, lp, lp,
		lp, lp, tr, lp, lp,
		ai, lp, tr, lp, ai,
		ai, lp, lp, lp, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lp, lp, lp, lp, lp,
		lp, lp, lp, lp, lp,
		ai, lr, lp, lr, ai,
		ai, ai, lp, ai, ai,

		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,
		lr, lp, lp, lp, lr,
		lr, lp, lp, lp, lr,
		ai, ai, ai, ai, ai,
		ai, ai, ai, ai, ai,

	},

	yslice_prob = {
		{ypos = 1, prob = 127}
	},
}


local function grow_new_birch_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}, birch.birchtree, "0", nil, false)
end

--
-- Decoration
--


minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.008,
		scale = 0.001,
		spread = {x = 255, y = 255, z = 255},
		seed = 2,
		octaves = 3,
		persist = 0.67
	},
	biomes = {"grassland"},
	y_min = 10,
	y_max = 80,
	schematic = birch.birchtree,
	flags = "place_center_x, place_center_z",
})

--
-- Nodes
--

minetest.register_node("birch:sapling", {
	description = S("Birch Sapling"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"birch_sapling.png"},
	inventory_image = "birch_sapling.png",
	wield_image = "birch_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_birch_tree,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"birch:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

-- birch trunk
minetest.register_node("birch:trunk", {
	description = S("Birch Trunk"),
	tiles = {
		"birch_trunk_top.png",
		"birch_trunk_top.png",
		"birch_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	is_ground_content = false,
})

-- birch wood
minetest.register_node("birch:wood", {
	description = S("Birch Wood"),
	tiles = {"birch_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- birch tree leaves
minetest.register_node("birch:leaves", {
	description = S("Birch Leaves"),
	drawtype = "allfaces_optional",
	visual_scale = 1.2,
	tiles = {"birch_leaves.png"},
	inventory_image = "birch_leaves.png",
	wield_image = "birch_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"birch:sapling"}, rarity = 20},
			{items = {"birch:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "birch:wood 4",
	recipe = {{"birch:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "birch:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "birch:wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "birch:convert_birch_saplings_to_node_timer",
	nodenames = {"birch:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"birch:trunk"},
	leaves = {"birch:leaves"},
	radius = 3,
})

--Stairs

if minetest.get_modpath("stairs") ~= nil then	
	stairs.register_stair_and_slab(
		"birch_trunk",
		"birch:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"birch_wood.png"},
		S("Birch Tree Stair"),
		S("Birch Tree Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("bonemeal") ~= nil then	
	bonemeal:add_sapling({
		{"birch:sapling", grow_new_birch_tree, "soil"},
	})
end
