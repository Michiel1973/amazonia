-- v1.1

--###################
--################### SQUID
--###################

-- intllib
if mobs.mod and mobs.mod == "redo" then

	mobs:register_mob("mobs_squid:squid", {
		type = "animal",
		specific_attack = {"mobs_jellyfish:jellyfish"},
		hp_min = 10,
		hp_max = 10,
		armor = 100,
		runaway_from = {"player","mobs_sharks:shark_lg","mobs_sharks:shark_md","mobs_sharks:shark_sm"},
		-- FIXME: If the squid is near the floor, it turns black
		collisionbox = {-0.4, 0.1, -0.4, 0.4, 0.9, 0.4},
		visual = "mesh",
		mesh = "mobs_mc_squid.b3d",
		textures = {
			{"mobs_mc_squid.png"}
		},
		sounds = {
			damage = "mobs_mc_squid_hurt",
			distance = 16,
		},
		animation = {
			stand_start = 1,
			stand_end = 60,
			walk_start = 1,
			walk_end = 60,
			run_start = 1,
			run_end = 60,
		},
		-- drops = {
			-- {name = mobs_squid.items.black_dye,
			-- chance = 1,
			-- min = 1,
			-- max = 3,},
		-- },
		visual_size = {x=1.75, y=1.75},
		makes_footstep_sound = false,
		stepheight = 0.1,
		fly = true,
		fly_in = "default:water_source",
		jump = false,
		fall_speed = 0.5,
		view_range = 5,
		water_damage = 0,
		lava_damage = 4,
		light_damage = 0,
		runaway = true,
		fear_height = 4,
		blood_texture = "mobs_mc_squid_blood.png",
	})

-- Spawn near the water surface

	--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_squid:squid",
		{"default:water_source"},
		{"default:water_flowing","default:water_source"},
		5, 20, 60, 5000, 1, -100, -6)
		
end
