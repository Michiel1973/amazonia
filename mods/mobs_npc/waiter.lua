
local S = mobs.intllib

-- define table containing names for use and shop items for sale

mobs.human = {

	names = {
		"Maurice", "Louis", "Charles", "Chance", "Julien", "Marcel", "Rene",
		"Gabriel", "Jules"
	},

	items = {
		--{item for sale, price, chance of appearing in waiter's inventory}
		{"farming:carrot_juice 1", "currency:minegeld 1", 10},
		{"farming:coffee_cup 1", "currency:minegeld 2", 5},
		{"farming:carrot_gold 1", "currency:minegeld_10 2", 12},
		{"farming:melon_slice 1", "currency:minegeld 2", 17},
		{"farming:pea_soup 1", "currency:minegeld_5 1", 17},
		{"farming:pineapple_ring 1", "currency:minegeld 1", 50},
		{"farming:pineapple_juice 1", "currency:minegeld 2", 40},
		{"farming:baked_potato 1", "currency:minegeld 2", 17},
		{"farming:potato_salad 1", "currency:minegeld_5 1", 17},
		{"farming:pumpkin_slice 1", "currency:minegeld 2", 27},
		{"farming:smoothie_raspberry 1", "currency:minegeld_5 1", 7},
		{"farming:rhubarb_pie 1", "currency:minegeld_10 1", 7},
		{"farming:beetroot_soup 1", "currency:minegeld_5 1", 17},
		{"farming:muffin_blueberry 1", "currency:minegeld 3", 17},
		{"farming:blueberry_pie 1", "currency:minegeld_10 1", 40},
		{"farming:chili_bowl 1", "currency:minegeld_5 1", 40},
		{"farming:chocolate_dark 1", "currency:minegeld_5 1", 90},
		{"wine:glass_wine 1", "currency:minegeld_5 1", 90},
		{"wine:glass_beer 1", "currency:minegeld_5 1", 90},
		{"wine:glass_tequila 1", "currency:minegeld_10 1", 90},
		{"wine:glass_wheat_beer 1", "currency:minegeld_5 1", 90},
		{"wine:glass_cider 1", "currency:minegeld_5 1", 90},
	}
}

-- Waiter ( same as NPC but with right-click shop )

mobs:register_mob("mobs_npc:waiter", {
	type = "npc",
	passive = false,
	damage = 15,
	attack_type = "dogfight",
	attacks_monsters = true,
	attack_animals = false,
	attack_npcs = false,
	pathfinding = false,
	hp_min = 50,
	hp_max = 150,
	armor = 150,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "mobs_character.b3d",
	textures = {
		{"mobs_waiter.png"}, -- by Frerin
		{"mobs_waiter2.png"},
		{"mobs_waiter3.png"},
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
		mobs_waiter(self, clicker, entity, mobs.human)
	end,
	on_spawn = function(self)
		self.nametag = S("Waiter")
		self.object:set_properties({
			nametag = self.nametag,
			nametag_color = "#FFFFFF"
		})
		return true -- return true so on_spawn is run once only
	end,
})

--This code comes almost exclusively from the trader and inventory of mobf, by Sapier.
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
-- Trades are saved in entity metadata so they always stay the same after
-- initially being chosen.  Also the formspec uses item image buttons instead of
-- inventory slots.

function mobs.add_goods(self, entity, race)

	local trade_index = 1
	local trades_already_added = {}
	local trader_pool_size = 10
	local item_pool_size = #race.items -- get number of items on list

	self.trades = {}

	if item_pool_size < trader_pool_size then
		trader_pool_size = item_pool_size
	end

	for i = 1, trader_pool_size do

		-- If there are more trades than the amount being added, they are
		-- randomly selected.  If they are equal, there is no reason to randomly
		-- select them
		local random_trade = nil

		if item_pool_size == trader_pool_size then
			random_trade = i
		else
			while random_trade == nil do

				local num = math.random(item_pool_size)

				if trades_already_added[num] == nil then
					trades_already_added[num] = true
					random_trade = num
				end
			end
		end

		if math.random(0, 100) > race.items[random_trade][3] then

			self.trades[trade_index] = {
				race.items[random_trade][1],
				race.items[random_trade][2]}

			trade_index = trade_index + 1
		end
	end
end


function mobs_waiter(self, clicker, entity, race)

	if not self.id then
		self.id = (math.random(1, 1000) * math.random(1, 10000))
			.. self.name .. (math.random(1, 1000) ^ 2)
	end

	if not self.game_name then

		self.game_name = tostring(race.names[math.random(1, #race.names)])
		self.nametag = S("Waiter @1", self.game_name)

		self.object:set_properties({
			nametag = self.nametag,
			nametag_color = "#00FF00"
		})
	end

	if self.trades == nil then
		mobs.add_goods(self, entity, race)
	end

	local player = clicker:get_player_name()

	minetest.chat_send_player(player,
		S("[NPC] <Waiter @1> Hello, @2, here is the menu.",
		self.game_name, player))

	-- Make formspec trade list
	local formspec_trade_list = ""
	local x, y

	for i = 1, 10 do

		if self.trades[i] and self.trades[i] ~= "" then

			if i < 6 then
				x = 0.5
				y = i - 0.5
			else
				x = 4.5
				y = i - 5.5
			end

			formspec_trade_list = formspec_trade_list
			.. "item_image_button[".. x ..",".. y ..";1,1;"
				.. self.trades[i][2] .. ";prices#".. i .."#".. self.id ..";]"
			.. "item_image_button[".. x + 2 ..",".. y ..";1,1;"
				.. self.trades[i][1] .. ";goods#".. i .."#".. self.id ..";]"
			.. "image[".. x + 1 ..",".. y ..";1,1;gui_arrow_blank.png]"
		end
	end

	minetest.show_formspec(player, "mobs_npc:waiter", "size[8,10]"
		.. default.gui_bg_img
		.. default.gui_slots
		.. "label[0.5,-0.1;" .. S("Waiter @1's menu:", self.game_name) .. "]"
		.. formspec_trade_list
		.. "list[current_player;main;0,6;8,4;]"
	)
end


minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname ~= "mobs_npc:waiter" then return end

	if fields then

		local trade = ""

		for k, v in pairs(fields) do
			trade = tostring(k)
		end

		local id = trade:split("#")[3]
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

			local trade_number = tonumber(trade:split("#")[2])

			if trade_number ~= nil and self.trades[trade_number] ~= nil then

				local price = self.trades[trade_number][2]
				local goods = self.trades[trade_number][1]
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

mobs:register_egg("mobs_npc:waiter", S("waiter"), "default_sandstone.png", 1)

-- compatibility
mobs:alias_mob("mobs:waiter", "mobs_npc:waiter")
