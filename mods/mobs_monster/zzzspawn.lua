-- TOPOLOGY
-- caverealms  -1500  to -10033
-- CR DM       -8000  to -9999
-- DF level 1  -10033 to -12032 - break point (no monsters)
-- DF level 2  -12032 to -14032
-- DF level 3  -14032 to -15072
-- Sunless Sea -15072 to -16000 - break point (no monsters)
-- Oil Sea     -16000 to -17000
-- Lava Sea    -17000 to -18000
-- Underworld  -18000 to -19073
-- Primordial  -19073 to -22032 - break point (no monsters)
-- Nether      -25000 to -30000

--mobs:spawn_specific (name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn)


--caverealms monsters -1500  to -10033

--deep caves (-6000 to -8000)

mobs:spawn_specific ("mobs_monster:magma_cube_big", {"default:lava_source", "default:lava_flowing"}, "air", 0, 13, 30, 300, 1, -8000, -6000)

mobs:spawn_specific ("mobs_monster:stone_monster", {"caverealms:stone_with_moss", "caverealms:stone_with_lichen", "caverealms:stone_with_algae"}, "air", 0, 10, 30, 800, 2, -7500, -6000)

mobs:spawn_specific ("mobs_monster:sand_monster", "default:desert_sand", "air", 0, 10, 30, 400, 1, -8000, -6500)

-- caverealms dungeon master layer -8000  to -9999
mobs:spawn_specific ("mobs_monster:dungeon_master", {"caverealms:hot_cobble", "caverealms:glow_obsidian"}, "air", 0, 15, 30, 100, 3, -9950, -8100)

-- DF level 1 - 10033 to -12032
-- you get a break here

-- DF level 2  -12032 to -14032
mobs:spawn_specific ("mobs_monster:slime_big", {"df_mapitems:dirt_with_cave_moss", "df_trees:goblin_cap"}, "air", 0, 10, 60, 100, 2, -14032, -12032)

-- DF level 3  -14032 to 15072

mobs:spawn_specific("mobs_monster:mothman", "df_trees:black_cap", "air", 0, 12, 30, 300, 2, -15072, -14032)

mobs:spawn_specific("mobs_monster:creeper", "df_mapitems:cobble_with_floor_fungus", "air", 0, 12, 90, 300, 1, -15072, -14032)


-- Sunless Sea -15072 to -16000 - break point (no monsters)

-- Lava Sea -17000 to -18000

mobs:spawn_specific ("mobs_monster:lava_flan", {"default:lava_source", "default:lava_flowing"}, "air", 0, 13, 60, 100, 2, -18000, -16900)

-- Underworld -18000 to -19073

mobs:spawn_specific("mobs_monster:skeleton", "df_underworld_items:slade", "air", 0, 7, 90, 1000, 1, -19073, -17500)

-- Primordial  -19073 to -22032 - break point (no monsters)

-- Nether
mobs:spawn_specific ("mobs_monster:oerkki", "nether:rack", "air", 0, 14, 60, 500, 2, -30900, -25100)





--mobs:spawn_specific ("mobs_monster:zombie", "default:dirt_with_grass", "air", 0, 15, 10, 30, 10, -100, 100)
--mobs:spawn_specific ("mobs_monster:tree_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)
--mobs:spawn_specific ("mobs_monster:stone_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)
--mobs:spawn_specific ("mobs_monster:spider", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)



--mobs:spawn_specific ("mobs_monster:sand_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)


-- CR DM       -8000  to -9999

--mobs:spawn_specific ("mobs_monster:dirt_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)


