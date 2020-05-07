minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cratermgbedrock:bedrock",
	wherein        = "air",
	clust_scarcity = 1 * 1 * 1,
	clust_num_ores = 20,
	clust_size     = 2,
	y_min     = 24950, -- Engine changes can modify this value.
	y_max     = 25050, -- This ensures the bottom of the world is not even loaded.
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cratermgbedrock:deepstone",
	wherein        = "air",
	clust_scarcity = 1 * 1 * 1,
	clust_num_ores = 20,
	clust_size     = 2,
	y_min     = 24950,
	y_max     = 25050,
})

minetest.register_node("cratermgbedrock:bedrock", {
	description = "Bedrock",
	tiles = {"bedrock_bedrock.png"},
	drop = "",
	groups = {unbreakable = 1, laserproof = 1, drillproof = 1, not_in_creative_inventory = 1}, -- For Map Tools' admin pickaxe.
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cratermgbedrock:deepstone", {
	description = "Deepstone",
	tiles = {"bedrock_deepstone.png"},
	drop = "default:stone", -- Intended.
	groups = {cracky = 1,unbreakable = 1, laserproof = 1, drillproof = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
})
