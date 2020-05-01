--License for code WTFPL and otherwise stated in readmes

-- intllib
local MP = minetest.get_modpath(minetest.get_current_modname())
-- local S, NS = dofile(MP.."/intllib.lua")

--dofile(minetest.get_modpath("mobs").."/api.lua")


--###################
--################### CREEPER
--###################




mobs:register_mob("mobs_monster:creeper", {
	type = "monster",
	hp_min = 40,
	hp_max = 40,
	armor = 90,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 1.69, 0.3},
	pathfinding = 1,
	visual = "mesh",
	mesh = "mobs_monster_creeper.b3d",
	textures = {
		{"mobs_monster_creeper.png"},
	},
	visual_size = {x=3, y=3},
	sounds = {
		attack = "tnt_ignite",
		--TODO: death = "",
		--TODO: damage = "",
		fuse = "tnt_ignite",
		explode = "tnt_explode",
		distance = 12,
	},
	makes_footstep_sound = true,
	walk_velocity = 1.05,
	run_velocity = 2.1,
	--runaway_from = { "mobs_monster:ocelot", "mobs_monster:cat" },
	attack_type = "explode",
	explosion_radius = 4,
	reach = 4,
	explosion_damage_radius = 7,
	explosion_timer = 2,
	allow_fuse_reset = false,
	stop_to_explode = false,

	-- Force-ignite creeper with flint and steel and explode after 1.5 seconds.
	-- TODO: Make creeper flash after doing this as well.
	-- TODO: Test and debug this code.
	on_rightclick = function(self, clicker)
		if self._forced_explosion_countdown_timer ~= nil then
			return
		end
		local item = clicker:get_wielded_item()
		if item:get_name() == "fire:flint_and_steel" then
			if not minetest.settings:get_bool("creative_mode") then
				-- Wear tool
				local wdef = item:get_definition()
				item:add_wear(1000)
				-- Tool break sound
				if item:get_count() == 0 and wdef.sound and wdef.sound.breaks then
					minetest.sound_play(wdef.sound.breaks, {pos = clicker:getpos(), gain = 0.5})
				end
				clicker:set_wielded_item(item)
			end
			self._forced_explosion_countdown_timer = self.explosion_timer
			minetest.sound_play(self.sounds.attack, {pos = self.object:getpos(), gain = 1, max_hear_distance = 12})
		end
	end,
	do_custom = function(self, dtime)
		if self._forced_explosion_countdown_timer ~= nil then
			self._forced_explosion_countdown_timer = self._forced_explosion_countdown_timer - dtime
			if self._forced_explosion_countdown_timer <= 0 then
				mobs:explosion(self.object:getpos(), self.explosion_radius, 0, 1, self.sounds.explode)
				self.object:remove()
			end
		end
	end,
	-- on_die = function(self, pos)
		-- -- Drop a random music disc
		-- -- TODO: Only do this if killed by skeleton
		-- if math.random(1, 200) == 1 then
			-- local r = math.random(1, #mobs_monster.items.music_discs)
			-- minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, mobs_monster.items.music_discs[r])
		-- end
	-- end,
	maxdrops = 2,
	drops = {
		{name = tnt:gunpowder,
		chance = 1,
		min = 0,
		max = 3,},

		-- Head
		-- TODO: Only drop if killed by charged creeper
		-- {name = mobs_monster.items.head_creeper,
		-- chance = 200, -- 0.5%
		-- min = 1,
		-- max = 1,},
	-- },
	animation = {
		speed_normal = 24,
		speed_run = 48,
		stand_start = 0,
		stand_end = 23,
		walk_start = 24,
		walk_end = 49,
		run_start = 24,
		run_end = 49,
		hurt_start = 110,
		hurt_end = 139,
		death_start = 140,
		death_end = 189,
		look_start = 50,
		look_end = 108,
	},
	floats = 1,
	fear_height = 4,
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	view_range = 10,
	blood_amount = 0,
})




-- compatibility
mobs:alias_mob("mobs:creeper", "mobs_monster:creeper")

-- spawn eggs
mobs:register_egg("mobs_monster:creeper", S("Creeper"), "mobs_monster_spawn_icon_creeper.png", 0)
