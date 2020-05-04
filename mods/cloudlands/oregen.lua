minetest.override_item("default:stone", {
    groups = {cracky = 3, stone = 1, cloudlandsstone=1},
})

minetest.override_item("default:desert_stone", {
    groups = {cracky = 3, stone = 1, cloudlandsstone=1},
})

minetest.override_item("default:sandstone", {
    groups = {crumbly = 1, cracky = 3, cloudlandsstone=1},
})

minetest.override_item("default:desert_sandstone", {
    groups = {crumbly = 1, cracky = 3, cloudlandsstone=1},
})

minetest.override_item("default:silver_sandstone", {
    groups = {crumbly = 1, cracky = 3, cloudlandsstone=1},
})

minetest.override_item("default:obsidian", {
    groups = {cracky = 1, level = 2, cloudlandsstone=1},
})


local uranium_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 420,
	octaves = 3,
	persist = 0.7
}
local uranium_threshold = 0.55

local chromium_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 421,
	octaves = 3,
	persist = 0.7
}
local chromium_threshold = 0.55

local zinc_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 422,
	octaves = 3,
	persist = 0.7
}
local zinc_threshold = 0.5

local lead_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 423,
	octaves = 3,
	persist = 0.7
}
local lead_threshold = 0.3

local sulfur_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 424,
	octaves = 3,
	persist = 0.7
}
local sulfur_threshold = 0.55

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "default:sand",
		wherein         = {"group:cloudlandsstone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 7000,
		y_min           = 7031,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 2316,
			octaves = 1,
			persist = 0.0
		},
	})
	
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "default:dirt",
		wherein         = {"group:cloudlandsstone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 7500,
		y_min           = 6500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 17676,
			octaves = 1,
			persist = 0.0
		},
	})
	
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "default:gravel",
		wherein         = {"group:cloudlandsstone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 7500,
		y_min           = 6500,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	
		minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_coal",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		y_max          = 7500,
		y_min          = 6500,
	})
	
		minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 12,
		clust_size     = 3,
		y_max          = 7500,
		y_min          = 6500,
	})
	
		minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_copper",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 7500,
		y_min          = 6500,
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_tin",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 7500,
		y_min          = 6500,
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_gold",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 7500,
		y_min          = 6500,
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_mese",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 7500,
		y_min          = 6500,
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_diamond",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = 7500,
		y_min          = 6500,
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mese",
		wherein        = "group:cloudlandsstone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = 7500,
		y_min          = 6500,
	})
	
	minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_uranium",
	wherein = "group:cloudlandsstone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 7,
	clust_size = 3,
	y_min = 6500,
	y_max = 7500,
	noise_params = uranium_params,
	noise_threshold = uranium_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_uranium",
	wherein = "group:cloudlandsstone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 7,
	clust_size = 3,
	y_min = 6500,
	y_max = 7500,
	noise_params = uranium_params,
	noise_threshold = uranium_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_chromium",
	wherein = "group:cloudlandsstone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 4,
	clust_size = 3,
	y_min = 6500,
	y_max = 7500,
	flags = "absheight",
	noise_params = chromium_params,
	noise_threshold = chromium_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_zinc",
	wherein = "group:cloudlandsstone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 6,
	clust_size = 3,
	y_min = 6900,
	y_max = 7500,
	flags = "absheight",
	noise_params = zinc_params,
	noise_threshold = zinc_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_lead",
	wherein = "group:cloudlandsstone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 6,
	clust_size = 3,
	y_min = 6900,
	y_max = 7500,
	flags = "absheight",
	noise_params = lead_params,
	noise_threshold = lead_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_sulfur",
	wherein = "group:cloudlandsstone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 6,
	clust_size = 3,
	y_min = 6900,
	y_max = 7500,
	flags = "absheight",
	noise_params = sulfur_params,
	noise_threshold = sulfur_threshold,
})