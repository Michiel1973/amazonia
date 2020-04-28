--[[

	Mobs Banshee - Adds banshees.
	Copyright © 2018, 2019 Hamlet <hamlatmesehub@riseup.net> and contributors.

	Licensed under the EUPL, Version 1.2 or – as soon they will be
	approved by the European Commission – subsequent versions of the
	EUPL (the "Licence");
	You may not use this work except in compliance with the Licence.
	You may obtain a copy of the Licence at:

	https://joinup.ec.europa.eu/software/page/eupl
	https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32017D0863

	Unless required by applicable law or agreed to in writing,
	software distributed under the Licence is distributed on an
	"AS IS" basis,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
	implied.
	See the Licence for the specific language governing permissions
	and limitations under the Licence.

--]]


--
-- Glowing node
--

minetest.register_node("mobs_banshee:glowing_node", {
	description = "Banshee's Glowing Node",
	groups = {not_in_creative_inventory = 1},
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	diggable = false,
	climbable = false,
	buildable_to = true,
	floodable = true,
	light_source = 6,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(15)
	end,
	on_timer = function(pos, elapsed)
		local daytime = day_or_night()

		if (daytime == true) then
			minetest.get_node_timer(pos):stop()
			minetest.swap_node(pos, {name = "air"})
		end

		return true
	end
})


--
-- Entity definition
--

mobs:register_mob("mobs_monster:banshee", {
	type = "monster",
	hp_min = 20,
	hp_max = 20,
	armor = 100,
	walk_velocity = 1,
	run_velocity = 3.2,
	walk_chance = 1,
	jump = false,
	view_range = 10,
	damage = 17,
	water_damage = 0,
	lava_damage = 0,
	--light_damage = 9999,
	suffocation = false,
	floats = 0,
	reach = 3,
	attack_type = "shoot",
	arrow = "mobs_monster:banshee_projectile",
	shoot_interval = 0.125,
	shoot_offset = 1.0,
	specific_attack = {"player", "mobs_humans:human"},
	blood_amount = 0,
	-- immune_to = {
		-- {"all"}
	-- },
	makes_footstep_sound = false,
	sounds = {
		distance = 12,
		--random = "mobs_banshee_1",
		war_cry = "mobs_banshee_2",
		attack = "mobs_banshee_2"
	},
	visual = "mesh",
	visual_size = {x = 1, y = 1},
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	textures = {
		{"mobs_banshee_1.png"},
		{"mobs_banshee_2.png"}
	},
	mesh = "banshee.b3d",
	animation = {
		stand_start = 81,
		stand_end = 160,
		stand_speed = 30,
		walk_start = 168,
		walk_end = 187,
		walk_speed = 30,
		run_start = 168,
		run_end = 187,
		run_speed = 30,
	},

	-- after_activate = function(self, staticdata, def, dtime)
		-- self.spawned = true
		-- self.counter = 0
		-- self.object:set_properties({
			-- counter = self.counter,
			-- spawned = self.spawned
		-- })

		-- local position = self.object:get_pos()
		-- minetest.place_node(position, {name = "mobs_banshee:glowing_node"})
	-- end,

	-- do_custom = function(self, dtime)
		-- if (banshee_daytime_check == true) then

			-- if (self.light_damage ~= 0) then
				-- self.light_damage = 0

				-- self.object:set_properties({
					-- light_damage = self.light_damage
				-- })
			-- end

			-- if (self.spawned == true) then
				-- local daytime = day_or_night()

				-- if (daytime == true) then
					-- self.object:remove()

				-- else
					-- self.spawned = false
					-- self.object:set_properties({
						-- spawned = self.spawned
					-- })

				-- end

			-- else
				-- if (self.counter < 15.0) then
					-- self.counter = self.counter + dtime

					-- self.object:set_properties({
						-- counter = self.counter
					-- })

				-- else
					-- local daytime = day_or_night()

					-- if (daytime == true) then
						-- self.object:remove()

					-- else
						-- self.counter = 0

						-- self.object:set_properties({
							-- counter = self.counter
						-- })

					-- end
				-- end
			-- end
		-- else
			-- if (self.light_damage ~= 9999) then
				-- self.light_damage = 9999

				-- self.object:set_properties({
					-- light_damage = self.light_damage
				-- })
			-- end
		-- end
	-- end
})


--
-- Banshee's projectile
--

--
-- Arrow entity
--

mobs:register_arrow("mobs_monster:banshee_projectile", {
	visual = "sprite",
	visual_size = {x = 0.0, y = 0.0},
	textures = {"mobs_banshee_transparent.png"},
	velocity = 30,

	hit_player = function(self, player)
		player:punch(self.object, 1,
			{
				full_punch_interval = 0.1,
				damage_groups = {fleshy = 9999},
			}
		)
	end,

	hit_node = function(self, pos, node)
		self.object:remove()
	end
})


--
-- Entity spawners
--

mobs:spawn({
	name = "mobs_banshee:banshee",
	nodes = {"bones:bones"},
	neighbors = {"air"},
	max_light = 4,
	min_light = 0,
	interval = 60,
	chance = 7,
	active_object_count = 1,
	min_height = -30912,
	max_height = 31000,
	day_toggle = false
})

mobs:register_egg("mobs_banshee:banshee",
	"Banshee",
	"default_stone.png", -- the texture displayed for the egg in inventory
	1, -- egg image in front of your texture (1 = yes, 0 = no)
	false -- if set to true this stops spawn egg appearing in creative
)


--
-- Alias
--

mobs:alias_mob("mobs:banshee", "mobs_banshee:banshee")


