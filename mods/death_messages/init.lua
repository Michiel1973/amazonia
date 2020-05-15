--[[
death_messages - A Minetest mod which sends a chat message when a player dies.
Copyright (C) 2017 bark

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

-----------------------------------------------------------------------------------------------
local title = "Death Messages"
local version = "0.1.4"
local mname = "death_messages"
-----------------------------------------------------------------------------------------------
dofile(minetest.get_modpath("death_messages").."/settings.txt")
-----------------------------------------------------------------------------------------------

-- PM from server with death coordinates
-- minetest.register_on_dieplayer(function(player)
      -- local name=player:get_player_name()
      -- local playerpos = player:getpos()
      -- local x = tostring(math.floor(playerpos["x"]))
      -- local y = tostring(math.floor(playerpos["y"]))
      -- local z = tostring(math.floor(playerpos["z"]))
      -- minetest.chat_send_player(player:get_player_name(), core.colorize("#dbdbdb", "PM from Server: ").. core.colorize("#dbdbdb", "Your bones are located at ") .. core.colorize("#fdff9a", x .. ", " .. y .. ", " .. z) .. core.colorize("#dbdbdb",". Better go get them before someone else does!"))
      -- print("****** " .. player:get_player_name() .. " died at " .. x .. ", " .. y .. ", " .. z .. " ******")
-- end)

-- "PLAYER KILLED PLAYER"-messages
minetest.register_on_punchplayer(function(player, hitter)
   if not (player or hitter) then
      return false
   end
   if not hitter:get_player_name() == "" then
      return false
   end
   minetest.after(0, function()
	local oclock = tostring(os.date("%H:%M:%S"))
      --  When player kills player with registered_tool
      if player:get_hp() == 0 and hitter:get_player_name() ~= "" and hitter:get_wielded_item() and hitter:get_wielded_item():get_name() and minetest.registered_tools[hitter:get_wielded_item():get_name()] then
         minetest.chat_send_all(core.colorize("#ae0c13", oclock .. " server msg: " .. player:get_player_name().." was killed by "..hitter:get_player_name().." with a "..minetest.registered_tools[hitter:get_wielded_item():get_name()].description.."."))
	 print(player:get_player_name().." was killed by "..hitter:get_player_name().." with "..minetest.registered_tools[hitter:get_wielded_item():get_name()].description..".")
         return true
      -- When player kills player with node
      elseif player:get_hp() == 0 and hitter:get_player_name() ~= "" and hitter:get_wielded_item() and hitter:get_wielded_item():get_name() and minetest.registered_nodes[hitter:get_wielded_item():get_name()] then
         minetest.chat_send_all(core.colorize("#ae0c13", oclock .. " server msg: " .. hitter:get_player_name().." killed "..player:get_player_name().. " with a " ..minetest.registered_nodes[hitter:get_wielded_item():get_name()].description.."."))
         print(player:get_player_name().." was killed by "..hitter:get_player_name().." with a node.")   
         return true  
      --  When player kills player with bare fists
      elseif player:get_hp() == 0 and hitter:get_player_name() ~= "" and hitter:get_wielded_item() then
         minetest.chat_send_all(core.colorize("#8ae0c13", oclock .. " server msg: " .. hitter:get_player_name().." killed "..player:get_player_name().." with bare fists!"))
         print(player:get_player_name().." was killed by "..hitter:get_player_name().." with bare fists.")
         return true
           -- When player kills entity or vv
      elseif hitter:get_player_name() == "" and player:get_hp() == 0 then
         minetest.chat_send_all(core.colorize("#ae0c13", oclock .. " server msg: " .. player:get_player_name().." was killed by "..hitter:get_luaentity().name.."."))
         print(player:get_player_name().." was killed by "..hitter:get_luaentity().name..".")
      else
         return false
      end
   end)
end)
--[[ 
-- Teleport dead players  to limbo location, to prevent chat spam when player is takin
g damage after death.
DOESN'T WORK .. PLAYERS ARE TELEPORTED TO LIMBO BEFORE BONES ARE GENERATED. BONES END UP IN LIMBO INSTEAD OF DEATH LOCATION

minetest.register_on_dieplayer(function(player)
	if minetest.registered_nodes contains "bones:bones" then
		local player_name = player:get_player_name()
		local LIMBO = "18, -24, 30"
		minetest.get_player_by_name(player_name):setpos(minetest.string_to_pos(LIMBO))
end)
]]--

-- A table of quips for death messages.  The first item in each sub table is the
-- default message used when RANDOM_MESSAGES is disabled.
local messages = {}

-- Lava death messages
messages.lava = {
	" melted into a ball of fire.",
	" thought lava was cool.",
	" went for a nice lava swim.",
	" couldn't resist that warm glow of lava.",
	" didn't know lava was hot."
}

-- Drowning death messages
messages.water = {
	" just drowned.",
	" ran out of air.",
	" failed at swimming lessons.",
	" tried to impersonate an anchor.",
	" forgot they weren't a fish.",
	" blew one too many bubbles.",
	" sleeps with the fishes."
}

-- Burning death messages
messages.fire = {
	" burned to a crisp.",
	" got a little too warm.",
	" got too close to the camp fire.",
	" just got roasted, hotdog style.",
	" got all burned up.",
	" stood in the fire."
}

-- Other death messages
messages.other = {
	" just died.",
	" did something fatal.",
	" decided to self-terminate.",
	" wasn't meant for this world.",
	" was tired of life.",
	" shed their mortal coil."
}

function get_message(mtype)
	if RANDOM_MESSAGES then
		return messages[mtype][math.random(1, #messages[mtype])]
	else
		return messages[1] -- 1 is the index for the non-random message
	end
end

minetest.register_on_dieplayer(function(player)
	local oclock = tostring(os.date("%H:%M:%S"))
	local player_name = player:get_player_name()
	local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
	if minetest.is_singleplayer() then
		player_name = "You"
	end
	--Death by lava
	if node.groups.lava ~= nil then
		minetest.chat_send_all(core.colorize("#ff0000", oclock .. " server msg: " .. player_name .. get_message("lava")))
	--Death by drowning
	elseif player:get_breath() == 0 then
		minetest.chat_send_all(core.colorize("#ff0000", oclock .. " server msg: " .. player_name .. get_message("water")))
	--Death by fire
	elseif node.name == "fire:basic_flame" then
		minetest.chat_send_all(core.colorize("#ff0000", oclock .. " server msg: " .. player_name .. get_message("fire")))
	--Death by something else
	else
		minetest.chat_send_all(core.colorize("#ff0000", oclock .. " server msg: " .. player_name .. get_message("other")))
end

end)

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
