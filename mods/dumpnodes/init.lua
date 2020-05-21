--[[
	Minetest Mod dumpnodes

	This mod adds a ingame chatcommand to write the nodes with theyr texture to a nodes.txt file.
	This file can be used by MinetestMapperGui to generate a colors.txt file of them.
]]
--[[
	The functions
	__genOrderedIndex(t)
	orderedNext(t, state)
	and orderedPairs(t)
	where taken from
	http://lua-users.org/wiki/SortedIteration
	All rights to the authors.
]]
function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    local key = nil
    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
    else
        -- fetch the next value
        for i = 1,table.getn(t.__orderedIndex) do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

function orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end


local function getTiles(nd)
	return nd.tiles or nd.tile_images
end

local function dumpNodes(playerName, param)

	local file = minetest.get_worldpath()..DIR_DELIM.."nodes.txt"
	--minetest.get_world_dir()
	local out, err = io.open(file, 'w')
	if not out then
		--minetest.chat_send_player(playerName, 'io.open: ' .. err)
		return false, "ERROR [dumpnodes]: Could not open file for writing "..err
	end
	
	
	local currentMod = ""
	local counter = 0
	local header = [[
# This file is generated by dumpnodes.
# You can use this to generate a colors.txt file that can be used by minetestmapper.
# To generate a colors.txt you can use the program you find here: https://bitbucket.org/adrido/makecolors
# Or you use MinetestMapperGui that have the conversation tool builtin.
# https://bitbucket.org/adrido/minetestmappergui
]]
	out:write(header)
	for nodeName, def in orderedPairs(minetest.registered_nodes) do
		local tiles = getTiles(def)
		if(def.drawtype ~="arilike" and tiles) then
			local mod, name = nodeName:match('(.*):(.*)')
			if mod~="" and name~="" then
				
				local tile = (tiles[1] and tiles[1].name) or tiles[1] or tiles.name
				if(type(tile) == "string") then
					
					tile = (tile .. '^'):match('(.-)^')
					if(mod ~= currentMod)then
						out:write('\n# ' .. mod .. '\n')
						currentMod = mod
					end
					out:write(nodeName .. ' ' .. tile .. '\n')
					print(nodeName.." : " ..tile)
					counter = counter +1 --lua sucks!
				else
					minetest.log("warning",nodeName..": ".. dump(def));
				end
			end
		end	
	end
	
	if counter >=1 then
		return true, "[dumpnodes] ".. counter .." nodes exported to file ".. file
	else
		return false, "[dumpnodes] Unknown error. 0 nodes exported to file "..file
	end
end	

minetest.register_chatcommand("dumpnodes", {
	params = "",
	privs = {server=true},
	description = "Writes nods and their texture to a nodes.txt file for use in MinetestMapperGui",
	func = dumpNodes
	})
