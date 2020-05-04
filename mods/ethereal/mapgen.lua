
-- clear default mapgen biomes, decorations and ores
--minetest.clear_registered_biomes()
--minetest.clear_registered_decorations()
--minetest.clear_registered_ores()

local path = minetest.get_modpath("ethereal")

dofile(path .. "/ores.lua")

path = path .. "/schematics/"

local dpath = minetest.get_modpath("default") .. "/schematics/"

-- tree schematics
dofile(path .. "orange_tree.lua")
dofile(path .. "banana_tree.lua")
dofile(path .. "bamboo_tree.lua")
dofile(path .. "birch_tree.lua")
dofile(path .. "bush.lua")
dofile(path .. "waterlily.lua")
dofile(path .. "volcanom.lua")
dofile(path .. "volcanol.lua")
dofile(path .. "frosttrees.lua")
dofile(path .. "palmtree.lua")
dofile(path .. "pinetree.lua")
dofile(path .. "yellowtree.lua")
dofile(path .. "mushroomone.lua")
dofile(path .. "willow.lua")
dofile(path .. "bigtree.lua")
dofile(path .. "redwood_tree.lua")
dofile(path .. "vinetree.lua")
dofile(path .. "sakura.lua")
dofile(path .. "igloo.lua")

--= Biomes

local add_biome = function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p,q,r)

	if p ~= 1 then return end

	minetest.register_biome({
		name = a,
		node_dust = b,
		node_top = c,
		depth_top = d,
		node_filler = e,
		depth_filler = f,
		node_stone = g,
		node_water_top = h,
		depth_water_top = i,
		node_water = j,
		node_river_water = k,
		y_min = l,
		y_max = m,
		heat_point = n,
		humidity_point = o,
        vertical_blend = p,
        horizontal_blend = q,
	})
end

add_biome("ethereal_underground", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
	-31099, -192, 50, 50, 1)

add_biome("ethereal_mountain", nil, "default:snow", 1, "default:snowblock", 2,
	nil, nil, nil, nil, nil, 160, 6000, 50, 50, 1)

add_biome("ethereal_desert", nil, "default:desert_sand", 1, "default:desert_sand", 3,
	"default:desert_stone", nil, nil, nil, nil, 3, 23, 35, 20, 3, 4,ethereal.desert)

add_biome("ethereal_desert_ocean", nil, "default:sand", 1, "default:sand", 2,
	"default:desert_stone", nil, nil, nil, nil, -192, 3, 35, 20, 3,4,ethereal.desert)

if ethereal.glacier == 1 then

	minetest.register_biome({
		name = "ethereal_glacier",
		node_dust = "default:snowblock",
		node_top = "default:snowblock",
		depth_top = 1,
		node_filler = "default:snowblock",
		depth_filler = 3,
		node_stone = "default:ice",
		node_water_top = "default:ice",
		depth_water_top = 10,
		--node_water = "",
		node_river_water = "default:ice",
		node_riverbed = "default:gravel",
		depth_riverbed = 2,
		y_min = -8,
		y_max = 30,
        vertical_blend = 3,
        horizontal_blend = 4,
		heat_point = 0,
		humidity_point = 50,
	})

	minetest.register_biome({
		name = "ethereal_glacier_ocean",
		node_dust = "default:snowblock",
		node_top = "default:sand",
		depth_top = 1,
		node_filler = "default:sand",
		depth_filler = 3,
		--node_stone = "",
		--node_water_top = "",
		--depth_water_top = ,
		--node_water = "",
		--node_river_water = "",
		y_min = -112,
		y_max = -9,
        vertical_blend = 3,
        horizontal_blend = 4,
		heat_point = 0,
		humidity_point = 50,
	})
end

add_biome("ethereal_clearing", nil, "default:dirt_with_grass", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 71, 45, 65, 3,4,1) -- ADDED

add_biome("ethereal_bamboo", nil, "ethereal:bamboo_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 25, 70, 45, 75, 3,4,ethereal.bamboo)

--add_biome("ethereal_bamboo_ocean", nil, "default:sand", 1, "default:sand", 2,
	--nil, nil, nil, nil, nil, -192, 2, 45, 75, ethereal.bamboo)

add_biome("ethereal_sakura", nil, "ethereal:bamboo_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 35, 45, 75, 3,4,ethereal.sakura)

add_biome("ethereal_sakura_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 45, 75, 3,4,ethereal.sakura)

add_biome("ethereal_mesa", nil, "default:dirt_with_dry_grass", 1, "bakedclay:orange", 15,
	nil, nil, nil, nil, nil, 1, 81, 25, 28, 3,4,ethereal.mesa)

add_biome("ethereal_mesa_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 25, 28, 3,4,ethereal.mesa)

add_biome("ethereal_alpine", nil, "default:dirt_with_snow", 1, "default:dirt", 2,
	nil, nil, nil, nil, nil, 110, 190, 10, 40, 3,4,ethereal.alpine)

if minetest.registered_nodes["default:dirt_with_coniferous_litter"] then
add_biome("ethereal_snowy", nil, "default:dirt_with_coniferous_litter", 1, "default:dirt",
	2, nil, nil, nil, nil, nil, 4, 30, 10, 40, 3,4,ethereal.snowy)
else
add_biome("ethereal_snowy", nil, "ethereal:cold_dirt", 1, "default:dirt", 2,
	nil, nil, nil, nil, nil, 4, 35, 10, 40, 3,4,ethereal.snowy)
end

add_biome("ethereal_frost", nil, "ethereal:crystal_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 1, 91,nil,nil, 0,0,ethereal.frost)

add_biome("ethereal_frost_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 10, 40, 3,4,ethereal.frost)

add_biome("ethereal_grassy", nil, "default:dirt_with_grass", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 61, 13, 40, 3,4,ethereal.grassy)

add_biome("ethereal_grassy_ocean", nil, "default:sand", 2, "default:gravel", 1,
	nil, nil, nil, nil, nil, -31099, 3, 13, 40, 3,4,ethereal.grassy)

add_biome("ethereal_caves", nil, "default:desert_stone", 3, "air", 8,
	nil, nil, nil, nil, nil, 4, 41, 15, 25, 3,4,ethereal.caves)

add_biome("ethereal_grayness", nil, "ethereal:gray_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 2, 61, 15, 30, 3,4,ethereal.grayness)
	
if minetest.registered_nodes["default:silver_sand"] then
	add_biome("ethereal_grayness_ocean", nil, "default:silver_sand", 2, "default:sand", 2,
		nil, nil, nil, nil, nil, -192, 1, 15, 30, 3,4,ethereal.grayness)
else
	add_biome("ethereal_grayness_ocean", nil, "default:sand", 1, "default:sand", 2,
		nil, nil, nil, nil, nil, -192, 1, 15, 30, 3,4,ethereal.grayness)
end

add_biome("ethereal_grassytwo", nil, "default:dirt_with_grass", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 30, 71, 15, 40, 3,4,ethereal.grassytwo)

add_biome("ethereal_grassytwo_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 15, 40, 3,4,ethereal.grassytwo)

add_biome("ethereal_prairie", nil, "ethereal:prairie_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 10, 46, 20, 40, 3,4,ethereal.prairie)

add_biome("ethereal_prairie_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 20, 40, 3,4,ethereal.prairie)

add_biome("ethereal_jumble", nil, "default:dirt_with_grass", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 5, 71, 25, 50, 3,4,ethereal.jumble)

add_biome("ethereal_jumble_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 25, 50, 3,4,ethereal.jumble)

if minetest.registered_nodes["default:dirt_with_rainforest_litter"] then
	add_biome("ethereal_junglee", nil, "default:dirt_with_rainforest_litter", 1, "default:dirt", 3,
		nil, nil, nil, nil, nil, 5, 71, 30, 60, 3,4,ethereal.junglee)
else
	add_biome("ethereal_junglee", nil, "ethereal:jungle_dirt", 1, "default:dirt", 3,
		nil, nil, nil, nil, nil, 5, 51, 30, 60, 3,4,ethereal.junglee)
end

add_biome("ethereal_junglee_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 30, 60, 3,4,ethereal.junglee)

add_biome("ethereal_grove", nil, "ethereal:grove_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 33, 45, 35, 3,4,ethereal.grove)

add_biome("ethereal_grove_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 45, 35, 3,4,ethereal.grove)

add_biome("ethereal_mushroom", nil, "ethereal:mushroom_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 25, 50, 45, 55, 3,4,ethereal.mushroom)

add_biome("ethereal_mushroom_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 45, 55, 3,4,ethereal.mushroom)

add_biome("ethereal_sandstone", nil, "default:sandstone", 1, "default:sandstone", 1,
	"default:sandstone", nil, nil, nil, nil, 3, 23, 50, 20, 3,4,ethereal.sandstone)

add_biome("ethereal_sandstone_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 50, 20, 3,4,ethereal.sandstone)

add_biome("ethereal_quicksand", nil, "ethereal:quicksand2", 3, "default:gravel", 1,
	nil, nil, nil, nil, nil, 1, 1, 50, 38, 3,4,ethereal.quicksand)

add_biome("ethereal_plains", nil, "ethereal:dry_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 3, 35, 65, 25, 3,4,ethereal.plains)

add_biome("ethereal_plains_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 2, 55, 25, 3,4,ethereal.plains)

add_biome("ethereal_savannah", nil, "default:dirt_with_dry_grass", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 8, 60, 55, 25, 3,4,ethereal.savannah)

add_biome("ethereal_savannah_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 1, 55, 25, 3,4,ethereal.savannah)

add_biome("ethereal_fiery", nil, "ethereal:fiery_dirt", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 5, 50, 75, 10, 3,4,ethereal.fiery)

add_biome("ethereal_fiery_ocean", nil, "default:sand", 1, "default:sand", 2,
	nil, nil, nil, nil, nil, -192, 4, 75, 10, 3,4,ethereal.fiery)

add_biome("ethereal_sandclay", nil, "default:sand", 3, "default:clay", 2,
	nil, nil, nil, nil, nil, 1, 21, 65, 2, 3,4,ethereal.sandclay)

add_biome("ethereal_swamp", nil, "default:dirt_with_grass", 1, "default:dirt", 3,
	nil, nil, nil, nil, nil, 1, 18, 80, 90, 3,4,ethereal.swamp)

add_biome("ethereal_swamp_ocean", nil, "default:sand", 2, "default:clay", 2,
	nil, nil, nil, nil, nil, -192, 1, 80, 90, 3,4,ethereal.swamp)

--= schematic decorations

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

if ethereal.glacier then

	-- igloo
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:snowblock"},
		sidelen = 80,
		fill_ratio = 0.001,
		biomes = {"ethereal_glacier"},
		y_min = 3,
		y_max = 50,
		schematic = ethereal.igloo,
		flags = "place_center_x, place_center_z",
		spawn_by = "default:snowblock",
		num_spawn_by = 8,
		rotation = "random",
	})
end

--sakura tree
add_schem({"ethereal:bamboo_dirt"}, 0.01, {"ethereal_sakura"}, 7, 100, ethereal.sakura_tree, ethereal.sakura)

-- redwood tree
add_schem({"default:dirt_with_dry_grass"}, 0.0025, {"ethereal_mesa"}, 1, 100, ethereal.redwood_tree, ethereal.mesa)

-- banana tree
add_schem({"ethereal:grove_dirt"}, 0.005, {"ethereal_grove"}, 1, 100, ethereal.bananatree, ethereal.grove)

-- healing tree
add_schem({"default:dirt_with_snow"}, 0.01, {"ethereal_alpine"}, 90, 190, ethereal.yellowtree, ethereal.alpine)

-- crystal frost tree
add_schem({"ethereal:crystal_dirt"}, 0.01, {"ethereal_frost"}, 1, 200, ethereal.frosttrees, ethereal.frost)

if ethereal.mushroom then

	-- giant shroom
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"ethereal:mushroom_dirt"},
		sidelen = 80,
		fill_ratio = 0.02,
		biomes = {"ethereal_mushroom"},
		y_min = 1,
		y_max = 100,
		schematic = ethereal.mushroomone,
		flags = "place_center_x, place_center_z",
		spawn_by = "ethereal:mushroom_dirt",
		num_spawn_by = 6,
	})
	

end

if ethereal.fiery then

	-- small lava crater
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"ethereal:fiery_dirt"},
		sidelen = 80,
		fill_ratio = 0.01,
		biomes = {"ethereal_fiery"},
		y_min = 1,
		y_max = 100,
		schematic = ethereal.volcanom,
		flags = "place_center_x, place_center_z",
		spawn_by = "ethereal:fiery_dirt",
		num_spawn_by = 8,
	})

	-- large lava crater
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"ethereal:fiery_dirt"},
		sidelen = 80,
		fill_ratio = 0.003,
		biomes = {"ethereal_fiery"},
		y_min = 1,
		y_max = 100,
		schematic = ethereal.volcanol,
		flags = "place_center_x, place_center_z",
		spawn_by = "ethereal:fiery_dirt",
		num_spawn_by = 8,
		rotation = "random",
	})
end

-- default jungle tree
add_schem({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.0002, {"ethereal_junglee"}, 1, 100, dpath .. "jungle_tree.mts", ethereal.junglee)

-- willow tree
add_schem({"ethereal:gray_dirt"}, 0.02, {"ethereal_grayness"}, 1, 100, ethereal.willow, ethereal.grayness)

-- pine tree (default for lower elevation and ethereal for higher)
add_schem({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"}, 0.025, {"ethereal_snowy"}, 10, 40, ethereal.pinetree, ethereal.snowy)


add_schem({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"}, 0.020, nil, 6500, 7500, ethereal.pinetree, ethereal.snowy)


-- -- default apple tree
add_schem({"default:dirt_with_grass"}, 0.004, {"ethereal_jumble"}, 1, 100, dpath .. "apple_tree.mts", ethereal.grassy)
add_schem({"default:dirt_with_grass"}, 0.004, {"ethereal_grassy"}, 1, 100, dpath .. "apple_tree.mts", ethereal.grassy)


-- big old tree
add_schem({"default:dirt_with_grass"}, 0.0001, {"ethereal_jumble"}, 1, 100, ethereal.bigtree, ethereal.jumble)

-- aspen tree
add_schem({"default:dirt_with_grass"}, 0.0008, {"ethereal_grassytwo"}, 1, 50, dpath .. "aspen_tree.mts", ethereal.jumble)

-- birch tree
add_schem({"default:dirt_with_grass"}, 0.0006, {"ethereal_grassytwo"}, 50, 100, ethereal.birchtree, ethereal.grassytwo)


-- orange tree
add_schem({"ethereal:prairie_dirt"}, 0.005, {"ethereal_prairie"}, 1, 100, ethereal.orangetree, ethereal.prairie)

-- default acacia tree
add_schem({"default:dirt_with_dry_grass"}, 0.002, {"ethereal_savannah"}, 1, 100, dpath .. "acacia_tree.mts", ethereal.savannah)


-- large cactus (by Paramat)
if ethereal.desert == 1 then
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
	biomes = {"ethereal_desert"},
	y_min = 5,
	y_max = 6000,
	schematic = dpath.."large_cactus.mts",
	flags = "place_center_x", --, place_center_z",
	rotation = "random",
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
end

-- palm tree
add_schem({"default:sand"}, 0.001, {"ethereal_desert_ocean"}, 1, 1, ethereal.palmtree, ethereal.desert)
add_schem({"default:sand"}, 0.001, {"ethereal_plains_ocean"}, 1, 1, ethereal.palmtree, ethereal.plains)
add_schem({"default:sand"}, 0.001, {"ethereal_sandclay"}, 1, 1, ethereal.palmtree, ethereal.sandclay)
add_schem({"default:sand"}, 0.001, {"ethereal_sandstone_ocean"}, 1, 1, ethereal.palmtree, ethereal.sandstone)
add_schem({"default:sand"}, 0.001, {"ethereal_mesa_ocean"}, 1, 1, ethereal.palmtree, ethereal.mesa)
add_schem({"default:sand"}, 0.001, {"ethereal_grove_ocean"}, 1, 1, ethereal.palmtree, ethereal.grove)
add_schem({"default:sand"}, 0.001, {"ethereal_grassy_ocean"}, 1, 1, ethereal.palmtree, ethereal.grassy)



-- bamboo tree
add_schem({"ethereal:bamboo_dirt"}, 0.025, {"ethereal_bamboo"}, 1, 100, ethereal.bambootree, ethereal.bamboo)

-- bush
add_schem({"ethereal:bamboo_dirt"}, 0.08, {"ethereal_bamboo"}, 1, 100, ethereal.bush, ethereal.bamboo)

-- vine tree
add_schem({"default:dirt_with_grass"}, 0.0005, {"ethereal_swamp"}, 1, 100, ethereal.vinetree, ethereal.swamp)

-- water pools in swamp areas if 5.0 detected
if minetest.registered_nodes["default:permafrost"] then
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = -1,
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"ethereal_swamp"},
	y_max = 2,
	y_min = 1,
	flags = "force_placement",
	decoration = "default:water_source",
	spawn_by = "default:dirt_with_grass",
	num_spawn_by = 8,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = -1,
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"ethereal_swamp"},
	y_max = 2,
	y_min = 1,
	flags = "force_placement",
	decoration = "default:water_source",
	spawn_by = {"default:dirt_with_grass", "default:water_source"},
	num_spawn_by = 8,
})
end

-- bush
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
	sidelen = 16,
	noise_params = {
		offset = -0.004,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 137,
		octaves = 3,
		persist = 0.7,
	},
	biomes = {"ethereal_grassy", "ethereal_grassytwo", "ethereal_jumble"},
	y_min = 1,
	y_max = 6000,
	schematic = dpath .. "/bush.mts",
	flags = "place_center_x, place_center_z",
})

-- Acacia bush
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.004,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 90155,
		octaves = 3,
		persist = 0.7,
	},
	biomes = {"ethereal_savannah", "ethereal_mesa"},
	y_min = 1,
	y_max = 6000,
	schematic = dpath .. "/acacia_bush.mts",
	flags = "place_center_x, place_center_z",
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

--firethorn shrub
add_node({"default:snowblock"}, 0.001, {"ethereal_glacier"}, 1, 30, {"ethereal:firethorn"}, nil, nil, nil, ethereal.glacier)


-- scorched tree
add_node({"ethereal:dry_dirt"}, 0.006, {"ethereal_plains"}, 1, 100, {"ethereal:scorched_tree"}, 6, nil, nil, ethereal.plains)

-- dry shrub
add_node({"ethereal:dry_dirt"}, 0.015, {"ethereal_plains"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.plains)


add_node({"default:sand"}, 0.015, {"ethereal_grassy_ocean"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.grassy)


add_node({"default:desert_sand"}, 0.015, {"ethereal_desert"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.desert)


add_node({"default:sandstone"}, 0.015, {"ethereal_sandstone"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.sandstone)
add_node({"bakedclay:red", "bakedclay:orange"}, 0.015, {"ethereal_mesa"}, 1, 100, {"default:dry_shrub"}, nil, nil, nil, ethereal.mesa)

-- dry grass
add_node({"default:dirt_with_dry_grass"}, 0.25, {"ethereal_savannah"}, 1, 100, {"default:dry_grass_2",
	"default:dry_grass_3", "default:dry_grass_4", "default:dry_grass_5"}, nil, nil, nil, ethereal.savannah)
add_node({"default:dirt_with_dry_grass"}, 0.10, {"ethereal_mesa"}, 1, 100, {"default:dry_grass_2",
	"default:dry_grass_3", "default:dry_grass_4", "default:dry_grass_5"}, nil, nil, nil, ethereal.mesa)
	

add_node({"default:desert_stone"}, 0.005, {"ethereal_caves"}, 5, 40, {"default:dry_grass_2",
	"default:dry_grass_3", "default:dry_shrub"}, nil, nil, nil, ethereal.caves)

-- flowers & strawberry
add_node({"default:dirt_with_grass"}, 0.025, {"ethereal_grassy"}, 1, 100, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7"}, nil, nil, nil, ethereal.grassy)
add_node({"default:dirt_with_grass"}, 0.025, {"ethereal_grassytwo"}, 1, 100, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7"}, nil, nil, nil, ethereal.grassytwo)



-- prairie flowers & strawberry
add_node({"ethereal:prairie_dirt"}, 0.035, {"ethereal_prairie"}, 1, 100, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7", "flowers:chrysanthemum_green", "flowers:tulip_black"}, nil, nil, nil, ethereal.prairie)
	
add_node({"ethereal:prairie_dirt"}, 0.015, nil, 6500, 7500, {"flowers:dandelion_white",
	"flowers:dandelion_yellow", "flowers:geranium", "flowers:rose", "flowers:tulip",
	"flowers:viola", "ethereal:strawberry_7", "flowers:chrysanthemum_green", "flowers:tulip_black"}, nil, nil, nil, ethereal.prairie)

-- crystal spike & crystal grass
add_node({"ethereal:crystal_dirt"}, 0.02, {"ethereal_frost"}, 1, 200, {"ethereal:crystal_spike",
	"ethereal:crystalgrass"}, nil, nil, nil, ethereal.frost)




-- red shrub
add_node({"ethereal:fiery_dirt"}, 0.10, {"ethereal_fiery"}, 1, 100, {"ethereal:dry_shrub"}, nil, nil, nil, ethereal.fiery)



-- fire flower
--add_node({"ethereal:fiery_dirt"}, 0.02, {"ethereal_fiery"}, 1, 100, {"ethereal:fire_flower"}, nil, nil, nil, ethereal.fiery)

-- snowy grass
add_node({"ethereal:gray_dirt"}, 0.05, {"ethereal_grayness"}, 1, 100, {"ethereal:snowygrass"}, nil, nil, nil, ethereal.grayness)
add_node({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"}, 0.05, {"ethereal_snowy"}, 1, 100, {"ethereal:snowygrass"}, nil, nil, nil, ethereal.snowy)

-- cactus
add_node({"default:sandstone"}, 0.0025, {"ethereal_sandstone"}, 1, 100, {"default:cactus"}, 3, nil, nil, ethereal.sandstone)
add_node({"default:desert_sand"}, 0.005, {"ethereal_desert"}, 1, 100, {"default:cactus"}, 4, nil, nil, ethereal.desert)

-- wild red mushroom
add_node({"ethereal:mushroom_dirt"}, 0.01, {"ethereal_mushroom"}, 1, 100, {"flowers:mushroom_fertile_red"}, nil, nil, nil, ethereal.mushroom)

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
	biomes = {row[1]},
	y_min = 1,
	y_max = 120,
	decoration = {"flowers:mushroom_brown", "flowers:mushroom_red"},
})
end

end

-- jungle grass
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.02, {"ethereal_junglee"}, 1, 100, {"default:junglegrass"}, nil, nil, nil, ethereal.junglee)
add_node({"default:dirt_with_grass"}, 0.02, {"ethereal_jumble"}, 1, 100, {"default:junglegrass"}, nil, nil, nil, ethereal.jumble)
add_node({"default:dirt_with_grass"}, 0.02, {"ethereal_swamp"}, 1, 100, {"default:junglegrass"}, nil, nil, nil, ethereal.swamp)


-- grass
add_node({"default:dirt_with_grass"}, 0.05, {"ethereal_grassy"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.grassy)
add_node({"default:dirt_with_grass"}, 0.05, {"ethereal_grassytwo"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.grassytwo)
add_node({"default:dirt_with_grass"}, 0.05, {"ethereal_jumble"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.jumble)
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.35, {"ethereal_junglee"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.junglee)
add_node({"ethereal:prairie_dirt"}, 0.05, {"ethereal_prairie"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.prairie)
add_node({"ethereal:grove_dirt"}, 0.05, {"ethereal_grove"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.grove)
add_node({"ethereal:bamboo_dirt"}, 0.05, {"ethereal_bamboo"}, 1, 100, {"default:grass_2", "default:grass_3",
	"default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.bamboo)
add_node({"default:dirt_with_grass"}, 0.05, {"ethereal_clearing", "swamp"}, 1, 100, {"default:grass_3",
	"default:grass_4"}, nil, nil, nil, 1)
add_node({"ethereal:bamboo_dirt"}, 0.05, {"ethereal_sakura"}, 1, 100, {"default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"}, nil, nil, nil, ethereal.sakura)

-- grass on sand (and maybe blueberry bush)
if minetest.registered_nodes["default:marram_grass_1"] then

add_node({"default:sand"}, 0.25, {"ethereal_sandclay"}, 3, 4, {"default:marram_grass_1",
	"default:marram_grass_2", "default:marram_grass_3"}, nil, nil, nil, ethereal.sandclay)

-- Blueberry bush
minetest.register_decoration({
	name = "default:blueberry_bush",
	deco_type = "schematic",
	place_on = {"default:dirt_with_coniferous_litter", "default:dirt_with_snow"},
	sidelen = 16,
	noise_params = {
		offset = -0.004,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 697,
		octaves = 3,
		persist = 0.7,
	},
	biomes = {"ethereal_snowy", "ethereal_alpine"},
	y_max = 6000,
	y_min = 1,
	place_offset_y = 1,
	schematic = minetest.get_modpath("default")
		.. "/schematics/blueberry_bush.mts",
	flags = "place_center_x, place_center_z",
})
else
add_node({"default:sand"}, 0.25, {"ethereal_sandclay"}, 3, 4, {"default:grass_2", "default:grass_3"}, nil, nil, nil, ethereal.sandclay)
end

-- ferns
add_node({"ethereal:grove_dirt"}, 0.2, {"ethereal_grove"}, 1, 100, {"ethereal:fern"}, nil, nil, nil, ethereal.grove)
add_node({"default:dirt_with_grass"}, 0.1, {"ethereal_swamp"}, 1, 100, {"ethereal:fern"}, nil, nil, nil, ethereal.swamp)

-- snow
add_node({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"}, 0.8, {"ethereal_snowy"}, 4, 40, {"default:snow"}, nil, nil, nil, ethereal.snowy)
add_node({"default:dirt_with_snow"}, 0.8, {"ethereal_alpine"}, 40, 140, {"default:snow"}, nil, nil, nil, ethereal.alpine)

-- wild onion
add_node({"default:dirt_with_grass"}, 0.25, {"ethereal_grassy"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.grassy)
add_node({"default:dirt_with_grass"}, 0.25, {"ethereal_grassytwo"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.grassytwo)
add_node({"default:dirt_with_grass"}, 0.25, {"ethereal_jumble"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.jumble)
add_node({"ethereal:prairie_dirt"}, 0.25, {"ethereal_prairie"}, 1, 100, {"ethereal:onion_4"}, nil, nil, nil, ethereal.prairie)

-- papyrus
add_node({"default:dirt_with_grass"}, 0.1, {"ethereal_grassy"}, 1, 1, {"default:papyrus"}, 4, "default:water_source", 1, ethereal.grassy)
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.1, {"ethereal_junglee"}, 1, 1, {"default:papyrus"}, 4, "default:water_source", 1, ethereal.junglee)
add_node({"default:dirt_with_grass"}, 0.1, {"ethereal_swamp"}, 1, 1, {"default:papyrus"}, 4, "default:water_source", 1, ethereal.swamp)



--= Farming Redo plants

if farming and farming.mod and farming.mod == "redo" then

print ("[MOD] Ethereal - Farming Redo detected and in use")

-- potato
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.035, {"ethereal_junglee"}, 1, 100, {"farming:potato_3"}, nil, nil, nil, ethereal.junglee)

add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.035, nil, 6500, 7500, {"farming:potato_3"}, nil, nil, nil, ethereal.junglee)


-- carrot, cucumber, potato, tomato, corn, coffee, raspberry, rhubarb
add_node({"default:dirt_with_grass"}, 0.02, {"ethereal_grassytwo"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4"}, nil, nil, nil, ethereal.grassytwo)
add_node({"default:dirt_with_grass"}, 0.02, {"ethereal_grassy"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4",
	"farming:beetroot_5"}, nil, nil, nil, ethereal.grassy)
add_node({"default:dirt_with_grass"}, 0.02, {"ethereal_jumble"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4"}, nil, nil, nil, ethereal.jumble)
add_node({"ethereal:prairie_dirt"}, 0.02, {"ethereal_prairie"}, 1, 100, {"farming:carrot_7", "farming:cucumber_4",
	"farming:potato_3", "farming:tomato_7", "farming:corn_8", "farming:coffee_5",
	"farming:raspberry_4", "farming:rhubarb_3", "farming:blueberry_4",
	"farming:pea_5", "farming:beetroot_5"}, nil, nil, nil, ethereal.prairie)



-- melon and pumpkin
add_node({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"}, 0.015, {"ethereal_junglee"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.junglee)
add_node({"default:dirt_with_grass"}, 0.010, {"ethereal_grassy"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.grassy)
add_node({"default:dirt_with_grass"}, 0.0105, {"ethereal_grassytwo"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.grassytwo)
add_node({"default:dirt_with_grass"}, 0.010, {"ethereal_jumble"}, 1, 1, {"farming:melon_8", "farming:pumpkin_8"}, nil, "default:water_source", 1, ethereal.jumble)



-- green beans
add_node({"default:dirt_with_grass"}, 0.015, {"ethereal_grassytwo"}, 1, 100, {"farming:beanbush"}, nil, nil, nil, ethereal.grassytwo)

-- grape bushel
add_node({"default:dirt_with_grass"}, 0.015, {"ethereal_grassytwo"}, 1, 100, {"farming:grapebush"}, nil, nil, nil, ethereal.grassytwo)
add_node({"default:dirt_with_grass"}, 0.015, {"ethereal_grassy"}, 1, 100, {"farming:grapebush"}, nil, nil, nil, ethereal.grassy)
add_node({"ethereal:prairie_dirt"}, 0.015, {"ethereal_prairie"}, 1, 100, {"farming:grapebush"}, nil, nil, nil, ethereal.prairie)



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
	y_min = 5,
	y_max = 35,
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
		persist = 0.6
	},
	y_min = 5,
	y_max = 35,
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
		persist = 0.6
	},
	y_min = 18,
	y_max = 30,
	decoration = {"farming:pineapple_8"},
})

end

-- place waterlily in beach areas
local list = {
	{"ethereal_desert_ocean", ethereal.desert},
	{"ethereal_plains_ocean", ethereal.plains},
	{"ethereal_sandclay", ethereal.sandclay},
	{"ethereal_sandstone_ocean", ethereal.sandstone},
	{"ethereal_mesa_ocean", ethereal.mesa},
	{"ethereal_grove_ocean", ethereal.grove},
	{"ethereal_grassy_ocean", ethereal.grassy},
	{"ethereal_swamp_ocean", ethereal.swamp},
}

-- for _, row in pairs(list) do

	-- if row[2] == 1 then

	-- minetest.register_decoration({
		-- deco_type = "schematic",
		-- place_on = {"default:sand"},
		-- sidelen = 16,
		-- noise_params = {
			-- offset = -0.12,
			-- scale = 0.3,
			-- spread = {x = 200, y = 200, z = 200},
			-- seed = 33,
			-- octaves = 3,
			-- persist = 0.7
		-- },
		-- biomes = {row[1]},
		-- y_min = 0,
		-- y_max = 0,
		-- schematic = ethereal.waterlily,
		-- rotation = "random",
	-- })

	-- end

-- end

local random = math.random

-- Generate Illumishroom in caves next to coal
minetest.register_on_generated(function(minp, maxp)

	if minp.y > -30 or maxp.y < -3000 then
		return
	end

	local bpos
	local coal = minetest.find_nodes_in_area_under_air(
			minp, maxp, "default:stone_with_coal")

	for n = 1, #coal do

		if random(1, 2) == 1 then

			bpos = {x = coal[n].x, y = coal[n].y + 1, z = coal[n].z }

			if bpos.y > -3000 and bpos.y < -2000 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom3"})

			elseif bpos.y > -2000 and bpos.y < -1000 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom2"})

			elseif bpos.y > -1000 and bpos.y < -30 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom"})
			end
		end
	end
end)

-- coral reef (0.4.15 only)
if ethereal.reefs == 1 then

-- override corals so crystal shovel can pick them up intact
minetest.override_item("default:coral_skeleton", {groups = {crumbly = 3}})
minetest.override_item("default:coral_orange", {groups = {crumbly = 3}})
minetest.override_item("default:coral_brown", {groups = {crumbly = 3}})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		noise_params = {
			offset = -0.15,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 7013,
			octaves = 3,
			persist = 1,
		},
		biomes = {
			"ethereal_desert_ocean",
			"ethereal_grove_ocean",
		},
		y_min = -8,
		y_max = -2,
		schematic = path .. "corals.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end


-- is baked clay mod active? add new flowers if so
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
		persist = 0.6
	},
	y_min = 10,
	y_max = 90,
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
		persist = 0.6
	},
	y_min = 15,
	y_max = 90,
	decoration = "bakedclay:thistle",
})


minetest.register_decoration({
	deco_type = "simple",
	place_on = {"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 7135,
		octaves = 3,
		persist = 0.6
	},
	y_min = 1,
	y_max = 90,
	decoration = "bakedclay:lazarus",
	spawn_by = "default:jungletree",
	num_spawn_by = 1,
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
		persist = 0.6
	},
	y_min = 1,
	y_max = 15,
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
	fill_ratio = 0.001,
	biomes = {"ethereal_desert"},
	decoration = {"wine:blue_agave"},
})

end

if ethereal.snowy and minetest.registered_nodes["default:fern_1"] then
local function register_fern_decoration(seed, length)
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
		y_max = 6000,
		y_min = 6,
		decoration = "default:fern_" .. length,
	})
end

register_fern_decoration(14936, 3)
register_fern_decoration(801, 2)
register_fern_decoration(5, 1)


end

if ethereal.tundra and minetest.registered_nodes["default:permafrost"] then
minetest.register_biome({
		name = "tundra_highland",
		node_dust = "default:snow",
		node_riverbed = "default:gravel",
		depth_riverbed = 2,
		y_max = 180,
		y_min = 47,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "ethereal_tundra",
		node_top = "default:permafrost_with_stones",
		depth_top = 1,
		node_filler = "default:permafrost",
		depth_filler = 1,
		node_riverbed = "default:gravel",
		depth_riverbed = 2,
		vertical_blend = 4,
		y_max = 46,
		y_min = 2,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "ethereal_tundra_beach",
		node_top = "default:gravel",
		depth_top = 1,
		node_filler = "default:gravel",
		depth_filler = 2,
		node_riverbed = "default:gravel",
		depth_riverbed = 2,
		vertical_blend = 1,
		y_max = 1,
		y_min = -3,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "ethereal_tundra_ocean",
		node_top = "default:sand",
		depth_top = 1,
		node_filler = "default:sand",
		depth_filler = 3,
		node_riverbed = "default:gravel",
		depth_riverbed = 2,
		vertical_blend = 1,
		y_max = -4,
		y_min = -112,
		heat_point = 0,
		humidity_point = 40,
	})

	-- Tundra moss

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:permafrost_with_stones"},
		sidelen = 4,
		noise_params = {
			offset = -0.8,
			scale = 2.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 53995,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"ethereal_tundra"},
		y_max = 50,
		y_min = 2,
		decoration = "default:permafrost_with_moss",
		place_offset_y = -1,
		flags = "force_placement",
	})

	-- Tundra patchy snow

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {
			"default:permafrost_with_moss",
			"default:permafrost_with_stones",
			"default:stone",
			"default:gravel"
		},
		sidelen = 4,
		noise_params = {
			offset = 0,
			scale = 1.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 172555,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"ethereal_tundra", "ethereal_tundra_beach"},
		y_max = 50,
		y_min = 1,
		decoration = "default:snow",
	})
end

if minetest.get_modpath("butterflies") then
minetest.register_decoration({
	name = "butterflies:butterfly",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
	place_offset_y = 2,
	sidelen = 80,
	fill_ratio = 0.005,
	biomes = {"ethereal_grassy", "ethereal_grassytwo", "ethereal_prairie", "ethereal_jumble"},
	y_max = 6000,
	y_min = 1,
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
		biomes = {"ethereal_grassy", "ethereal_grassytwo", "ethereal_snowy", "ethereal_junglee", "ethereal_swamp"},
		y_max = 6000,
		y_min = -1,
		decoration = "fireflies:hidden_firefly",
	})
	
end

-- Coral Reef (Minetest 5.0)
if minetest.registered_nodes["default:coral_green"] then
	minetest.register_decoration({
		name = "default:corals",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {
			"ethereal_desert_ocean",
			"ethereal_savanna_ocean",
			"ethereal_junglee_ocean",
		},
		y_max = -2,
		y_min = -8,
		flags = "force_placement",
		decoration = {
			"default:coral_green", "default:coral_pink",
			"default:coral_cyan", "default:coral_brown",
			"default:coral_orange", "default:coral_skeleton",
		},
	})

	-- Kelp

	minetest.register_decoration({
		name = "default:kelp",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"ethereal_frost_ocean", "ethereal_grassy_ocean", "ethereal_sandstone_ocean", "ethereal_swamp_ocean"},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = "default:sand_with_kelp",
		param2 = 48,
		param2_max = 96,
	})
end
