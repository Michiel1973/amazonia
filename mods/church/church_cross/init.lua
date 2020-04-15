screwdriver = screwdriver or {}

cross = {}

--------------------
-- Node Registration
--------------------
--Hanging Wall Crosses
minetest.register_node('church_cross:wallcross_gold', {
	description = 'Gold Wall Cross',
	tiles = {'default_gold_block.png'},
	groups = {oddly_breakable_by_hand = 3},
	drawtype = 'nodebox',
	paramtype = 'light',
	paramtype2 = 'facedir',
	sunlight_propagates = true,
	is_ground_content = false,
	buildable_to = false,
	light_source = 7,
	sounds = default.node_sound_metal_defaults(),
	on_rotate = screwdriver.rotate_simple, --no upside down crosses :)
	node_box = {
		type = 'fixed',
		fixed = {
			{-0.0625, -0.3125, 0.4375, 0.0625, 0.3125, 0.5},
			{-0.1875, 0, 0.4375, 0.1875, 0.125, 0.5},
		}
	},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.25, -0.5, 0.375, 0.25, 0.375, 0.5},
		}
	}
})

minetest.register_node('church_cross:wallcross_steel', {
	description = 'Steel Wall Cross',
	tiles = {'default_steel_block.png'},
	groups = {oddly_breakable_by_hand = 3},
	drawtype = 'nodebox',
	paramtype = 'light',
	paramtype2 = 'facedir',
	sunlight_propagates = true,
	is_ground_content = false,
	buildable_to = false,
	light_source = 11,
	sounds = default.node_sound_metal_defaults(),
	on_rotate = screwdriver.rotate_simple,
	node_box = {
		type = 'fixed',
		fixed = {
			{-0.0625, -0.3125, 0.4375, 0.0625, 0.3125, 0.5},
			{-0.1875, 0, 0.4375, 0.1875, 0.125, 0.5},
		}
	},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.25, -0.5, 0.375, 0.25, 0.375, 0.5},
		}
	}
})
--Cross Standards
cross.register_cross = function( basename, texture, description, craft_from, mat_sounds )
local group_def = {cracky = 3, oddly_breakable_by_hand = 2};

	minetest.register_node('church_cross:cross_'..basename, {
		description = description.. ' Cross',
		tiles = {texture },
		drawtype = 'nodebox',
		paramtype = 'light',
		paramtype2 = 'facedir',
		light_source = 7,
		sunlight_propagates = true,
		is_ground_content = false,
		buildable_to = false,
		on_rotate = screwdriver.rotate_simple,
		groups = group_def,
		sounds = mat_sounds,
		node_box = {
			type = 'fixed',
			fixed = {
				{-0.0625, -0.5, -0.0625, 0.0625, 0.4375, 0.0625},
				{-0.25, 0.0625, -0.0625, 0.25, 0.1875, 0.0625},
			}
		},
		selection_box = {
			type = 'fixed',
			fixed = {
				{-0.375, -0.5, -0.0625, 0.375, 0.5, 0.0625},
			},
		},
	})

-----------
-- Crafting
-----------
	minetest.register_craft({
		output = 'church_cross:cross_'..basename,
		recipe = {
			{'', craft_from, ''},
			{'default:stick', 'default:stick', 'default:stick'},
			{'', 'default:stick', ''}
		}
	})

end

minetest.register_craft({
	output = 'church_cross:wallcross_gold',
	recipe = {
		{ '', '', '' },
		{ '', 'church_cross:cross_gold', '' },
		{ '', '', '' },
	}
})

minetest.register_craft({
	output = 'church_cross:wallcross_steel',
	recipe = {
		{ '', '','' },
		{ '', 'church_cross:cross_steel','' },
		{ '', '','' },
	}
})

----------
-- Cooking
----------
minetest.register_craft({
	type = 'cooking',
	output = 'default:gold_ingot',
	recipe = 'church_cross:wallcross_gold',
	cooktime = 5,
})

minetest.register_craft({
	type = 'cooking',
	output = 'default:steel_ingot',
	recipe = 'church_cross:wallcross_steel',
	cooktime = 5,
})

--------------------------
-- Register Node Materials
--------------------------
cross.register_cross( 'gold', 'default_gold_block.png', 'Gold', 'default:gold_ingot', default.node_sound_metal_defaults())
cross.register_cross( 'steel', 'default_steel_block.png', 'Steel', 'default:steel_ingot', default.node_sound_metal_defaults())
cross.register_cross( 'stone', 'default_stone.png', 'Stone', 'default:stone', default.node_sound_stone_defaults())
cross.register_cross( 'wood', 'default_pine_wood.png^[transformR90', 'Wood', 'default:stick', default.node_sound_wood_defaults())
