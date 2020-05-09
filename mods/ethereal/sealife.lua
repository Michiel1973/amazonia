
local S = ethereal.intllib

-- Seaweed

minetest.register_node("ethereal:seaweed", {
	description = S("seaweed"),
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	special_tiles = {{name = "seaweed.png", tileable_vertical = true}},
	inventory_image = "seaweed.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_sand_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end

		local height = math.random(4, 6)
		local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
		local node_top = minetest.get_node(pos_top)
		local def_top = minetest.registered_nodes[node_top.name]
		local player_name = placer:get_player_name()

		if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
				minetest.set_node(pos, {name = "ethereal:seaweed",
					param2 = height * 16})
				if not (creative and creative.is_enabled_for
						and creative.is_enabled_for(player_name)) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})


minetest.register_craft( {
	type = "shapeless",
	output = "dye:dark_green 3",
	recipe = {"ethereal:seaweed",},
})

-- agar powder
minetest.register_craftitem("ethereal:agar_powder", {
	description = S("Agar Powder"),
	inventory_image = "ethereal_agar_powder.png",
	groups = {food_gelatin = 1, flammable = 2},
})

minetest.register_craft({
	output = "ethereal:agar_powder 3",
	recipe = {
		{"group:food_seaweed", "group:food_seaweed", "group:food_seaweed"},
		{"bucket:bucket_water", "bucket:bucket_water", "default:torch"},
		{"bucket:bucket_water", "bucket:bucket_water", "default:torch"},
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty 4"},
	},
})

-- Blue Coral
minetest.register_node("ethereal:coral2", {
	description = S("Blue Coral"),
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {
		nil,
		nil,
		"coral2.png",
		"coral2.png",
		"coral2.png",
		"coral2.png"
		},
	inventory_image = "coral2.png",
	wield_image = "coral2.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1 / 4, 6 / 16},
	},
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:cyan 3",
	recipe = {"ethereal:coral2",},
})

-- Orange Coral
minetest.register_node("ethereal:coral3", {
	description = S("Orange Coral"),
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {
		nil,
		nil,
		"coral3.png",
		"coral3.png",
		"coral3.png",
		"coral3.png"
		},
	inventory_image = "coral3.png",
	wield_image = "coral3.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1 / 4, 6 / 16},
	},
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:orange 3",
	recipe = {"ethereal:coral3",},
})

-- Pink Coral
minetest.register_node("ethereal:coral4", {
	description = S("Pink Coral"),
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {
		nil,
		nil,
		"coral4.png",
		"coral4.png",
		"coral4.png",
		"coral4.png"
		},
	inventory_image = "coral4.png",
	wield_image = "coral4.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1 / 4, 6 / 16},
	},
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:pink 3",
	recipe = {"ethereal:coral4",},
})

-- Green Coral
minetest.register_node("ethereal:coral5", {
	description = S("Green Coral"),
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {
		nil,
		nil,
		"coral5.png",
		"coral5.png",
		"coral5.png",
		"coral5.png"
		},
	inventory_image = "coral5.png",
	wield_image = "coral5.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1 / 4, 6 / 16},
	},
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:green 3",
	recipe = {"ethereal:coral5",},
})

	minetest.register_decoration({
		name = "ethereal:newcorals",
		decoration = {
			"ethereal:coral2",
			"ethereal:coral3",
			"ethereal:coral4",
			"ethereal:coral5",
		},
		deco_type = "simple",
		place_on = {"default:sand"},
		spawn_by = "default:water_source",
		sidelen = 16,
		place_offset_y = -1,
		noise_params = {
			offset = 0.005,
			scale = 0.008,
			spread = {x = 250, y = 250, z = 250},
			seed = 1232,
			octaves = 3,
			persist = 0.66
		},
		-- biomes = {
			-- "grassland_ocean",
			-- "coniferous_forest_ocean",
			-- "deciduous_forest_ocean"
		-- },
		y_max = -2,
		y_min = -40,
		flags = "force_placement",
	})


minetest.register_decoration({
		name = "ethereal:newseaweed",
		decoration = {"ethereal:seaweed"},
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.05,
			spread = {x = 200, y = 200, z = 200},
			seed = 34573,
			octaves = 3,
			persist = 0.7
		},
		-- biomes = {
			-- "grassland_ocean",
			-- "coniferous_forest_ocean",
			-- "deciduous_forest_ocean"
		-- },
		y_max = -5,
		y_min = -40,
		flags = "force_placement",
		param2 = 48,
		param2_max = 96,
	})


minetest.register_alias("ethereal:sandy", "default:sand")

-- sponges

minetest.register_node("ethereal:sponge_air", {
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	pointable = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})


minetest.register_node("ethereal:sponge_wet", {
	description = S("Wet sponge"),
	tiles = {"ethereal_sponge_wet.png"},
	groups = {crumbly = 3},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_decoration({
		name = "ethereal:wetsponge",
		decoration = {"ethereal:sponge_wet"},
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = 0.005,
			scale = 0.00002,
			spread = {x = 250, y = 250, z = 250},
			seed = 8563,
			octaves = 3,
			persist = 0.6
		},
		-- biomes = {
			-- "grassland_ocean",
			-- "coniferous_forest_ocean",
			-- "deciduous_forest_ocean"
		-- },
		y_max = -8,
		y_min = -22,
		flags = "force_placement",
		param2 = 48,
		param2_max = 96,
	})
	
-- cook wet sponge into dry sponge
minetest.register_craft({
	type = "cooking",
	recipe = "ethereal:sponge_wet",
	output = "ethereal:sponge",
	cooktime = 3,
})

-- use leaf decay to remove sponge air nodes
default.register_leafdecay({
	trunks = {"ethereal:sponge_wet"},
	leaves = {"ethereal:sponge_air"},
	radius = 3
})

-- dry sponges can be used as fuel
minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:sponge",
	burntime = 5,
})
