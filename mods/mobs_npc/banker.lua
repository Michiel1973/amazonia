
local S = mobs.intllib

-- define table containing names for use and shop items for exchange

mobs.banker = {

	names = {
		"Charles", "James", "Frederick", "Harold", "Humphrey", "Magnus", "Wilfred",
		"Benedict", "Hugo"
	},

	items = {
		--{item for exchange, price, chance of appearing in banker's inventory}
		{"default:iron_lump 1", "currency:minegeld_10 3", 90},
		{"default:copper_lump 1", "currency:minegeld_10 4", 75},
		{"default:tin_lump 1", "currency:minegeld_10 4", 65},
		{"default:mese_crystal 1", "currency:minegeld_10 10", 5},
		{"default:gold_lump 1", "currency:minegeld_10 5", 20},
		{"default:diamond 1", "currency:minegeld_10 8", 10},
		{"technic:uranium_lump 1", "currency:minegeld_10 6", 10},
		{"technic:chromium_lump 1", "currency:minegeld_10 7", 15},
		{"technic:zinc_lump 1", "currency:minegeld_10 3", 30},
		{"technic:lead_lump 1", "currency:minegeld_10 3", 30},
		{"technic:sulfur_lump 1", "currency:minegeld_10 2", 40},
		{"moreores:silver_lump 1", "currency:minegeld_10 4", 50},
		{"moreores:mithril_lump 1", "currency:minegeld_10 10", 5},
		{"glooptest:kalite_lump 1", "currency:minegeld_10 4", 90},
		{"glooptest:alatro_lump 1", "currency:minegeld_10 3", 70},
		{"glooptest:talinite_lump 1", "currency:minegeld_10 4", 65},
		{"glooptest:akalin_lump 1", "currency:minegeld_10 3", 80},
		{"glooptest:arol_lump 1", "currency:minegeld_10 3", 80},
	}
}

-- banker ( same as NPC but with right-click shop )

mobs:register_mob("mobs_npc:banker", {
	type = "npc",
	passive = false,
	damage = 20,
	attack_type = "dogfight",
	attacks_monsters = true,
	attack_animals = false,
	attack_npcs = false,
	pathfinding = false,
	hp_min = 150,
	hp_max = 200,
	armor = 1,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "mobs_character.b3d",
	textures = {
		{"mobs_banker.png"},
		{"mobs_banker2.png"},
		{"mobs_banker3.png"},
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = false,
	drops = {},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	view_range = 6,
	owner = "",
	order = "stand",
	fear_height = 3,
	animation = {
		speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
	},
	on_rightclick = function(self, clicker)
		mobs_banker(self, clicker, entity, mobs.banker)
	end,
	on_spawn = function(self)
		self.nametag = S("banker")
		self.object:set_properties({
			nametag = self.nametag,
			nametag_color = "#FFFFFF"
		})
		return true -- return true so on_spawn is run once only
	end,
})

--This code comes almost exclusively from the banker and inventory of mobf, by Sapier.
--The copyright notice below is from mobf:
-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file inventory.lua
--! @brief component containing mob inventory related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-02
--
--! @defgroup Inventory Inventory subcomponent
--! @brief Component handling mob inventory
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-- This code has been heavily modified by isaiah658.
-- exchanges are saved in entity metadata so they always stay the same after
-- initially being chosen.  Also the formspec uses item image buttons instead of
-- inventory slots.

function mobs.add_materials(self, entity, race)

	local exchange_index = 1
	local exchanges_already_added = {}
	local banker_pool_size = 10
	local item_pool_size = #race.items -- get number of items on list

	self.exchanges = {}

	if item_pool_size < banker_pool_size then
		banker_pool_size = item_pool_size
	end

	for i = 1, banker_pool_size do

		-- If there are more exchanges than the amount being added, they are
		-- randomly selected.  If they are equal, there is no reason to randomly
		-- select them
		local random_exchange = nil

		if item_pool_size == banker_pool_size then
			random_exchange = i
		else
			while random_exchange == nil do

				local num = math.random(item_pool_size)

				if exchanges_already_added[num] == nil then
					exchanges_already_added[num] = true
					random_exchange = num
				end
			end
		end

		if math.random(0, 100) > race.items[random_exchange][3] then

			self.exchanges[exchange_index] = {
				race.items[random_exchange][1],
				race.items[random_exchange][2]}

			exchange_index = exchange_index + 1
		end
	end
end


function mobs_banker(self, clicker, entity, race)

	if not self.id then
		self.id = (math.random(1, 1000) * math.random(1, 10000))
			.. self.name .. (math.random(1, 1000) ^ 2)
	end

	if not self.game_name then

		self.game_name = tostring(race.names[math.random(1, #race.names)])
		self.nametag = S("banker @1", self.game_name)

		self.object:set_properties({
			nametag = self.nametag,
			nametag_color = "#00FF00"
		})
	end

	if self.exchanges == nil then
		mobs.add_materials(self, entity, race)
	end

	local player = clicker:get_player_name()

	minetest.chat_send_player(player,
		S("[NPC] <banker @1> Hello @2, please make your choice.",
		self.game_name, player))

	-- Make formspec exchange list
	local formspec_exchange_list = ""
	local x, y

	for i = 1, 10 do

		if self.exchanges[i] and self.exchanges[i] ~= "" then

			if i < 6 then
				x = 0.5
				y = i - 0.5
			else
				x = 4.5
				y = i - 5.5
			end

			formspec_exchange_list = formspec_exchange_list
			.. "item_image_button[".. x ..",".. y ..";1,1;"
				.. self.exchanges[i][2] .. ";prices#".. i .."#".. self.id ..";]"
			.. "item_image_button[".. x + 2 ..",".. y ..";1,1;"
				.. self.exchanges[i][1] .. ";goods#".. i .."#".. self.id ..";]"
			.. "image[".. x + 1 ..",".. y ..";1,1;gui_arrow_blank.png]"
		end
	end

	minetest.show_formspec(player, "mobs_npc:banker", "size[8,10]"
		.. default.gui_bg_img
		.. default.gui_slots
		.. "label[0.5,-0.1;" .. S("banker @1's menu:", self.game_name) .. "]"
		.. formspec_exchange_list
		.. "list[current_player;main;0,6;8,4;]"
	)
end


minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname ~= "mobs_npc:banker" then return end

	if fields then

		local exchange = ""

		for k, v in pairs(fields) do
			exchange = tostring(k)
		end

		local id = exchange:split("#")[3]
		local self = nil

		if id ~= nil then

			for k, v in pairs(minetest.luaentities) do

				if v.object and v.id and v.id == id then
					self = v
					break
				end
			end
		end

		if self ~= nil then

			local exchange_number = tonumber(exchange:split("#")[2])

			if exchange_number ~= nil and self.exchanges[exchange_number] ~= nil then

				local price = self.exchanges[exchange_number][2]
				local goods = self.exchanges[exchange_number][1]
				local inv = player:get_inventory()

				if inv:contains_item("main", price) then

					inv:remove_item("main", price)

					local leftover = inv:add_item("main", goods)

					if leftover:get_count() > 0 then

						-- drop item(s) in front of player
						local droppos = player:get_pos()
						local dir = player:get_look_dir()

						droppos.x = droppos.x + dir.x
						droppos.z = droppos.z + dir.z

						minetest.add_item(droppos, leftover)
					end
				end
			end
		end
	end
end)

mobs:register_egg("mobs_npc:banker", S("banker"), "default_sandstone.png", 1)

-- compatibility
mobs:alias_mob("mobs:banker", "mobs_npc:banker")
