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

-- Radioactive death messages
messages.radioactive = {
	" melted into a ball of radioactivity.",
	" thought chemical waste was cool.",
	" learned not to eat the uranium.",
	" thought standing next to uranium would turn them into the hulk.",
	" is glowing a healthy radioactive green.",
	" didn't know uranium was radioactive.",
	" has hopefully learned what uranium nodes look like.",
	" wanted to glow in the dark.",
}

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
	" didn't know toxic water was radioactive.",
}

-- Lava death messages
messages.lava = {
	" thought lava was cool.",
	" melted into a ball of fire.",
	" couldn't resist that warm glow of lava.",
	" thought it was a hot tub.",
	" didn't know lava was hot.",
	" loved lava a little too much.",
	" took a nice lava swim.",
	" may need some ice for that burn.",
	" found out they were highly flammable.",
	" spontaneously combusted.",
	" burned to a crisp in lava.",
	" didn't bring a potion of fire resistance...",
	", lava was not meant to be swam in.",
	" dove into a pool of lava and hit their head.",
	" is toasty.",
	" is extra-crispy.",

}

-- Drowning death messages
messages.water = {
	" drowned.",
	" ran out of air.",
	" failed at swimming lessons.",
	" tried to impersonate an anchor.",
	" forgot they weren't a fish.",
	" blew one too many bubbles.",
	" became a permanent underwater exhibit.",
	" sleeps with the fishes.",
	" was never a sea creature.",
	" didn't bring a potion of underwater breathing...",
	" regrets skipping the swimming lessons.",
	" forgot to wear a life jacket.",
	" is now soggy.",
}

-- Burning death messages
messages.fire = {
	" burned to a crisp.",
	" got a little too warm.",
	" got too close to the camp fire.",
	" just got roasted, hotdog style.",
	" got burned up.",
	" stood in the fire.",
	" was roasted.",
	" cooked themselves.",
	" spontaneously combusted.",
	" may need some ice for that burn.",
	" walked on hot coals.",
	" was fired.",
	"'s goose was cooked.",
	" found out they were highly flammable.",
	" regrets skipping the swimming lessons.",
	" forgot to wear a life jacket.",
	" went to Davy Jones's locker.",
	"'s fire eating performance took a turn for the worse.",
	" is toasty.",
	" is extra-crispy.",
	" is served hot.",

}

-- Other death messages
messages.other = {
	" died.",
	" did something fatal.",
	" gave up on life.",
	" is somewhat dead now.",
	" passed out permanently.",
	" kinda screwed up.",
	" bit the dust.",
	" shed their mortal coil.",
	" decided it was preferable to respawn.",
	" decided to self-terminate.",
	" did something dumb.",
	" did not survive.",
	" will be remembered...",
	" cashed in their chips.",
	" was too good for this world.",
	" came to a sticky end.",
	" is now dead as a dodo.",
	" kicked the bucket.",
	" is now a candidate for the Darwin Awards.",
	" is pining for the fjords.",
	" exited the stage",
	" became an unperson.",
	" stopped breathing.",
	" ended their life.",
	" found an early death.",
	" stopped living.",
	" passed on.",
	" gave up the ghost,",
	" is now in a better place.",
	" bought the farm.",
	" went six feet under.",
	" is pushing up daisies.",
	" kicked the oxygen habit.",
	" got smoked.",
	" checked out.",
	" is done for.",
	" went extinct.",
	" has gone to a better place.",
	" met their maker.",
	" was snuffed out.",
	" is riding the pale horse.",
	" is taking a dirt nap",
	" became worm food.",
	
}

-- PVP Messages
messages.pvp = {
	" sliced up",
	" rekt",
	" hacked up",
	" skewered",
	" buried",
	" exterminated",
	" served",
	" killed",
	" poked",
	" maimed",
	" busted up",
	" schooled",
	" chopped up",
	" destroyed",
	" mangled",
	" ended",
}

-- Player Messages
messages.player = {
	" for cheating at Tic-Tac-Toe.",
	" because it felt like the right thing to do.",
	" for spilling milk.",
	" for not being good at PVP.",
	" for reasons uncertain.",
	" while texting.",
	" like a snack.",
	" because why not."
}

-- MOB After Messages
messages.mobs = {
	" and was eaten with a gurgling sound.",
	" and then was cooked for dinner.",
	" badly.",
	" terribly.",
	" horribly.",
	" painfully.",
	" quickly.",
	" in a haphazard way.",
	" with extreme prejudice.",
	" efficiently."
}

function get_message(mtype)
	return messages[mtype][math.random(1, #messages[mtype])]
end



minetest.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
	local pos = player:getpos()
	local death = {x=0, y=23, z=-1.5}
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
	elseif node.name == "default:lava_flowing"  then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("lava"))
	-- Death by drowning
	elseif player:get_breath() == 0 then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("water"))
	-- Death by fire
	elseif node.name == "fire:basic_flame" or node.name == "fire:permanent_flame" then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("fire"))
	elseif minetest.get_item_group(node.name, "groups:radioactive") > 0 then
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("radioactive"))
	-- Death by something else
	else
		local oclock = tostring(os.date("%H:%M:%S"))
		minetest.chat_send_all(
		string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player_name .. 
		string.char(0x1b).."(c@#ff0000)"..get_message("other"))  --toospammy
	end
	local LIMBO = "18, -24, 30"
	minetest.get_player_by_name(player_name):setpos(minetest.string_to_pos(LIMBO))
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
						local oclock = tostring(os.date("%H:%M:%S"))
						minetest.chat_send_all(
						string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player:get_player_name()..
						string.char(0x1b).."(c@#ff0000)".." was"..
						string.char(0x1b).."(c@#ff0000)"..get_message("pvp")..
						string.char(0x1b).."(c@#ff0000)".." by a monster"..
						string.char(0x1b).."(c@#ff0000)"..get_message("mobs"))
						return
					end
					if not hitter:get_luaentity().name then
						local oclock = tostring(os.date("%H:%M:%S"))
						minetest.chat_send_all(
						string.char(0x1b).."(c@#ff0000)"..oclock.." [server]: "..player:get_player_name()..
						string.char(0x1b).."(c@#ff0000)".." was"..
						string.char(0x1b).."(c@#ff0000)"..get_message("pvp")..
						string.char(0x1b).."(c@#ff0000)".." by a monster"..
						string.char(0x1b).."(c@#ff0000)"..get_message("mobs"))
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
					string.char(0x1b).."(c@#ff0000)"..get_message("mobs"))
					
		if player=="" or hitter=="" or hitter=="*"  then return end -- no mob killers/victims
		else
		
        return false
      end
	   
   end)
   
end)
