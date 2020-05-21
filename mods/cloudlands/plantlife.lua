minetest.register_node("cloudlands:bluegrass_1", {
	description = ("Cloudlands Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"bluegrass_1.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "bluegrass_3.png",
	wield_image = "bluegrass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("cloudlands:bluegrass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cloudlands:bluegrass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("cloudlands:bluegrass_" .. i, {
		description = ("Cloudlands Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"bluegrass_" .. i .. ".png"},
		inventory_image = "bluegrass_" .. i .. ".png",
		wield_image = "bluegrass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = "cloudlands:bluegrass_1",
		groups = {snappy = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
end


	-- Long grasses

	for length = 1, 5 do
		minetest.register_decoration({
			name = "cloudlands:bluegrass_"..length,
			deco_type = "simple",
			place_on = {"cloudlands:dirt_with_grass"},
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.027,
				spread = {x = 100, y = 100, z = 100},
				seed = 329,
				octaves = 3,
				persist = 0.6
			},
			y_max = 7300,
			y_min = 6900,
			decoration = "cloudlands:bluegrass_"..length,
		})
	end


local add_schem = function(a, b, c, d, e, f, g, h)

	if g ~= 1 then return end

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = a,
		sidelen = 80,
		fill_ratio = b,
		biomes = c,
		y_min = d,
		y_max = e,
		schematic = f,
		flags = "place_center_x, place_center_z",
		replacements = h,
	})
end


local dpath = minetest.get_modpath("default") .. "/schematics/"

add_schem({"ethereal:bamboo_dirt"}, 0.001, nil, 6500, 7500, ethereal.sakura_tree, ethereal.sakura)
add_schem({"default:dirt_with_dry_grass"}, 0.0015, nil, 6500, 7500, ethereal.redwood_tree, ethereal.mesa)
add_schem({"ethereal:grove_dirt"}, 0.001, nil, 6500, 7500, ethereal.bananatree, ethereal.grove)
add_schem({"ethereal:fiery_dirt"}, 0.001, nil, 6500, 7500, ethereal.yellowtree, ethereal.alpine)
add_schem({"ethereal:crystal_dirt"}, 0.001, nil, 6500, 7500, ethereal.frosttrees, ethereal.frost)
add_schem({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.002, nil, 6500, 7500, dpath .. "jungle_tree.mts", ethereal.junglee)
add_schem({"ethereal:gray_dirt"}, 0.003, nil, 6500, 7500, ethereal.willow, ethereal.grayness)
add_schem({"default:dirt_with_snow"}, 0.04, {"ethereal_alpine"}, 40, 140, ethereal.pinetree, ethereal.alpine)
add_schem({"default:dirt_with_snow"}, 0.04, nil, 6500, 7500, ethereal.pinetree, ethereal.alpine)
add_schem({"ethereal:grove_dirt"}, 0.004, nil, 6500, 7500, dpath .. "apple_tree.mts", ethereal.grassy)
add_schem({"ethereal:jungle_dirt"}, 0.004, nil, 6500, 7500, dpath .. "apple_tree.mts", ethereal.grassy)
add_schem({"ethereal:jungle_dirt"}, 0.0001, nil, 6500, 7500, ethereal.bigtree, ethereal.jumble)
add_schem({"ethereal:prairie_dirt"}, 0.0008, nil, 6500, 7500, dpath .. "aspen_tree.mts", ethereal.jumble)
add_schem({"ethereal:jungle_dirt"}, 0.0006, {"ethereal_grassytwo"}, 6500, 7500, ethereal.birchtree, ethereal.grassytwo)
add_schem({"ethereal:prairie_dirt"}, 0.003, nil, 6500, 7500, ethereal.orangetree, ethereal.prairie)
add_schem({"default:dirt_with_dry_grass"}, 0.002, nil, 6500, 7500, dpath .. "acacia_tree.mts", ethereal.savannah)
add_schem({"default:sand"}, 0.001, nil, 6500, 7500, ethereal.palmtree, ethereal.grassy)
add_schem({"ethereal:bamboo_dirt"}, 0.015, nil, 6500, 7500, ethereal.bambootree, ethereal.bamboo)
add_schem({"ethereal:bamboo_dirt"}, 0.05, nil, 6500, 7500, ethereal.bush, ethereal.bamboo)



	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"ethereal:mushroom_dirt"},
		sidelen = 80,
		fill_ratio = 0.007,
		nil,
		y_min = 6500,
		y_max = 7500,
		schematic = ethereal.mushroomone,
		flags = "place_center_x, place_center_z",
		spawn_by = "ethereal:mushroom_dirt",
		num_spawn_by = 6,
	})
	
	minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:desert_sand"},
	sidelen = 80,
	noise_params = {
		offset = -0.0005,
		scale = 0.0015,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	biomes = nil,
	y_min = 6500,
	y_max = 7500,
	schematic = dpath.."large_cactus.mts",
	flags = "place_center_x", --, place_center_z",
	rotation = "random",
})

--= simple decorations

local add_node = function(a, b, c, d, e, f, g, h, i, j)

	if j ~= 1 then return end

	minetest.register_decoration({
		deco_type = "simple",
		place_on = a,
		sidelen = 80,
		fill_ratio = b,
		biomes = c,
		y_min = d,
		y_max = e,
		decoration = f,
		height_max = g,
		spawn_by = h,
		num_spawn_by = i,
	})
end

add_node({"default:gravel"}, 0.001, nil, 6500, 7500, {"ethereal:firethorn"}, nil, nil, nil, ethereal.glacier)
add_node({"ethereal:dry_dirt"}, 0.002, nil, 6500, 7500, {"ethereal:scorched_tree"}, 6, nil, nil, ethereal.plains)
add_node({"ethereal:dry_dirt"}, 0.015, nil, 6500, 7500, {"default:dry_shrub"}, nil, nil, nil, ethereal.plains)
add_node({"default:sand"}, 0.015, nil, 6500, 7500, {"default:dry_shrub"}, nil, nil, nil, ethereal.grassy)
add_node({"default:desert_sand"}, 0.015, nil, 6500, 7500, {"default:dry_shrub"}, nil, nil, nil, ethereal.desert)
add_node({"default:dirt_with_dry_grass"}, 0.15, nil, 6500, 7500, {"default:dry_grass_2",
	"default:dry_grass_3", "default:dry_grass_4", "default:dry_grass_5"}, nil, nil, nil, ethereal.savannah)
add_node({"default:dirt_with_dry_grass"}, 0.10, nil, 6500, 7500, {"default:dry_grass_2",
	"default:dry_grass_3", "default:dry_grass_4", "default:dry_grass_5"}, nil, nil, nil, ethereal.mesa)
add_node({"ethereal:cold_dirt"}, 0.01, nil, 6500, 7500, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7"}, nil, nil, nil, ethereal.grassy)
add_node({"ethereal:prairie_dirt"}, 0.015, nil, 6500, 7500, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7", "flowers:chrysanthemum_green", "flowers:tulip_black"}, nil, nil, nil, ethereal.prairie)
add_node({"ethereal:crystal_dirt"}, 0.01, nil, 6500, 7500, {"ethereal:crystal_spike",
	"ethereal:crystalgrass"}, nil, nil, nil, ethereal.frost)
add_node({"ethereal:fiery_dirt"}, 0.10, nil, 6500, 7500, {"ethereal:dry_shrub"}, nil, nil, nil, ethereal.fiery)
add_node({"ethereal:fiery_dirt"}, 0.02, nil, 6500, 7500, {"ethereal:fire_flower"}, nil, nil, nil, ethereal.fiery)
add_node({"ethereal:gray_dirt"}, 0.05, nil, 6500, 7500, {"ethereal:snowygrass"}, nil, nil, nil, ethereal.grayness)
add_node({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"}, 0.05, nil, 6500, 7500, {"ethereal:snowygrass"}, nil, nil, nil, ethereal.snowy)
add_node({"ethereal:mushroom_dirt"}, 0.02, nil, 6500, 7500, {"flowers:mushroom_fertile_red"}, nil, nil, nil, ethereal.mushroom)
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.02, nil, 6500, 7500, {"default:junglegrass"}, nil, nil, nil, ethereal.junglee)
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.35, nil, 6500, 7500, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.junglee)
add_node({"ethereal:prairie_dirt"}, 0.05, nil, 6500, 7500, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.prairie)
add_node({"ethereal:grove_dirt"}, 0.05, nil, 6500, 7500, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.grove)
add_node({"ethereal:bamboo_dirt"}, 0.05, nil, 6500, 7500, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.bamboo)
add_node({"ethereal:grove_dirt"}, 0.2, nil, 6500, add_node({"ethereal:grove_dirt"}, 0.2, {"ethereal_grove"}, 1, 100, {"ethereal:fern"}, nil, nil, nil, ethereal.grove)
, {"ethereal:fern"}, nil, nil, nil, ethereal.grove)
add_node({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"}, 0.8, nil , 6500, 7500, {"default:snow"}, nil, nil, nil, ethereal.snowy)
add_node({"ethereal:mushroom_dirt"}, 0.8, 6500, 7500, {"default:snow"}, nil, nil, nil, ethereal.alpine)
add_node({"ethereal:prairie_dirt"}, 0.05, nil, 6500, 7500, {"ethereal:onion_4"}, nil, nil, nil, ethereal.prairie)
add_node({"group:soil","group:sand"}, 0.1, nil, 6500, 7500, {"default:papyrus"}, 4, "default:water_source", 1, ethereal.junglee)
add_node({"group:soil"}, 0.0007, nil, 6500, 7500, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4",
	"farming:pea_5", "farming:beetroot_5"}, nil, nil, nil, ethereal.prairie)
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.01, nil, 6500, 7500, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.junglee)
add_node({"ethereal:prairie_dirt"}, 0.0012, nil, 6500, 7500, {"farming:grapebush"}, nil, nil, nil, ethereal.prairie)
add_node({"ethereal:jungle_dirt"}, 0.011, nil, 6500, 7500, {"farming:beanbush"}, nil, nil, nil, ethereal.grassytwo)


local list = {
	{"ethereal_junglee", {"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, ethereal.junglee},
	{"ethereal_grassy", {"default:dirt_with_grass"}, ethereal.grassy},
	{"ethereal_grassytwo", {"default:dirt_with_grass"}, ethereal.grassytwo},
	{"ethereal_prairie", {"ethereal:prairie_dirt"}, ethereal.prairie},
	{"ethereal_mushroom", {"ethereal:mushroom_dirt"}, ethereal.mushroom},
	{"ethereal_swamp", {"default:dirt_with_grass"}, ethereal.swamp},
}

-- wild red and brown mushrooms
for _, row in pairs(list) do

if row[3] == 1 then
minetest.register_decoration({
	deco_type = "simple",
	place_on = row[2],
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.009,
		spread = {x = 200, y = 200, z = 200},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 6500,
	y_max = 7500,
	decoration = {"flowers:mushroom_brown", "flowers:mushroom_red"},
})
end
end

if minetest.registered_nodes["default:marram_grass_1"] then

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:sand"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.009,
		spread = {x = 200, y = 200, z = 200},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 6500,
	y_max = 7500,
	decoration = {"default:marram_grass_1", "default:marram_grass_2", "default:marram_grass_3"},
})
else
add_node({"default:sand"}, 0.25, nil, 6500, 7500, {"default:grass_2", "default:grass_3"}, nil, nil, nil, ethereal.sandclay)
end

if farming and farming.mod and farming.mod == "redo" then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "ethereal:prairie_dirt",
		"default:dirt_with_rainforest_litter",
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 100, y = 100, z = 100},
		seed = 420,
		octaves = 3,
		persist = 0.6
	},
	y_min = 6500,
	y_max = 7500,
	decoration = "farming:hemp_7",
	spawn_by = "group:tree",
	num_spawn_by = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.009,
		spread = {x = 100, y = 100, z = 100},
		seed = 760,
		octaves = 3,
		persist = 0.3
	},
	y_min = 6500,
	y_max = 7500,
	decoration = {"farming:chili_8", "farming:garlic_5", "farming:pepper_5", "farming:onion_5"},
	spawn_by = "group:tree",
	num_spawn_by = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 100, y = 100, z = 100},
		seed = 917,
		octaves = 3,
		persist = 0.3
	},
	y_min = 6500,
	y_max = 7500,
	decoration = {"farming:pineapple_8"},
})
end

if minetest.get_modpath("bakedclay") then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"ethereal:prairie_grass", "default:dirt_with_grass",
		"ethereal:grove_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.004,
		spread = {x = 100, y = 100, z = 100},
		seed = 7133,
		octaves = 3,
		persist = 0.3
	},
	y_min = 6500,
	y_max = 7500,
	decoration = "bakedclay:delphinium",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"ethereal:prairie_grass", "default:dirt_with_grass",
		"ethereal:grove_dirt", "ethereal:bamboo_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.004,
		spread = {x = 100, y = 100, z = 100},
		seed = 7134,
		octaves = 3,
		persist = 0.3
	},
	y_min = 6500,
	y_max = 7500,
	decoration = "bakedclay:thistle",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:sand"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.009,
		spread = {x = 100, y = 100, z = 100},
		seed = 7136,
		octaves = 3,
		persist = 0.3
	},
	y_min = 6500,
	y_max = 7500,
	decoration = "bakedclay:mannagrass",
	spawn_by = "group:water",
	num_spawn_by = 1,
})

end

if ethereal.desert and minetest.get_modpath("wine") then

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand"},
	sidelen = 16,
	fill_ratio = 0.005,
	biomes = nil,
	y_min = 6500,
	y_max = 7500,
	decoration = {"wine:blue_agave"},
})
end

if ethereal.snowy and minetest.registered_nodes["default:fern_1"] then
local function register_fern_decoration_cloudlands(seed, length)
	minetest.register_decoration({
		name = "default:fern_" .. length,
		deco_type = "simple",
		place_on = {
			"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = seed,
			octaves = 3,
			persist = 0.7
		},
		y_max = 7500,
		y_min = 6500,
		decoration = "default:fern_" .. length,
	})
end

register_fern_decoration_cloudlands(14936, 3)
register_fern_decoration_cloudlands(801, 2)
register_fern_decoration_cloudlands(5, 1)
end

if minetest.get_modpath("butterflies") then
minetest.register_decoration({
	name = "butterflies:butterfly",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
	place_offset_y = 2,
	sidelen = 80,
	fill_ratio = 0.005,
	biomes = nil,
	y_max = 7500,
	y_min = 6500,
	decoration = {
		"butterflies:butterfly_white",
		"butterflies:butterfly_red",
		"butterflies:butterfly_violet"
	},
	spawn_by = "group:flower",
	num_spawn_by = 1
})
end

if minetest.get_modpath("fireflies") then
		minetest.register_decoration({
		name = "fireflies:firefly_low",
		deco_type = "simple",
		place_on = {
			"default:dirt_with_grass",
			"default:dirt_with_coniferous_litter",
			"default:dirt_with_rainforest_litter",
			"default:dirt",
			"ethereal:cold_dirt",
		},
		place_offset_y = 2,
		sidelen = 80,
		fill_ratio = 0.0005,
		biomes = nil,
		y_max = 7500,
		y_min = 6500,
		decoration = "fireflies:hidden_firefly",
	})
end

-- moreplants


minetest.register_decoration({
	deco_type = "simple",
	place_on = "ethereal:fiery_dirt",
	sidelen = 26,
	fill_ratio = 0.005,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:fireflower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "ethereal:grove_dirt",
	sidelen = 16,
	fill_ratio = 0.01,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:tallgrass",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "cloudlands:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.001,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:blueflower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"ethereal:fiery_dirt"},
	sidelen = 16,
	fill_ratio = 0.02,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:jungleflower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"ethereal:bamboo_dirt"},
	sidelen = 16,
	fill_ratio = 0.01,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:umbrella",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"ethereal:mushroom_dirt"},
	sidelen = 16,
	fill_ratio = 0.01,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:bigfern",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"ethereal:grove_dirt"},
	sidelen = 16,
	fill_ratio = 0.01,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:bigflower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"ethereal:grove_dirt"},
	sidelen = 16,
	fill_ratio = 0.01,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:medflower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "group:soil",
	sidelen = 16,
	fill_ratio = 0.01,
	y_min = 6500,
	y_max = 7500,
	spawn_by = "group:water",
	num_spawn_by = 1,
	decoration = "moreplants:bulrush",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "cloudlands:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.005,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:aliengrass",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "cloudlands:dirt_with_grass",
	sidelen = 26,
	fill_ratio = 0.005,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:eyeweed",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:stone",
	sidelen = 16,
	fill_ratio = 0.001,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:stoneweed",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:desert_sand",
	sidelen = 26,
	fill_ratio = 0.005,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:cactus",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "cloudlands:dirt_with_grass",
	sidelen = 26,
	fill_ratio = 0.005,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:curly",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "ethereal:prairie_dirt",
	sidelen = 26,
	fill_ratio = 0.005,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:bush",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "ethereal:jungle_dirt",
	sidelen = 16,
	fill_ratio = 0.005,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:moonflower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:gravel"},
	sidelen = 26,
	fill_ratio = 0.02,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:deadweed",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"cloudlands:dirt_with_grass"},
	sidelen = 26,
	fill_ratio = 0.02,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:taigabush",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"dirt_with_coniferous_litter"},
	sidelen = 16,
	fill_ratio = 0.02,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:groundfung",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "ethereal:prairie_dirt",
	sidelen = 16,
	fill_ratio = 0.02,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:spikefern",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "dirt_with_coniferous_litter",
	sidelen = 26,
	fill_ratio = 0.02,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:weed",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "ethereal:prairie_dirt",
	sidelen = 26,
	fill_ratio = 0.02,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:fern",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "ethereal:mushroom_dirt",
	sidelen = 16,
	fill_ratio = 0.01,
	y_min = 6500,
	y_max = 7500,
	decoration = "moreplants:mushroom",
	height = 1,
})