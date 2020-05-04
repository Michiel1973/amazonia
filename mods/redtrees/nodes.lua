--Kaeza's Internationalization Library support
	-- Boilerplate to support localized strings if intllib mod is installed.
	local S
	if minetest.get_modpath("intllib") then
		S = intllib.Getter()
	else
		-- If you don't use insertions (@1, @2, etc) you can use this:
		S = function(s) return s end
	end
--Akai ki
--Miki
minetest.register_node("redtrees:rtree", {
	description = S("Fiery Tree"),
	tiles = {"redtrees_tree_top.png", "redtrees_tree_top.png", "redtrees_tree.png"},
	paramtype2 = "facedir",
	light_source = 4,
	is_ground_content = false,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

--Mokuzai
minetest.register_node("redtrees:rwood", {
	description = S("Fiery Wooden Planks"),
	tiles = {"redtrees_wood.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=10,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

--Karai youfun
	minetest.register_craftitem("redtrees:treechillipowder", {
		inventory_image = "redtrees_powder.png",
		description = S("Tree Chilli Powder"),
	})

	minetest.register_craftitem("redtrees:treechillitreat", {
		inventory_image = "redtrees_treat.png",
		description = S("Tree Chilli Treat"),
		on_use = minetest.item_eat(5),
	})
--Wakagi
minetest.register_node("redtrees:rsapling", {
	description = S("Fiery Tree Sapling"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"redtrees_sapling.png"},
	inventory_image = "redtrees_sapling.png",
	wield_image = "redtrees_sapling.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=10,attached_node=1,sapling=1},
	sounds = default.node_sound_leaves_defaults(),
})

--Kinoha
minetest.register_node("redtrees:rleaves", {
	description = S("Fiery Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	light_source  = 5,
	visual_scale = 1.3,
	tiles = {"redtrees_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=10, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"redtrees:rsapling"},
				rarity = 20,
			},
			{
				items = {"redtrees:rleaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = redtrees.after_place_leaves,
})

--Kaidan to ita
stairs.register_stair_and_slab('rwood', 'redtrees:rwood',
	{choppy=2,oddly_breakable_by_hand=2,flammable=10,wood=1},
	{"redtrees_wood.png"}, S("Fiery Wooden Stairs"),S("Fiery Wooden Slab"),
	default.node_sound_wood_defaults())

--Kashana Tobira
doors.register_door("redtrees:rdoor_wood", {
		tiles = {{ name = "redtrees_door_full.png", backface_culling = true }},
		description = S("Luxurious Door"),
		inventory_image = "redtrees_door_wood.png",
		protected = true,
		groups = { snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
		recipe = {
		{"redtrees:rwood", "redtrees:rwood"},
		{"redtrees:rwood", "redtrees:rwood"},
		{"redtrees:rwood", "redtrees:rwood"}
		}
})

--Akai Bonsai
minetest.register_node("redtrees:rbonsai", {
	description = S("Akai Bonsai"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"redtrees_bonsai.png"},
	inventory_image = "redtrees_bonsai.png",
	wield_image = "redtrees_bonsai.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=10,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

default.register_fence("redtrees:rfence", {
	description = S("Fiery Fence"),
	texture = "redtrees_wood.png",
	material = "redtrees:rwood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})
doors.register_fencegate("redtrees:rfencegate", {
	description = S("Fiery Fence Gate"),
	texture = "redtrees_wood.png",
	material = "redtrees:rwood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})