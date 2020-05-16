--[[
death_messages - A Minetest mod which sends a chat message when a player dies.
Copyright (C) 2016  EvergreenTree

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
--Carbone death coords
--License of media (textures and sounds) From carbone subgame
--------------------------------------
--mods/default/sounds/player_death.ogg: from OpenArena – GNU GPL v2.
-----------------------------------------------------------------------------------------------
local title = "Death Messages"
local version = "0.1.2"
local mname = "death_messages"
-----------------------------------------------------------------------------------------------
dofile(minetest.get_modpath("death_messages").."/settings.txt")
-----------------------------------------------------------------------------------------------

-- A table of quips for death messages.  The first item in each sub table is the
-- default message used when RANDOM_MESSAGES is disabled.
local messages = {}

-- Toxic death messages
messages.toxic = {
	" melted into a ball of radioactivity.",
	" thought chemical waste was cool.",
	" melted into a jittering pile of flesh.",
	" couldn't resist that warm glow of toxic water.",
	" dug straight down.",
	" went into the toxic curtain.",
	" thought it was a toxic-tub.",
	" is radioactive.",
	" didn't know toxic water was radioactive."
}

-- Lava death messages
messages.lava = {
	" thought lava was cool.",
	" melted into a ball of fire.",
	" couldn't resist that warm glow of lava.",
	" thought it was a hot tub.",
	" didn't know lava was hot.",
	" took a nice lava swim."
}

-- Drowning death messages
messages.water = {
	" drowned.",
	" ran out of air.",
	" failed at swimming lessons.",
	" tried to impersonate an anchor.",
	" forgot he wasn't a fish.",
	" blew one too many bubbles.",
	" sleeps with the fishes."
}

-- Burning death messages
messages.fire = {
	" burned to a crisp.",
	" got a little too warm.",
	" got too close to the camp fire.",
	" just got roasted, hotdog style.",
	" got burned up.",
	" stood in the fire.",
	" was roasted."
}

-- Other death messages
messages.other = {
	" died.",
	" did something fatal.",
	" gave up on life.",
	" is somewhat dead now.",
	" passed out permanently.",
	" kinda screwed up.",
	" decided to self-terminate.",
	" did something dumb."
}

-- PVP Messages
messages.pvp = {
	" sliced up",
	" rekt",
	" hacked up",
	" skewered",
	" blasted",
	" buried",
	" served",
	" poked",
	" busted up",
	" schooled",
	" told",
	" chopped up",
	" destroyed"
}

-- Player Messages
messages.player = {
	" for cheating at Tic-Tac-Toe.",
	" because it felt like the right thing to do.",
	" for spilling milk.",
	" for not being good at PVP.",
	" for reasons uncertain.",
	" while texting."
}

-- MOB After Messages
messages.mobs = {
	" and was eaten with a gurgling sound.",
	" then was cooked for dinner.",
	" badly.",
	" terribly.",
	" horribly.",
	" in a haphazard way.",
	" and grinned wryly."
}

function get_message(mtype)
	if RANDOM_MESSAGES then
		return messages[mtype][math.random(1, #messages[mtype])]
	else
		return messages[1] -- 1 is the index for the non-random message
	end
end



minetest.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
	local pos = player:getpos()
	local death = {x=0, y=23, z=-1.5}
	--minetest.sound_play("player_death", {pos = pos, gain = 1})
	pos.x = math.floor(pos.x + 0.5)
	pos.y = math.floor(pos.y + 0.5)
	pos.z = math.floor(pos.z + 0.5)
	local param2 = minetest.dir_to_facedir(player:get_look_dir())
	local player_name = player:get_player_name()
	if minetest.is_singleplayer() then
		player_name = "You"
	end
	
	local oclock = tostring(os.date("%H:%M:%S"))
	
	-- Death by lava
	if node.name == "default:lava_source" then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("lava"))
		--player:setpos(death)
	elseif node.name == "default:lava_flowing"  then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("lava"))
		--player:setpos(death)
	-- Death by drowning
	elseif player:get_breath() == 0 then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("water"))
		--player:setpos(death)
	-- Death by fire
	elseif node.name == "fire:basic_flame" then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("fire"))
		--player:setpos(death)
	-- Death by Toxic water
	elseif node.name == "es:toxic_water_source" then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("toxic"))
		--player:setpos(death)
	elseif node.name == "es:toxic_water_flowing" then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("toxic"))
		--player:setpos(death)
	elseif node.name == "groups:radioactive" then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("toxic"))
		--player:setpos(death)	
		
	-- Death by something else
	else
		local oclock = tostring(os.date("%H:%M:%S"))
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("other"))  --toospammy
		--minetest.after(0.5, function(holding)
			--player:setpos(death)  --gamebreaker?
		--end)
	end
	
	
	--minetest.chat_send_all(string.char(0x1b).."(c@#000000)".."[DEATH COORDINATES] "..string.char(0x1b).."(c@#ffffff)" .. player_name .. string.char(0x1b).."(c@#000000)".." left a corpse full of diamonds here: " ..
	--minetest.pos_to_string(pos) .. string.char(0x1b).."(c@#aaaaaa)".." Come and get them!")
	--player:setpos(death)
	--minetest.sound_play("pacmine_death", { gain = 0.35})  NOPE!!!
	
end)

--bigfoot code
-- bigfoot547's death messages
-- hacked by maikerumine

-- get tool/item when  hitting   get_name()  returns item name (e.g. "default:stone")
minetest.register_on_punchplayer(function(player, hitter)
	local pos = player:getpos()
	local death = {x=0, y=23, z=-1.5}
   if not (player or hitter) then
      return false
   end
   if not hitter:get_player_name() == "" then
      return false
   end
   minetest.after(0, function(holding)
      if player:get_hp() == 0 and hitter:get_player_name() ~= "" and holding == hitter:get_wielded_item() ~= "" then
	  
			local holding = hitter:get_wielded_item() 
				if holding:to_string() ~= "" then  
				local weap = holding:get_name(holding:get_name())
					if holding then  
					local oclock = tostring(os.date("%H:%M:%S"))
					minetest.chat_send_all(
					string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player:get_player_name()..
					string.char(0x1b).."(c@#ff0000)".." was"..
					string.char(0x1b).."(c@#ff0000)"..get_message("pvp")..
					string.char(0x1b).."(c@#ff0000)".." by "..
					string.char(0x1b).."(c@#ff0000)"..hitter:get_player_name()..
					string.char(0x1b).."(c@#ff0000)".." with "..
					string.char(0x1b).."(c@#ff0000)"..weap..
					string.char(0x1b).."(c@#ff0000)"..get_message("player"))
					
					end 	
				end

		if player=="" or hitter=="" then return end -- no killers/victims
        return true
	

		elseif hitter:get_player_name() == "" and player:get_hp() == 0 then
					if not hitter:get_luaentity() then
						return
					end
					if not hitter:get_luaentity().name then
						return
					end
					local monstername = "a monster"
					if hitter:get_luaentity().name == "" then
					monstername = "a monster"
					else
						local monstername = hitter:get_luaentity().name
						if monstername == "mobs_monster:dungeon_master" then
							monstername = "a Dungeon Master"
						elseif monstername == "mobs_monster:creeper" then
							monstername = "a creeper"
						elseif monstername == "mobs_monster:mothman" then
							monstername = "a mothman"
						elseif monstername == "mobs_monster:oerkki" then
							monstername = "an Oerkki"
						elseif monstername == "mobs_monster:sand_monster" then
							monstername = "a sand monster"
						elseif monstername == "mobs_monster:slime_big" or "mobs_monster:slime_small" or "mobs_monster:slime_tiny" then
							monstername = "a slime monster"
						elseif monstername == "mobs_monster:magma_cube_big" or "mobs_monster:magma_cube_small" or "mobs_monster:magma_cube_tiny" then
							monstername = "a magma monster"
						elseif monstername == "mobs_monster:skeleton" then
							monstername = "an ancient warrior skeleton"		
						elseif monstername == "mobs_monster:stone_monster" then
							monstername = "a stone monster"	
						elseif monstername == "mobs_monster:lava_flan" then
							monstername = "a lava flan"	
						elseif monstername == "petz:lion" then
							monstername = "a lion"
						elseif monstername == "petz:grizzly" then
							monstername = "a bear"
						elseif monstername == "petz:tarantula" then
							monstername = "a spider"
						else
							monstername = "a monster"
						end
					end
					local oclock = tostring(os.date("%H:%M:%S"))
					minetest.chat_send_all(
					string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player:get_player_name()..
					string.char(0x1b).."(c@#ff0000)".." was"..
					string.char(0x1b).."(c@#ff0000)"..get_message("pvp")..
					string.char(0x1b).."(c@#ff0000)".." by "..
					string.char(0x1b).."(c@#ff0000)"..monstername..  --too many mobs add to crash
					string.char(0x1b).."(c@#ff0000)"..get_message("mobs"))  --TODO: make custom mob death messages
					
		if player=="" or hitter=="" or hitter=="*"  then return end -- no mob killers/victims
		else
		
        return false
      end
	   
   end)
   
end)

-- -----------------------------------------------------------------------------------------------
-- print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-- -----------------------------------------------------------------------------------------------
