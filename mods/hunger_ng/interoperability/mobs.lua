local add = hunger_ng.functions.add_hunger_data

-- Mobs Redo Animals: https://forum.minetest.net/viewtopic.php?t=9917
--
-- The `mobs_redo` mod registers it’s stuff under the `mobs` prefix.

add('mobs:meat',                { satiates = 4 })
add('mobs:meat_raw',            { satiates = 2, heals = -2 })

