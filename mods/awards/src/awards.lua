-- Copyright (c) 2013-18 rubenwardy and Wuzzy. MIT.

local S = awards.gettext

awards.register_award("award_dflevel1",{
		title = S("In the Deep Realms"),
		description = S("Mine below 10k depth."),
		icon = "awards_master_miner.png^awards_level2.png",
		background = "awards_bg_mining.png",
		difficulty = 1,
		secret = true,
	})
	awards.register_on_dig(function(player,data)
		local pos = player:get_pos()
		if pos and pos.y < -10000 and pos.y > -18000 then
			return "award_dflevel1"
		end
		return nil
end)

awards.register_award("award_underworld",{
		title = S("The Underworld"),
		description = S("Digging the Underworld"),
		icon = "awards_master_miner.png^awards_level3.png",
		background = "awards_bg_mining.png",
		difficulty = 2,
		secret = true,
	})
	awards.register_on_dig(function(player,data)
		local pos = player:get_pos()
		if pos and pos.y < -18000 and pos.y > -25000 then
			return "award_underworld"
		end
		return nil
end)

awards.register_award("award_nether",{
		title = S("The Nether"),
		description = S("Found the Nether"),
		icon = "awards_master_miner.png^awards_level4.png",
		background = "awards_bg_mining.png",
		difficulty = 3,
		secret = true,
	})
	awards.register_on_dig(function(player,data)
		local pos = player:get_pos()
		if pos and pos.y < -25000 and pos.y > -31000 then
			return "award_nether"
		end
		return nil
end)

-- Saint-Maclou
if minetest.get_modpath("moreblocks") then
	awards.register_award("award_saint_maclou",{
		title = S("Saint-Maclou"),
		description = S("Place 20 coal checkers."),
		icon = "awards_saint_maclou.png",
		trigger = {
			type = "place",
			node = "moreblocks:coal_checker",
			target = 20
		}
	})

	-- Castorama
	awards.register_award("award_castorama",{
		title = S("Castorama"),
		description = S("Place 20 iron checkers."),
		icon = "awards_castorama.png",
		trigger = {
			type = "place",
			node = "moreblocks:iron_checker",
			target = 20
		}
	})

	-- Sam the Trapper
	awards.register_award("award_sam_the_trapper",{
		title = S("Sam the Trapper"),
		description = S("Place 2 trap stones."),
		icon = "awards_sam_the_trapper.png",
		trigger = {
			type = "place",
			node = "moreblocks:trap_stone",
			target = 2
		}
	})
end

-- This award can't be part of Unified Inventory, it would make a circular dependency
if minetest.get_modpath("unified_inventory") then
	if minetest.get_all_craft_recipes("unified_inventory:bag_large") ~= nil then
		awards.register_award("awards_ui_bags", {
			title = S("Backpacker"),
			description = S("Craft 4 large bags."),
			icon = "awards_backpacker.png",
			trigger = {
				type = "craft",
				item = "unified_inventory:bag_large",
				target = 4
			}
		})
	end
end

if minetest.get_modpath("fire") then
	awards.register_award("awards_pyro", {
		title = S("Pyromaniac"),
		description = S("Craft 8 flint and steel."),
		icon = "awards_pyromaniac.png",
		trigger = {
			type = "craft",
			item = "fire:flint_and_steel",
			target = 8
		}
	})
	if minetest.settings:get_bool("disable_fire") ~= true then
		awards.register_award("awards_firefighter", {
			title = S("Firefighter"),
			description = S("Put out 1000 fires."),
			icon = "awards_firefighter.png",
			trigger = {
				type = "dig",
				node = "fire:basic_flame",
				target = 1000
			}
		})
	end


	-- Burned to death
	awards.register_award("award_burn", {
		title = S("You're a witch!"),
		description = S("Burn to death in a fire."),
		secret = true,
	})
	awards.register_on_death(function(player,data)
		local pos = player:get_pos()
		if pos and minetest.find_node_near(pos, 2, "fire:basic_flame") ~= nil then
			return "award_burn"
		end
		return nil
	end)
end

-- You Suck!
awards.register_award("award_you_suck", {
	title = S("You Suck!"),
	description = S("Die 100 times."),
	trigger = {
		type = "death",
		target = 100
	},
	secret = true,
})

awards.register_award("award_you_really_suck", {
	title = S("You Really Suck!"),
	description = S("Die 1000 times."),
	secret = true,
	trigger = {
		type = "death",
		target = 1000
	},
	secret = true,
})

awards.register_award("award_wow_really", {
	title = S("Wow, really?"),
	description = S("Die 10000 times."),
	secret = true,
	trigger = {
		type = "death",
		target = 1000
	},
	secret = true,
})

-- Die underground
awards.register_award("award_deep_down", {
	title = S("Death in the Deeps"),
	description = S("Die below -10000"),
	secret = true,
})
awards.register_on_death(function(player,data)
	local pos = player:get_pos()
	if pos and pos.y < -10000 and pos.y > -18000 then
		return "award_deep_down"
	end
	return nil
end)

awards.register_award("award_death_underworld", {
	title = S("Undertaker"),
	description = S("Die in the Underworld"),
	secret = true,
})
awards.register_on_death(function(player,data)
	local pos = player:get_pos()
	if pos and pos.y < -18000 and pos.y > -25000 then
		return "award_death_underworld"
	end
	return nil
end)

awards.register_award("award_death_nether", {
	title = S("Nether Better"),
	description = S("Die in the Nether"),
	secret = true,
})
awards.register_on_death(function(player,data)
	local pos = player:get_pos()
	if pos and pos.y < -25000 and pos.y > -31000 then
		return "award_death_nether"
	end
	return nil
end)



-- Die in space
awards.register_award("award_no_screen", {
	title = S("In space, no one can hear you scream"),
	description = S("Die above 15000"),
	secret = true,
})
awards.register_on_death(function(player,data)
	local pos = player:get_pos()
	if pos and pos.y > 15000 then
		return "award_no_screen"
	end
	return nil
end)

if minetest.get_modpath("default") then
	-- Light it up
	awards.register_award("award_lightitup",{
		title = S("Light It Up"),
		description = S("Place 100 torches."),
		icon = "awards_light_it_up.png^awards_level1.png",
		difficulty = 0.01,
		trigger = {
			type = "place",
			node = "default:torch",
			target = 100
		}
	})

	-- Light ALL the things!
	awards.register_award("award_well_lit",{
		title = S("Well Lit"),
		icon = "awards_well_lit.png^awards_level2.png",
		description = S("Place 1000 torches."),
		difficulty = 0.01,
		trigger = {
			type = "place",
			node = "default:torch",
			target = 1000
		}
	})
	
	awards.register_award("award_lightbringer",{
		title = S("Lightbringer"),
		icon = "awards_well_lit.png^awards_level3.png",
		description = S("Place 10000 torches."),
		difficulty = 0.01,
		secret = true,
		trigger = {
			type = "place",
			node = "default:torch",
			target = 1000
		}
	})

	awards.register_award("award_meselamp",{
		title = S("Really Well Lit"),
		description = S("Craft 10 mese lamps."),
		icon = "awards_really_well_lit.png",
		difficulty = 0.2,
		trigger = {
			type = "craft",
			item = "default:meselamp",
			target = 10
		}
	})

	awards.register_award("awards_stonebrick", {
		title = S("Outpost"),
		description = S("Craft 200 stone bricks."),
		icon = "awards_outpost.png^awards_level1.png",
		difficulty = 0.08,
		trigger = {
			type = "craft",
			item = "default:stonebrick",
			target = 200
		}
	})

	awards.register_award("awards_stonebrick2", {
		title = S("Watchtower"),
		description = S("Craft 800 stone bricks."),
		icon = "awards_watchtower.png^awards_level2.png",
		difficulty = 0.08,
		trigger = {
			type = "craft",
			item = "default:stonebrick",
			target = 800
		}
	})

	awards.register_award("awards_stonebrick3", {
		title = S("Fortress"),
		description = S("Craft 3200 stone bricks."),
		icon = "awards_fortress.png^awards_level3.png",
		difficulty = 0.08,
		trigger = {
			type = "craft",
			item = "default:stonebrick",
			target = 3200
		}
	})

	awards.register_award("awards_desert_stonebrick", {
		title = S("Desert Dweller"),
		description = S("Craft 1000 desert stone bricks."),
		icon = "awards_desert_dweller.png",
		difficulty = 0.09,
		trigger = {
			type = "craft",
			item = "default:desert_stonebrick",
			target = 1000
		}
	})

	awards.register_award("awards_desertstonebrick", {
		title = S("Pharaoh"),
		description = S("Craft 1000 sandstone bricks."),
		icon = "awards_pharaoh.png",
		difficulty = 0.09,
		trigger = {
			type = "craft",
			item = "default:sandstonebrick",
			target = 1000
		}
	})

	awards.register_award("awards_bookshelf", {
		title = S("Reader"),
		description = S("Craft a bookshelf."),
		icon = "awards_little_library.png^awards_level1.png",
		difficulty = 0.2,
		trigger = {
			type = "craft",
			item = "default:bookshelf",
			target = 1
		}
	})
	
	awards.register_award("awards_manybookshelves", {
		title = S("Librarian"),
		description = S("Craft 100 bookshelves."),
		icon = "awards_little_library.png^awards_level2.png",
		difficulty = 0.2,
		secret = true,
		trigger = {
			type = "craft",
			item = "default:bookshelf",
			target = 100
		}
	})

	awards.register_award("awards_obsidian", {
		title = S("Lava and Water"),
		description = S("Mine obsidian."),
		icon = "awards_lava_and_water.png^awards_level1.png",
		background = "awards_bg_mining.png",
		difficulty = 1.5,
		trigger = {
			type = "dig",
			node = "default:obsidian",
			target = 1
		}
	})

	-- Obsessed with Obsidian
	awards.register_award("award_obsessed_with_obsidian",{
		title = S("Obsessed with Obsidian"),
		description = S("Mine 5000 obsidian."),
		icon = "awards_obsessed_with_obsidian.png^awards_level2.png",
		background = "awards_bg_mining.png",
		difficulty = 1.5,
		trigger = {
			type = "dig",
			node = "default:obsidian",
			target = 5000
		}
	})
	
	awards.register_award("award_obsidian_everywhere",{
		title = S("Obsidian Everywhere"),
		description = S("Mine 10000 obsidian."),
		icon = "awards_obsessed_with_obsidian.png^awards_level3.png",
		background = "awards_bg_mining.png",
		secret = true,
		difficulty = 1.5,
		trigger = {
			type = "dig",
			node = "default:obsidian",
			target = 10000
		}
	})


	-- Proof that player has found lava
	awards.register_award("award_lavaminer",{
		title = S("Lava Miner"),
		description = S("Mine any block while being very close to lava."),
		icon = "awards_lava_miner.png",
		background = "awards_bg_mining.png",
		difficulty = 1,
	})
	awards.register_on_dig(function(player,data)
		local pos = player:get_pos()
		if pos and (minetest.find_node_near(pos, 1, "default:lava_source") or
				minetest.find_node_near(pos, 1, "default:lava_flowing")) then
			return "award_lavaminer"
		end
		return nil
	end)

	-- On the way
	awards.register_award("award_on_the_way", {
		title = S("On The Way"),
		description = S("Place 1000 rails."),
		icon = "awards_on_the_way.png",
		secret = true,
		difficulty = 0.1,
		trigger = {
			type = "place",
			node = "carts:rail",
			target = 1000
		}
	})
	
	awards.register_award("award_railroading", {
		title = S("Railroadin'"),
		description = S("Place 1000 mese rails."),
		icon = "awards_on_the_way.png",
		secret = true,
		difficulty = 0.1,
		trigger = {
			type = "place",
			node = "carts:powerrail",
			target = 1000
		}
	})

	awards.register_award("award_railroad_magnate", {
		title = S("Railroad Magnate"),
		description = S("Place 10000 mese rails."),
		icon = "awards_on_the_way.png",
		secret = true,
		difficulty = 0.1,
		trigger = {
			type = "place",
			node = "carts:powerrail",
			target = 10000
		}
	})
	
	
	awards.register_award("award_lumberjack_firstday", {
		title = S("A Day in the Woods"),
		description = S("Dig 100 tree blocks."),
		icon = "awards_first_day_in_the_woods.png^awards_level1.png",
		difficulty = 0.03,
		trigger = {
			type = "dig",
			node = "default:tree",
			target = 100
		}
	})

	-- Lumberjack
	awards.register_award("award_lumberjack", {
		title = S("Lumberjack"),
		description = S("Dig 1000 tree blocks."),
		icon = "awards_lumberjack.png^awards_level2.png",
		difficulty = 0.03,
		trigger = {
			type = "dig",
			node = "default:tree",
			target = 1000
		}
	})

	-- Semi-pro Lumberjack
	awards.register_award("award_lumberjack_semipro", {
		title = S("Semi-pro Lumberjack"),
		description = S("Dig 10000 tree blocks."),
		icon = "awards_semi_pro_lumberjack.png^awards_level3.png",
		difficulty = 0.03,
		trigger = {
			type = "dig",
			node = "default:tree",
			target = 5000
		}
	})

	-- Professional Lumberjack
	awards.register_award("award_lumberjack_professional", {
		title = S("Professional Lumberjack"),
		description = S("Dig 10000 tree blocks."),
		icon = "awards_professional_lumberjack.png^awards_level4.png",
		difficulty = 0.03,
		trigger = {
			type = "dig",
			node = "default:tree",
			target = 10000
		}
	})

	-- Junglebaby
	awards.register_award("award_junglebaby", {
		title = S("Junglebaby"),
		description = S("Dig 100 jungle tree blocks."),
		icon = "awards_junglebaby.png^awards_level1.png",
		difficulty = 0.05,
		trigger = {
			type = "dig",
			node = "default:jungletree",
			target = 100
		}
	})

	-- Jungleman
	awards.register_award("award_jungleman", {
		title = S("Jungleman"),
		description = S("Dig 1000 jungle tree blocks."),
		icon = "awards_jungleman.png^awards_level2.png",
		difficulty = 0.05,
		trigger = {
			type = "dig",
			node = "default:jungletree",
			target = 1000
		}
	})

	-- Found some Mese!
	awards.register_award("award_mesefind", {
		title = S("Mese Find"),
		description = S("Mine mese ore."),
		icon = "awards_first_mese_find.png^awards_level1.png",
		background = "awards_bg_mining.png",
		difficulty = 1,
		trigger = {
			type = "dig",
			node = "default:stone_with_mese",
			target = 1
		}
	})

	awards.register_award("award_hundredmesefind", {
		title = S("Mese Master"),
		description = S("Mine 100 mese ore."),
		icon = "awards_first_mese_find.png^awards_level2.png",
		background = "awards_bg_mining.png",
		secret = true,
		difficulty = 2,
		trigger = {
			type = "dig",
			node = "default:stone_with_mese",
			target = 100
		}
	})
	
	awards.register_award("award_thousandmesefind", {
		title = S("Mese Magnate"),
		description = S("Mine 1000 mese ore."),
		icon = "awards_first_mese_find.png^awards_level3.png",
		background = "awards_bg_mining.png",
		secret = true,
		difficulty = 2,
		trigger = {
			type = "dig",
			node = "default:stone_with_mese",
			target = 1000
		}
	})
	
	-- Mese Block
	awards.register_award("award_meseblock", {
		secret = true,
		title = S("Mese Mastery"),
		description = S("Mine a mese block."),
		icon = "awards_mese_mastery.png",
		background = "awards_bg_mining.png",
		difficulty = 1.1,
		trigger = {
			type = "dig",
			node = "default:mese",
			target = 1
		}
	})

	-- You're a copper
	awards.register_award("award_youre_a_copper", {
		title = S("You’re a copper"),
		description = S("Dig 1000 copper ores."),
		icon = "awards_youre_a_copper.png^awards_level1.png",
		background = "awards_bg_mining.png",
		difficulty = 0.2,
		trigger = {
			type = "dig",
			node = "default:stone_with_copper",
			target = 1000
		}
	})
	
	awards.register_award("award_youre_a_copper2", {
		title = S("Detective"),
		description = S("Dig 5000 copper ores."),
		icon = "awards_youre_a_copper.png^awards_level2.png",
		background = "awards_bg_mining.png",
		secret = true,
		difficulty = 0.2,
		trigger = {
			type = "dig",
			node = "default:stone_with_copper",
			target = 5000
		}
	})
	
	awards.register_award("award_youre_a_copper3", {
		title = S("Detective"),
		description = S("Dig 10000 copper ores."),
		icon = "awards_youre_a_copper.png^awards_level3.png",
		background = "awards_bg_mining.png",
		secret = true,
		difficulty = 0.2,
		trigger = {
			type = "dig",
			node = "default:stone_with_copper",
			target = 10000
		}
	})
	
	awards.register_award("award_mithril", {
		title = S("My precious"),
		description = S("Dig 100 mithril ores."),
		icon = "awards_mithril_miner.png^awards_level1.png",
		background = "awards_bg_mining.png",
		difficulty = 0.2,
		trigger = {
			type = "dig",
			node = "moreores:mithril",
			target = 100
		}
	})
	
	awards.register_award("award_mithril2", {
		title = S("Mithril Master"),
		description = S("Dig 1000 mithril ores."),
		icon = "awards_mithril_miner.png^awards_level2.png",
		background = "awards_bg_mining.png",
		secret = true,
		difficulty = 0.2,
		trigger = {
			type = "dig",
			node = "moreores:mithril",
			target = 1000
		}
	})
	
	awards.register_award("award_mithril3", {
		title = S("Mythic Mithril"),
		description = S("Dig 10000 mithril ores."),
		icon = "awards_mithril_miner.png^awards_level3.png",
		background = "awards_bg_mining.png",
		secret = true,
		difficulty = 0.2,
		trigger = {
			type = "dig",
			node = "moreores:mithril",
			target = 10000
		}
	})

	-- Mini Miner
	awards.register_award("award_mine2", {
		title = S("Mini Miner"),
		description = S("Dig 100 stone blocks."),
		icon = "awards_mini_miner.png^awards_level1.png",
		background = "awards_bg_mining.png",
		difficulty = 0.02,
		trigger = {
			type = "dig",
			node = "default:stone",
			target = 100
		}
	})

	-- Hardened Miner
	awards.register_award("award_mine3", {
		title = S("Hardened Miner"),
		description = S("Dig 1000 stone blocks."),
		icon = "awards_hardened_miner.png^awards_level2.png",
		background = "awards_bg_mining.png",
		difficulty = 0.02,
		trigger = {
			type = "dig",
			node = "default:stone",
			target = 1000
		}
	})

	-- Master Miner
	awards.register_award("award_mine4", {
		title = S("Master Miner"),
		description = S("Dig 10,000 stone blocks."),
		icon = "awards_master_miner.png^awards_level3.png",
		background = "awards_bg_mining.png",
		difficulty = 0.02,
		trigger = {
			type = "dig",
			node = "default:stone",
			target = 10000
		}
	})

	-- Marchand de sable
	awards.register_award("award_marchand_de_sable", {
		title = S("Marchand De Sable"),
		description = S("Dig 1000 sand."),
		icon = "awards_marchand_de_sable.png",
		background = "awards_bg_mining.png",
		difficulty = 0.05,
		trigger = {
			type = "dig",
			node = "default:sand",
			target = 1000
		}
	})

	awards.register_award("awards_crafter_of_sticks", {
		title = S("Crafter of Sticks"),
		description = S("Craft 100 sticks."),
		icon = "awards_crafter_of_sticks.png",
		difficulty = 0.01,
		trigger = {
			type = "craft",
			item = "default:stick",
			target = 100
		}
	})

	awards.register_award("awards_junglegrass", {
		title = S("Jungle Discoverer"),
		description = S("Mine 100 jungle grass."),
		icon = "awards_jungle_discoverer.png",
		difficulty = 0.009,
		trigger = {
			type = "dig",
			node = "default:junglegrass",
			target = 100
		}
	})

	awards.register_award("awards_grass", {
		title = S("Grasslands Discoverer"),
		description = S("Mine 100 grass."),
		icon = "awards_grasslands_discoverer.png",
		difficulty = 0.009,
		trigger = {
			type = "dig",
			node = "default:grass_1",
			target = 100
		}
	})

	awards.register_award("awards_dry_grass", {
		title = S("Savannah Discoverer"),
		description = S("Mine 100 dry grass."),
		icon = "awards_savannah_discoverer.png",
		difficulty = 0.009,
		trigger = {
			type = "dig",
			node = "default:dry_grass_3",
			target = 100
		}
	})

	awards.register_award("awards_cactus", {
		title = S("Desert Discoverer"),
		description = S("Mine 100 cacti."),
		icon = "awards_desert_discoverer.png",
		difficulty = 0.03,
		trigger = {
			type = "dig",
			node = "default:cactus",
			target = 100
		}
	})

	awards.register_award("awards_dry_shrub", {
		title = S("Far Lands"),
		description = S("Mine 100 dry shrub."),
		icon = "awards_far_lands.png",
		difficulty = 0.009,
		trigger = {
			type = "dig",
			node = "default:dry_shrub",
			target = 100
		}
	})

	awards.register_award("awards_ice", {
		title = S("Glacier Discoverer"),
		description = S("Mine 100 ice."),
		icon = "awards_glacier_discoverer.png",
		difficulty = 0.02,
		trigger = {
			type = "dig",
			node = "default:ice",
			target = 100
		}
	})

	-- Proof that player visited snowy lands
	awards.register_award("awards_snowblock", {
		title = S("Snow Man"),
		description = S("Place 100 snow blocks."),
		icon = "awards_very_simple_snow_man.png",
		difficulty = 0.02,
		trigger = {
			type = "place",
			node = "default:snowblock",
			target = 100
		}
	})

	awards.register_award("awards_gold_ore", {
		title = S("Gold Find"),
		description = S("Mine gold ore."),
		icon = "awards_first_gold_find.png^awards_level1.png",
		background = "awards_bg_mining.png",
		difficulty = 0.9,
		trigger = {
			type = "dig",
			node = "default:stone_with_gold",
			target = 1
		}
	})

	awards.register_award("awards_gold_rush", {
		title = S("Gold Rush"),
		description = S("Mine 100 gold ores."),
		icon = "awards_gold_rush.png^awards_level2.png",
		background = "awards_bg_mining.png",
		difficulty = 0.9,
		trigger = {
			type = "dig",
			node = "default:stone_with_gold",
			target = 100
		}
	})

	awards.register_award("awards_diamond_ore", {
		title = S("Wow, I am Diamonds!"),
		description = S("Mine 100 diamond ore."),
		icon = "awards_wow_i_am_diamonds.png^awards_level1.png",
		difficulty = 1,
		trigger = {
			type = "dig",
			node = "default:stone_with_diamond",
			target = 100
		}
	})

	awards.register_award("awards_diamond_rush", {
		title = S("Girl's Best Friend"),
		description = S("Mine 500 diamond ores."),
		icon = "awards_girls_best_friend.png^awards_level2.png",
		background = "awards_bg_mining.png",
		difficulty = 1,
		trigger = {
			type = "dig",
			node = "default:stone_with_diamond",
			target = 500
		}
	})

	awards.register_award("awards_diamondblock", {
		title = S("Hardest Block on Earth"),
		description = S("Craft a diamond block."),
		icon = "awards_hardest_block_on_earth.png",
		difficulty = 1.1,
		trigger = {
			type = "craft",
			item = "default:diamondblock",
			target = 1
		}
	})

	awards.register_award("awards_mossycobble", {
		title = S("In the Dungeon"),
		description = S("Mine a mossy cobblestone."),
		icon = "awards_in_the_dungeon.png",
		difficulty = 0.9,
		trigger = {
			type = "dig",
			node = "default:mossycobble",
			target = 1
		}
	})
	
	awards.register_award("awards_mossycobble2", {
		title = S("Dungeon Master"),
		description = S("Mine 5000 mossy cobblestone."),
		icon = "awards_in_the_dungeon.png^awards_level2.png",
		secret = true,
		difficulty = 0.9,
		trigger = {
			type = "dig",
			node = "default:mossycobble",
			target = 5000
		}
	})

	awards.register_award("award_furnace", {
		title = S("Smelter"),
		description = S("Craft 10 furnaces."),
		icon = "awards_smelter.png",
		difficulty = 0.08,
		trigger = {
			type = "craft",
			item= "default:furnace",
			target = 10
		}
	})

	awards.register_award("award_chest", {
		title = S("Treasurer"),
		description = S("Craft 15 chests."),
		icon = "awards_treasurer.png",
		difficulty = 0.08,
		trigger = {
			type = "craft",
			item= "default:chest",
			target = 15
		}
	})

	awards.register_award("award_chest2", {
		title = S("Banker"),
		description = S("Craft 30 locked chests."),
		icon = "awards_banker.png",
		difficulty = 0.08,
		trigger = {
			type = "craft",
			item= "default:chest_locked",
			target = 30
		}
	})

	awards.register_award("award_brick", {
		title = S("Bricker"),
		description = S("Craft 200 brick blocks."),
		icon = "awards_bricker.png",
		difficulty = 0.03,
		trigger = {
			type = "craft",
			item= "default:brick",
			target = 200
		}
	})

	awards.register_award("award_obsidianbrick", {
		title = S("House of Obsidian"),
		description = S("Craft 100 obsidian bricks."),
		icon = "awards_house_of_obsidian.png",
		difficulty = 0.4,
		trigger = {
			type = "craft",
			item= "default:obsidianbrick",
			target = 100
		}
	})

	awards.register_award("award_placestone", {
		title = S("Build a Cave"),
		description = S("Place 100 stone."),
		icon = "awards_build_a_cave.png",
		difficulty = 0.1,
		trigger = {
			type = "place",
			node = "default:stone",
			target = 100
		}
	})

	awards.register_award("award_woodladder", {
		title = S("Long Ladder"),
		description = S("Place 400 wooden ladders."),
		icon = "awards_long_ladder.png",
		difficulty = 0.1,
		trigger = {
			type = "place",
			node = "default:ladder_wood",
			target = 400
		}
	})

	awards.register_award("award_steelladder", {
		title = S("Industrial Age"),
		description = S("Place 40 steel ladders."),
		icon = "awards_industrial_age.png",
		difficulty = 1,
		trigger = {
			type = "place",
			node = "default:ladder_steel",
			target = 40
		}
	})

	awards.register_award("award_apples", {
		title = S("Yummy!"),
		description = S("Eat 80 apples."),
		icon = "awards_yummy.png",
		difficulty = 0.1,
		secret = true,
		trigger = {
			type = "eat",
			item = "default:apple",
			target = 80
		}
	})

	-- Died in flowing lava
	awards.register_award("award_in_the_flow", {
		title = S("In the Flow"),
		description = S("Die in flowing lava."),
		secret = true,
	})
	awards.register_on_death(function(player,data)
		local pos = player:get_pos()
		if pos and (minetest.find_node_near(pos, 2, "default:lava_flowing") ~= nil or
				minetest.find_node_near(pos, 2, "default:lava_source") ~= nil) then
			return "award_in_the_flow"
		end
		return nil
	end)

	-- Die near diamond ore
awards.register_award("award_this_is_sad", {
		title = S("This is Sad"),
		description = S("Die near diamond ore."),
		secret = true,
	})
	awards.register_on_death(function(player,data)
		local pos = player:get_pos()
		if pos and minetest.find_node_near(pos, 5, "default:stone_with_diamond") ~= nil then
			return "award_this_is_sad"
		end
		return nil
	end)
end

if minetest.get_modpath("bones") then
	-- Die near bones
	awards.register_award("award_the_stack", {
		title = S("Graveyard"),
		description = S("Die near bones."),
		secret = true,
	})
	awards.register_on_death(function(player,data)
		local pos = player:get_pos()
		if pos and minetest.find_node_near(pos, 5, "bones:bones") ~= nil then
			return "award_the_stack"
		end
		return nil
	end)
end

if minetest.get_modpath("vessels") then
	awards.register_award("award_vessels_shelf", {
		title = S("Glasser"),
		icon = "awards_glasser.png",
		description = S("Craft 14 vessels shelves."),
		trigger = {
			type = "craft",
			item= "vessels:shelf",
			target = 14
		}
	})
end

if minetest.get_modpath("farming") then
	awards.register_award("awards_farmer", {
		title = S("Farming Skills"),
		description = S("Harvest 100 grown wheat plants."),
		icon = "awards_farming_skills_acquired.png^awards_level1.png",
		trigger = {
			type = "dig",
			node = "farming:wheat_8",
			target = 100
		}
	})
	awards.register_award("awards_farmer2", {
		title = S("Field Worker"),
		description = S("Harvest 250 fully grown wheat plants."),
		icon = "awards_field_worker.png^awards_level2.png",
		trigger = {
			type = "dig",
			node = "farming:wheat_8",
			target = 250
		}
	})

	awards.register_award("awards_farmer3", {
		title = S("Aspiring Farmer"),
		description = S("Harvest 500 fully grown wheat plants."),
		icon = "awards_aspiring_farmer.png^awards_level3.png",
		trigger = {
			type = "dig",
			node = "farming:wheat_8",
			target = 500
		}
	})

	awards.register_award("awards_farmer4", {
		title = S("Wheat Magnate"),
		description = S("Harvest 1000 fully grown wheat plants."),
		icon = "awards_wheat_magnate.png^awards_level4.png",
		trigger = {
			type = "dig",
			node = "farming:wheat_8",
			target = 1000
		}
	})

	awards.register_award("award_bread", {
		title = S("Baker"),
		description = S("Eat 10 loaves of bread."),
		icon = "awards_baker.png",
		trigger = {
			type = "eat",
			item = "farming:bread",
			target = 10
		}
	})

end

if minetest.get_modpath("wool") and minetest.get_modpath("farming") then
	awards.register_award("awards_wool", {
		title = S("Wool Over Your Eyes"),
		description = S("Craft 1000 white wool."),
		icon = "awards_wool_over_your_eyes.png",
		trigger = {
			type = "craft",
			item = "wool:white",
			target = 1000
		}
	})
end

if minetest.get_modpath("beds") then
	awards.register_award("award_bed", {
		title = S("Hotelier"),
		description = S("Craft 15 fancy beds."),
		icon = "awards_hotelier.png",
		trigger = {
			type = "craft",
			item= "beds:fancy_bed_bottom",
			target = 15
		}
	})
end

if minetest.get_modpath("stairs") then
	awards.register_award("award_stairs_goldblock", {
		title = S("Filthy Rich"),
		description = S("Craft 24 gold block stairs."),
		icon = "awards_filthy_rich.png",
		trigger = {
			type = "craft",
			item= "stairs:stair_goldblock",
			target = 24
		}
	})
end

if minetest.get_modpath("dye") then
	awards.register_award("awards_dye_red", {
		title = S("Roses Are Red"),
		description = S("Craft 400 red dyes."),
		icon = "awards_roses_are_red.png",
		trigger = {
			type = "craft",
			item = "dye:red",
			target = 400
		}
	})

	awards.register_award("awards_dye_yellow", {
		title = S("Dandelions are Yellow"),
		description = S("Craft 400 yellow dyes."),
		icon = "awards_dandelions_are_yellow.png",
		trigger = {
			type = "craft",
			item = "dye:yellow",
			target = 400
		}
	})

	awards.register_award("awards_dye_blue", {
		title = S("Geraniums are Blue"),
		description = S("Craft 400 blue dyes."),
		icon = "awards_geraniums_are_blue.png",
		trigger = {
			type = "craft",
			item= "dye:blue",
			target = 400
		}
	})

	awards.register_award("awards_dye_white", {
		title = S("White Color Stock"),
		description = S("Craft 100 white dyes."),
		icon = "awards_white_color_stock.png",
		trigger = {
			type = "craft",
			item= "dye:white",
			target = 100
		}
	})
end

if minetest.get_modpath("flowers") then
	awards.register_award("awards_brown_mushroom1", {
		title = S("Tasty Mushrooms"),
		description = S("Eat 3 brown mushrooms."),
		icon = "awards_tasty_mushrooms.png^awards_level1.png",
		trigger = {
			type = "eat",
			item= "flowers:mushroom_brown",
			target = 3,
		}
	})
	awards.register_award("awards_brown_mushroom2", {
		title = S("Mushroom Lover"),
		description = S("Eat 33 brown mushrooms."),
		icon = "awards_mushroom_lover.png^awards_level2.png",
		trigger = {
			type = "eat",
			item= "flowers:mushroom_brown",
			target = 33,
		}
	})
	awards.register_award("awards_brown_mushroom3", {
		title = S("Underground Mushroom Farmer"),
		description = S("Eat 333 brown mushrooms."),
		icon = "awards_underground_mushroom_farmer.png^awards_level3.png",
		trigger = {
			type = "eat",
			item= "flowers:mushroom_brown",
			target = 333,
		}
	})
end

-- This ensures the following code is executed after all items have been registered
minetest.after(0, function()
	-- Check whether there is at least one node which can be built by the player
	local building_is_possible = false
	for _, def in pairs(minetest.registered_nodes) do
		if (def.description and def.pointable ~= false and not def.groups.not_in_creative_inventory) then
			building_is_possible = true
			break
		end
	end

	-- The following awards require at least one node which can be built
	if not building_is_possible then
		return
	end

	awards.register_award("awards_builder1", {
		title = S("Builder"),
		icon = "awards_builder.png^awards_level1.png",
		trigger = {
			type = "place",
			target = 1000,
		},
	})
	awards.register_award("awards_builder2", {
		title = S("Engineer"),
		icon = "awards_engineer.png^awards_level2.png",
		trigger = {
			type = "place",
			target = 10000,
		},
	})
	awards.register_award("awards_builder3", {
		title = S("Architect"),
		icon = "awards_architect.png^awards_level3.png",
		trigger = {
			type = "place",
			target = 20000,
		},
	})
	awards.register_award("awards_builder4", {
		title = S("Master Architect"),
		icon = "awards_master_architect.png^awards_level4.png",
		trigger = {
			type = "place",
			target = 50000,
		},
	})
end)

if minetest.get_modpath("nyancat") then
	-- Found a Nyan cat!
	awards.register_award("award_nyanfind", {
		secret = true,
		title = S("A Cat in a Pop-Tart?!"),
		description = S("Mine a nyan cat."),
		icon = "awards_a_cat_in_a_pop_tart.png",
		trigger = {
			type = "dig",
			node = "nyancat:nyancat",
			target = 1
		}
	})
end

if minetest.get_modpath("pipeworks") then
	awards.register_award("award_pipeworks_transporter", {
		title = S("Item transporter"),
		description = S("Place 1000 tubes."),
		difficulty = 0.05,
		secret = true,
		trigger = {
			type = "place",
			node = "pipeworks:tube_1",
			target = 1000,
		}
	})

	awards.register_award("award_pipeworks_automator", {
		title = S("Factory"),
		description = S("Place 10 autocrafters."),
		difficulty = 3,
		secret = true,
		trigger = {
			type = "place",
			node = "pipeworks:autocrafter",
			target = 10,
		}
	})
end

if minetest.get_modpath("mesecons") then
	awards.register_award("awards_mesecons", {
		title = S("Electical Engineer"),
		description = S("Place 500 mesecon wires."),
		difficulty = 0.2,
		trigger = {
			type = "place",
			node = "pipeworks:tube_1",
			target = 500,
		}
	})
end

if minetest.get_modpath("basic_materials") then
	awards.register_award("awards_oil", {
		title = S("Oil Typhoon"),
		description = S("Craft 500 oil extract."),

		trigger = {
			type = "craft",
			item = "basic_materials:oil_extract",
			target = 500,
		}
	})
end
