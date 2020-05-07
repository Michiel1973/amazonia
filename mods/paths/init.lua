local playersFilth = {}
local playersSand = {}
local playersDesertSand = {}
local playersGravel = {}
local playersGrass = {}

local player_pos = {}
local player_pos_previous = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	playersFilth[player_name] = 0
	playersSand[player_name] = 0
	playersDesertSand[player_name] = 0
	playersGravel[player_name] = 0
	playersGrass[player_name] = 0
	player_pos_previous[player_name] = { x=0, y=0, z=0 }
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	playersFilth[player_name] = nil
	playersSand[player_name] = nil
	playersDesertSand[player_name] = nil
	playersGravel[player_name] = nil
	playersGrass[player_name] = nil
	player_pos_previous[player_name] = nil
end)

-- chance to change is odd of 100
local odd = 13
local max_distance = 8

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		local player_name = player:get_player_name()
		player_pos[player_name] = { x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5), z=math.floor(pos.z+0.5) }
		local p_ground = { x=math.floor(pos.x+0.5), y=math.floor(pos.y), z=math.floor(pos.z+0.5) }
		local n_ground  = minetest.env:get_node(p_ground)
		if player_pos[player_name].y < -5 then return end 
		-- checking if position is the previous position
		if player_pos_previous[player_name] == nil then
			return
		end
		if	player_pos[player_name].x == player_pos_previous[player_name].x and 
			player_pos[player_name].y == player_pos_previous[player_name].y and 
			player_pos[player_name].z == player_pos_previous[player_name].z 
		then
			return
		end
		
			-- gettin your feet dirty
			
			if 	n_ground.name == "default:dirt" or 
				n_ground.name == "farming:soil" or 
				n_ground.name == "farming:soil_wet" then
				-- increase the players filth on a logarithmic scale. starting with 1
				if playersFilth[player_name] < 1 then
					playersFilth[player_name] = 1
				-- (X+5)/2 aproximates 5
				elseif playersFilth[player_name] >= 1 then
					playersFilth[player_name] = math.floor((playersFilth[player_name] + max_distance) /2 )
				end
			end
			
			if n_ground.name == "default:sand" then
				if playersSand[player_name] < 1 then
					playersSand[player_name] = 1
				elseif playersSand[player_name] >= 1 then
					playersSand[player_name] = math.floor((playersSand[player_name] + max_distance) /2 )
				end
			end
			
			if n_ground.name == "default:desert_sand" then
				if playersDesertSand[player_name] < 1 then
					playersDesertSand[player_name] = 1
				elseif playersDesertSand[player_name] >= 1 then
					playersDesertSand[player_name] = math.floor((playersDesertSand[player_name] + max_distance) /2 )
				end
			end			
			
			if n_ground.name == "default:gravel" then
				if playersGravel[player_name] < 1 then
					playersGravel[player_name] = 1
				elseif playersGravel[player_name] >= 1 then
					playersGravel[player_name] = math.floor((playersGravel[player_name] + max_distance) /2 )
				end
			end
			
			if	n_ground.name == "default:dirt_with_grass" or
				n_ground.name == "default:mossycobble"
			then
				if playersGrass[player_name] < 1 then
					playersGrass[player_name] = 1
				elseif playersGrass[player_name] >= 1 then
					playersGrass[player_name] = math.floor((playersGrass[player_name] + max_distance) /2 )
				end
			end
			
			-- turning grass into dirt
			if n_ground.name == "default:dirt_with_grass" then
				if math.random(1, 100) <= odd then
					minetest.env:add_node(p_ground,{type="node",name="default:dirt"})
				end
			end
			
			if n_ground.name == "default:mossycobble" then
				if math.random(1, 100) <= odd then
					minetest.env:add_node(p_ground,{type="node",name="default:cobble"})
				end
			end
			
			if ( minetest.get_modpath("farming") ) ~= nil then
			if n_ground.name == "farming:soil" then
				if math.random(1, 100) <= odd then
					minetest.env:add_node(p_ground,{type="node",name="default:dirt"})
				end
			end
			
			if n_ground.name == "farming:soil_wet" then
				if math.random(1, 100) <= odd then
					minetest.env:add_node(p_ground,{type="node",name="default:dirt"})
				end
			end
			end
			
			-- reducing filth when not walking on dirt/sand/gravel/etc.
			
			if n_ground.name ~= "default:dirt" then
				if playersFilth[player_name] > 0 then
					playersFilth[player_name] = playersFilth[player_name] - 1
				end
			end

			if n_ground.name ~= "default:sand" then
				if playersSand[player_name] > 0 then
					playersSand[player_name] = playersSand[player_name] - 1
				end
			end
			
			if n_ground.name ~= "default:desert_sand" then
				if playersDesertSand[player_name] > 0 then
					playersDesertSand[player_name] = playersDesertSand[player_name] - 1
				end
			end
			
			if n_ground.name ~= "default:gravel" then
				if playersGravel[player_name] > 0 then
					playersGravel[player_name] = playersGravel[player_name] - 1
				end
			end
			
			if n_ground.name ~= "default:dirt_with_grass" then
				if playersGrass[player_name] > 0 then
					playersGrass[player_name] = playersGrass[player_name] - 1
				end
			end
		
			-- turning things into sand
			if	n_ground.name == "default:dirt" or
				n_ground.name == "default:gravel" or
				n_ground.name == "default:desert_sand"
			then
				if playersSand[player_name] > 0 then
					local r_number = math.random(1, (100*max_distance))
					local odd_temp = odd * playersSand[player_name]
					if r_number <= odd_temp then
							minetest.env:add_node(p_ground,{type="node",name="default:sand"})
					end
				end
			end
			
			-- turning things into desertsand
			if	n_ground.name == "default:dirt" or
				n_ground.name == "default:gravel" or
				n_ground.name == "default:sand"
			then
				if playersDesertSand[player_name] > 0 then
					local r_number = math.random(1, (100*max_distance))
					local odd_temp = odd * playersDesertSand[player_name]
					if r_number <= odd_temp then
							minetest.env:add_node(p_ground,{type="node",name="default:desert_sand"})
					end
				end
			end
		
			-- turning things into gravel
			if	n_ground.name == "default:dirt" or
				n_ground.name == "default:sand" or
				n_ground.name == "default:desert_sand"
			then
				if playersGravel[player_name] > 0 then
					local r_number = math.random(1, (100*max_distance))
					local odd_temp = odd * playersGravel[player_name]
					if r_number <= odd_temp then
							minetest.env:add_node(p_ground,{type="node",name="default:gravel"})
					end
				end
			end
			
			-- turning things into dirt
			if 		n_ground.name == "default:gravel" 
					or n_ground.name == "default:sand" 
					or n_ground.name == "default:desert_sand" 
					or n_ground.name == "default:dirt_with_grass" 
				then
					if playersFilth[player_name] > 0 then
						local r_number = math.random(1, (100*max_distance))
						local odd_temp = odd * playersFilth[player_name]
						if r_number <= odd_temp then
								minetest.env:add_node(p_ground,{type="node",name="default:dirt"})
						end
					end
			end
			
			-- turning dirt into grass
			if n_ground.name == "default:dirt" then
					if playersGrass[player_name] > 0 then
						local r_number = math.random(1, (100*max_distance))
						local odd_temp = odd * playersGrass[player_name]
						if r_number <= odd_temp then
								minetest.env:add_node(p_ground,{type="node",name="default:dirt_with_grass"})
						end
					end
			end
			
			-- turning cobble into mossy cobble
			if n_ground.name == "default:cobble" then
					if playersGrass[player_name] > 0 then
						local r_number = math.random(1, (100*max_distance))
						local odd_temp = odd * playersGrass[player_name]
						if r_number <= odd_temp then
								minetest.env:add_node(p_ground,{type="node",name="default:mossycobble"})
						end
					end
			end
			
			if n_ground.name == "cratermg:dust" then
					minetest.env:add_node(p_ground,{type="node",name="cratermg:dusttrack"})
			end
		
		-- making position to previous position
		player_pos_previous[player_name] =  player_pos[player_name]
	end
end)
