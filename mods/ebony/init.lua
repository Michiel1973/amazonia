--
-- Ebony
--

local modname = "ebony"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

-- Ebony

local function grow_new_ebony_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-5, y = pos.y, z = pos.z-5}, modpath.."/schematics/ebony.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.005,
			scale = 0.002,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"rainforest"},
		height = 2,
		y_min = 1,
		y_max = 62,
		schematic = modpath.."/schematics/ebony.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("ebony:sapling", {
	description = S("Ebony Tree Sapling"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"ebony_sapling.png"},
	inventory_image = "ebony_sapling.png",
	wield_image = "ebony_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_ebony_tree,
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
			"ebony:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("ebony:trunk", {
	description = S("Ebony Trunk"),
	tiles = {
		"ebony_trunk_top.png",
		"ebony_trunk_top.png",
		"ebony_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})

-- ebony wood
minetest.register_node("ebony:wood", {
	description = S("Ebony Wood"),
	tiles = {"ebony_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- ebony tree leaves
minetest.register_node("ebony:leaves", {
	description = S("Ebony Leaves"),
	drawtype = "allfaces_optional",
	visual_scale = 1.2,
	tiles = {"ebony_leaves.png"},
	inventory_image = "ebony_leaves.png",
	wield_image = "ebony_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ebony:sapling"}, rarity = 20},
			{items = {"ebony:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

--
-- Creeper/Vines...
--

minetest.register_node("ebony:creeper", {
	description = S("Ebony Creeper"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"ebony_creeper.png"},
	inventory_image = "ebony_creeper.png",
	wield_image = "ebony_creeper.png",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("ebony:creeper_leaves", {
	description = S("Ebony Creeper with Leaves"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"ebony_creeper_leaves.png"},
	inventory_image = "ebony_creeper_leaves.png",
	wield_image = "ebony_creeper_leaves.png",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("ebony:liana", {
	description = S("Ebony Liana"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"ebony_liana.png"},
	inventory_image = "ebony_liana.png",
	wield_image = "ebony_liana.png",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1,
	},
	sounds = default.node_sound_leaves_defaults(),
})

--Persimmon Kaki

minetest.register_node("ebony:persimmon", {
	description = S("Persimmon"),
	drawtype = "plantlike",
	tiles = {"ebony_persimmon.png"},
	inventory_image = "ebony_persimmon.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "ebony:persimmon", param2 = 1})
	end,
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "ebony:wood 4",
	recipe = {{"ebony:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "ebony:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "ebony:wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "ebony:convert_ebony_saplings_to_node_timer",
	nodenames = {"ebony:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"ebony:trunk"},
	leaves = {"ebony:leaves"},
	radius = 3,
})

--Stairs

if minetest.get_modpath("stairs") ~= nil then	
	stairs.register_stair_and_slab(
		"ebony_trunk",
		"ebony:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"ebony_wood.png"},
		S("Ebony Stair"),
		S("Ebony Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("bonemeal") ~= nil then	
	bonemeal:add_sapling({
		{"ebony:sapling", grow_new_ebony_tree, "soil"},
	})
end
