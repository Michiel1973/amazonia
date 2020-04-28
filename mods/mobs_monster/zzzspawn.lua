-- TOPOLOGY
-- caverealms  -1500  to -10033
-- CR DM       -8000  to -9999
-- DF level 1  -10033 to -12032
-- DF level 2  -12032 to -14032
-- DF level 3  -14032 to -15072
-- Sunless Sea -15072 to -16000
-- Oil Sea     -16000 to -17000
-- Lava Sea    -17000 to -18000
-- Underworld  -18000 to -19073
-- Primordial  -19073 to -22032
-- Nether      -25000 to -30000

--mobs:spawn_specific (name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn)


--caverealms monsters
mobs:spawn_specific ("mobs_monster:lava_flan", {"default:lava_source", "default:lava_flowing"}, "air", 0, 13, 60, 100, 2, -8000, -6000)
mobs:spawn_specific ("mobs_monster:magma_cube_big", {"default:lava_source", "default:lava_flowing"}, "air", 0, 13, 60, 300, 1, -8000, -6000)

-- caverealms dungeon master layer
mobs:spawn_specific ("mobs_monster:dungeon_master", {"caverealms:hot_cobble", "default:stone"}, "air", 0, 13, 60, 400, 2, -9950, -8100)

-- DF level 1
mobs:spawn_specific ("mobs_monster:slime_big", "df_mapitems:dirt_with_cave_moss", "air", 0, 10, 30, 100, 2, -12032, -10033)


-- Nether
mobs:spawn_specific ("mobs_monster:oerkki", "nether:rack", "air", 0, 14, 60, 500, 2, -30900, -25100)





--mobs:spawn_specific ("mobs_monster:zombie", "default:dirt_with_grass", "air", 0, 15, 10, 30, 10, -100, 100)
--mobs:spawn_specific ("mobs_monster:tree_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)
--mobs:spawn_specific ("mobs_monster:stone_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)
--mobs:spawn_specific ("mobs_monster:spider", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)



--mobs:spawn_specific ("mobs_monster:sand_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)


-- CR DM       -8000  to -9999
mobs:spawn_specific ("mobs_monster:dungeon_master", "caverealms:hot_cobble", "air", 0, 15, 60, 9000, 2, -8100, -9950)
--mobs:spawn_specific ("mobs_monster:dirt_monster", "default:dirt_with_grass", "air", 0, 10, 30, 10, 10, -100, 100)


