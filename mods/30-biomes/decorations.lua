local path = minetest.get_modpath("30biomes")
local defaultpath = minetest.get_modpath("default")

-- Mud in swamps
-- minetest.register_ore({ 
	-- ore_type = "blob",
	-- ore = "30biomes:mud",
	-- wherein = {"default:dirt", "default:dirt_with_grass"},
	-- clust_scarcity = 12*12*12,
	-- clust_size = 10,
	-- y_min = 6992,
	-- y_max = 7500,
	-- noise_threshold = 0.0,
	-- noise_params = {
		-- offset = 0.5,
		-- scale = 0.5,
		-- spread = {x=4, y=4, z=4},
		-- seed = 1662,
		-- octaves = 3,
		-- persist = 0.7
	-- },
	-- biomes = {"skyland_swamp", "skyland_hot_swamp", "skyland_swamp_shore", "skyland_hot_swamp_shore"},
-- })

-- Ice in cold swamps
minetest.register_ore({ 
	ore_type = "blob",
	ore = "default:ice",
	wherein = {"default:dirt", "default:dirt_with_snow"},
	clust_scarcity = 8*8*8,
	clust_size = 6,
	y_min = 6992,
	y_max = 7500,
	noise_threshold = 0.0,
	noise_params = {
		offset = 0.5,
		scale = 1,
		spread = {x=4, y=4, z=4},
		seed = 1662,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"skyland_icy_swamp", "skyland_icy_swamp_shore"},
})

-- Jungle grass
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.15,
		scale = -0.1,
		spread = {x = 200, y = 200, z = 200},
		seed = 329,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"skyland_rainforest", "skyland_desert_stone_grasslands", "skyland_semi-tropical_forest", "skyland_hot_swamp"},
	y_min = 7000,
	y_max = 7500,
	decoration = "default:junglegrass",
})

for length = 5, 1, -1 do
	-- Dense grass on grasslands
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.12 - 0.02 * length,
			scale = 0.05,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"skyland_stone_grasslands", "skyland_sandstone_grasslands"},
		y_min = 7000,
		y_max = 7500,
		decoration = "default:grass_"..length,
	})

	-- Grass (mostly on forests)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.03 - 0.01 * length,
			scale = 0.05,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"skyland_coniferous_forest", "skyland_deciduous_forest", "skyland_mixed_forest", "skyland_cold_deciduous_forest", "skyland_orchard", "skyland_hot_deciduous_forest", "skyland_bushes", "skyland_hot_pine_forest", "skyland_desert_stone_grasslands"},
		y_min = 7000,
		y_max = 7500,
		decoration = "default:grass_"..length,
	})

	-- Dry grass
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.06 - 0.01 * length,
			scale = 0.05,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"skyland_savanna", "skyland_red_savanna", "skyland_scrub"},
		y_min = 7000,
		y_max = 7500,
		decoration = "default:dry_grass_"..length,
	})

	-- Rare grass
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.01 * length,
			scale = 0.03 + 0.005 * length,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 1,
			persist = 1
		},
		biomes = {"skyland_scrub", "skyland_tundra", "skyland_semi-tropical_forest"},
		y_min = 7000,
		y_max = 7500,
		decoration = "default:grass_"..length,
	})

	-- Rare dry grass
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_dry_grass", "default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.01 * length,
			scale = 0.03 + 0.005 * length,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 1,
			persist = 1
		},
		biomes = {"skyland_bushes", "skyland_sandstone_grasslands"},
		y_min = 7000,
		y_max = 7500,
		decoration = "default:dry_grass_"..length,
	})
end

-- Apple tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.036,
		scale = 0.022,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_deciduous_forest", "skyland_cold_deciduous_forest", "skyland_orchard", "skyland_hot_deciduous_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = defaultpath.."/schematics/apple_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0018,
		scale = 0.0011,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_deciduous_forest", "skyland_cold_deciduous_forest", "skyland_orchard", "skyland_hot_deciduous_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:tree", param2 = 12, prob = 191},
			{name = "default:tree", param2 = 12},
			{name = "default:tree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_brown", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Rarer apple tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.02,
		scale = 0.02,
		spread = {x = 250, y = 250, z = 250},
		seed = 45,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_semi-tropical_forest", "skyland_mixed_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = defaultpath.."/schematics/apple_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.001,
		scale = 0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 45,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_semi-tropical_forest", "skyland_mixed_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:tree", param2 = 12, prob = 191},
			{name = "default:tree", param2 = 12},
			{name = "default:tree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_brown", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Jungle tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	noise_params = {
		offset = 0.09,
		scale = -0.04,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_rainforest", "skyland_mangrove"},
	y_min = 7000,
	y_max = 7500,
	schematic = defaultpath.."/schematics/jungle_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	noise_params = {
		offset = 0.045,
		scale = -0.02,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_rainforest", "skyland_mangrove"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:jungletree", param2 = 12, prob = 191},
			{name = "default:jungletree", param2 = 12},
			{name = "default:jungletree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_brown", prob = 127},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Rarer jungle tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	noise_params = {
		offset = 0.03,
		scale = -0.02,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_semi-tropical_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = defaultpath.."/schematics/jungle_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	noise_params = {
		offset = 0.015,
		scale = -0.01,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_semi-tropical_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:jungletree", param2 = 12, prob = 191},
			{name = "default:jungletree", param2 = 12},
			{name = "default:jungletree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_brown", prob = 127},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Pine tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.036,
		scale = 0.022,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_hot_pine_forest"},
	y_min = 7002,
	y_max = 7500,
	schematic = path.."/schematics/pine_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0018,
		scale = 0.0011,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_hot_pine_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:pine_tree", param2 = 12, prob = 191},
			{name = "default:pine_tree", param2 = 12},
			{name = "default:pine_tree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_red", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Rarer pine tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.020,
		scale = -0.020,
		spread = {x = 250, y = 250, z = 250},
		seed = 45,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_hot_deciduous_forest", "skyland_scrub"},
	y_min = 7002,
	y_max = 7500,
	schematic = path.."/schematics/pine_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.001,
		scale = -0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_hot_deciduous_forest", "skyland_scrub"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:pine_tree", param2 = 12, prob = 191},
			{name = "default:pine_tree", param2 = 12},
			{name = "default:pine_tree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_red", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Fir tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.036,
		scale = 0.022,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_taiga", "skyland_coniferous_forest"},
	y_min = 7002,
	y_max = 7500,
	schematic = path.."/schematics/fir_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0018,
		scale = 0.0011,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_taiga", "skyland_coniferous_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "30biomes:fir_tree", param2 = 12, prob = 191},
			{name = "30biomes:fir_tree", param2 = 12},
			{name = "30biomes:fir_tree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_red", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Rarer fir tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.020,
		scale = -0.020,
		spread = {x = 250, y = 250, z = 250},
		seed = 45,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_mixed_forest"},
	y_min = 7002,
	y_max = 7500,
	schematic = path.."/schematics/fir_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.001,
		scale = -0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_mixed_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "30biomes:fir_tree", param2 = 12, prob = 191},
			{name = "30biomes:fir_tree", param2 = 12},
			{name = "30biomes:fir_tree", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_red", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Acacia tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.002,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_savanna", "skyland_red_savanna"},
	y_min = 7000,
	y_max = 7500,
	schematic = defaultpath.."/schematics/acacia_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_savanna", "skyland_red_savanna"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 2, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:acacia_tree", param2 = 12, prob = 191},
			{name = "default:acacia_tree", param2 = 12},
			{name = "default:acacia_tree", param2 = 12, prob = 127},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Aspen tree and log
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0,
		scale = -0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_cold_deciduous_forest", "skyland_mixed_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = defaultpath.."/schematics/aspen_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0,
		scale = -0.0075,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"skyland_cold_deciduous_forest", "skyland_mixed_forest"},
	y_min = 7000,
	y_max = 7500,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "default:aspen_tree", param2 = 12},
			{name = "default:aspen_tree", param2 = 12},
			{name = "default:aspen_tree", param2 = 12, prob = 127},
			{name = "flowers:mushroom_red", prob = 63},
			{name = "flowers:mushroom_brown", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})

-- Papyrus
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.25,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"skyland_swamp_shore", "skyland_hot_swamp_shore", "skyland_mangrove"},
	y_min = 7000,
	y_max = 7020,
	schematic = defaultpath.."/schematics/papyrus.mts",
})

-- Cactus
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand", "default:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"skyland_desert", "skyland_sandstone_desert"},
	y_min = 7005,
	y_max = 7500,
	decoration = "default:cactus",
	height = 2,
	height_max = 5,
})

-- Large cactus
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.0001,
		scale = 0.0003,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"skyland_desert"},
	y_min = 7005,
	y_max = 7500,
	decoration = "default:cactus",
	height = 2,
	height_max = 5,
})

-- Dry shrub
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand", "default:dirt_with_snow"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.02,
		spread = {x = 200, y = 200, z = 200},
		seed = 7448,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"skyland_gravel_desert", "skyland_tundra", "skyland_dry_tundra", "skyland_sandstone_desert", "skyland_desert", "skyland_savanna", "skyland_red_savanna", "skyland_scrub"},
	y_min = 7002,
	y_max = 7500,
	decoration = "default:dry_shrub",
})
