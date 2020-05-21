


local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer >= 1 then
		local t0 = minetest.get_us_time()

		for _,player in ipairs(minetest.get_connected_players()) do
			local _, armor_inv = armor.get_valid_player(armor, player, "[spacesuit]")

			local has_helmet = armor_inv:contains_item("armor", "spacesuit:helmet")
			local has_chestplate = armor_inv:contains_item("armor", "spacesuit:chestplate")
			local has_pants = armor_inv:contains_item("armor", "spacesuit:pants")
			local has_boots = armor_inv:contains_item("armor", "spacesuit:boots")

			local has_full_suit = has_helmet and has_chestplate and has_pants and has_boots

			local armor_list = armor_inv:get_list("armor")

			-- does the player wear a suit?
			spacesuit.set_player_wearing(player, has_full_suit, has_helmet, armor_list)

			if has_full_suit and player:get_breath() < 10 then

				for i, stack in pairs(armor_inv:get_list("armor")) do
					if not stack:is_empty() then
						local name = stack:get_name()
						if name:sub(1, 10) == "spacesuit:" then
							local use = minetest.get_item_group(name, "armor_use") * timer or 0
							armor:damage(player, i, stack, use)
						end
					end
				end

				player:set_breath(10)

			elseif not has_full_suit then
				-- check if player is in vacuum without spacesuit
				local is_admin = minetest.check_player_privs(player:get_player_name(), "privs")
				if not is_admin then
					local ppos = player:get_pos()
					local node = minetest.get_node(ppos)
					if node.name == "vacuum:vacuum" then
						-- player does not wear a suit, let him/her suffer!
						local breath = player:get_breath()
						if breath > 0 then
							player:set_breath(math.max(0, player:get_breath() - 4))
						end
						if  breath < 4 then
							player:set_hp( player:get_hp() - 2, "drown" )
						end
					end
				end
			end

		end
		timer = 0

		local t1 = minetest.get_us_time()
		local diff = t1 - t0
		if diff > 10000 then
			minetest.log("warning", "[spacesuit] update took " .. diff .. " us")
		end
	end
end)
