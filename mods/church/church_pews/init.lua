
screwdriver = screwdriver or {}

local pews = {}

----------------------
-- functions for sitting
----------------------
--[[
--sit functions from xdecor mod written by jp
--Copyright (c) 2015-2016 kilbith <jeanpatrick.guerrero@gmail.com>   |
--Code: GPL version 3
--]]

local function sit(pos, node, clicker)
	local player = clicker:get_player_name()
	if default.player_attached[player] == true then
		pos.y = pos.y + 0.1
		clicker:setpos(pos)
		clicker:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_attached[player] = false
		default.player_set_animation(clicker, "stand", 30)
	elseif default.player_attached[player] ~= true and
		clicker:get_player_velocity().x == 0 and
		clicker:get_player_velocity().y == 0 and
		clicker:get_player_velocity().z == 0 and node.param2 <= 3 then

		clicker:set_eye_offset({x=0, y=-7, z=2}, {x=0, y=0, z=0})
		clicker:set_physics_override(0, 0, 0)
		clicker:setpos(pos)
		default.player_attached[player] = true
		default.player_set_animation(clicker, "sit", 30)

		if node.param2 == 0 then
			clicker:set_look_yaw(3.15)
		elseif node.param2 == 1 then
			clicker:set_look_yaw(7.9)
		elseif node.param2 == 2 then
			clicker:set_look_yaw(6.28)
		elseif node.param2 == 3 then
			clicker:set_look_yaw(4.75)
		end
	end
end

-------------------
-- Register Nodes
-------------------

pews.materials = {
	{"acacia_wood", "Acacia Wood", "default_acacia_wood.png", "default:acacia_wood"},
	{"aspen_wood", "Aspen Wood", "default_aspen_wood.png", "default:aspen_wood"},
	{"junglewood", "Jungle Wood", "default_junglewood.png", "default:junglewood"},
	{"pine_wood", "Pine Wood", "default_pine_wood.png", "default:pine_wood"},
	{"wood", "Appletree Wood", "default_wood.png", "default:wood"},
}

for _, row in ipairs(pews.materials) do
	local name = row[1]
	local desc = row[2]
	local tiles = row[3]
	local craft_material = row[4]

	minetest.register_node("church_pews:church_pew_left_"..name, {
		drawtype = "nodebox",
		description = desc.." Pew",
		tiles = { tiles },
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = "",
		groups = {oddly_breakable_by_hand= 3, snappy = 3, choppy = 3, cracky = 3, not_in_creative_inventory = 1},
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.rotate_simple,
		node_box = {
			type = 'fixed',
			fixed = {
				{-0.375, -0.375, 0.3125, 0.5, -0.25, 0.375},
				{-0.375, -0.25, 0.375, 0.5, 0.3125, 0.4375},
				{-0.5, -0.5, 0.25, -0.3125, 0.375, 0.5},
				{-0.5, -0.3125, -0.25, -0.3125, -0.0625, 0.25},
				{-0.4375, -0.0625, -0.25, -0.375, 0.125, 0.25},
				{-0.4375, 0.125, -0.125, -0.375, 0.1875, 0.25},
				{-0.5, -0.5, -0.4375, -0.3125, 0.0625, -0.25},
				{-0.4375, 0.125, 0.0625, -0.375, 0.25, 0.3125},
				{-0.3125, -0.25, -0.25, 0.5, -0.1875, 0.3125},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.0, 0.375},
			},
		},
  on_rightclick = function(pos, node, clicker)
		local objs = minetest.get_objects_inside_radius(pos, 0.5)
		for _, p in pairs(objs) do
			if p:get_player_name() ~= clicker:get_player_name() then return end
		end
		pos.y = pos.y -0.25
		sit(pos, node, clicker)
	end,
	can_dig = function(pos, player)
		local pname = player:get_player_name()
		local objs = minetest.get_objects_inside_radius(pos, 0.5)

    for _, p in pairs(objs) do
     if p:get_player_name() ~= nil or
      default.player_attached[pname] == true or not
      player or not player:is_player() then
      return false
     end
    end
    return true
   end
  })

	minetest.register_node("church_pews:church_pew_right_"..name, {
		drawtype = "nodebox",
		description = desc.." Pew",
		tiles = { tiles },
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = "",
		groups = {oddly_breakable_by_hand= 3, snappy = 3, choppy = 3, cracky = 3, not_in_creative_inventory = 1},
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.rotate_simple,
		node_box = {
			type = 'fixed',
			fixed = {
				{-0.5, -0.375, 0.3125, 0.3125, -0.25, 0.375},
				{-0.5, -0.25, 0.375, 0.3125, 0.3125, 0.4375},
				{0.3125, -0.5, 0.25, 0.5, 0.375, 0.5},
				{0.3125, -0.3125, -0.25, 0.5, -0.0625, 0.25},
				{0.375, -0.0625, -0.25, 0.4375, 0.125, 0.25},
				{0.375, 0.125, -0.125, 0.4375, 0.1875, 0.25},
				{0.3125, -0.5, -0.4375, 0.5, 0.0625, -0.25},
				{0.375, 0.125, 0.0625, 0.4375, 0.25, 0.3125},
				{-0.5, -0.25, -0.25, 0.3125, -0.1875, 0.3125},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.0, 0.375},
			},
		},
  on_rightclick = function(pos, node, clicker)
		local objs = minetest.get_objects_inside_radius(pos, 0.5)
		for _, p in pairs(objs) do
			if p:get_player_name() ~= clicker:get_player_name() then return end
		end
		pos.y = pos.y -0.25
		sit(pos, node, clicker)
	end,
	can_dig = function(pos, player)
		local pname = player:get_player_name()
		local objs = minetest.get_objects_inside_radius(pos, 0.5)

    for _, p in pairs(objs) do
     if p:get_player_name() ~= nil or
      default.player_attached[pname] == true or not
      player or not player:is_player() then
      return false
     end
    end
    return true
   end
  })

	minetest.register_node("church_pews:church_pew_" ..name, {
		drawtype = "nodebox",
		description = desc.." Pew",
		inventory_image = 'pews_' ..name.. '_inv.png',
		tiles = { tiles },
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {oddly_breakable_by_hand= 3, snappy = 3, choppy = 3, cracky = 3},
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.rotate_simple,
		node_box = {
			type = 'fixed',
			fixed = {
				{-0.5, -0.375, 0.3125, 0.5, -0.25, 0.375},
				{-0.5, -0.25, 0.375, 0.5, 0.3125, 0.4375},
				{-0.5, -0.25, -0.25, 0.5, -0.1875, 0.375},
			},
		},
		selection_box = {
   type = "fixed",
   fixed = {
    {-0.5, -0.5, -0.25, 0.5, 0.0, 0.375},
   },
	},
  after_place_node =function(pos, placer)
		local wheretoplace = minetest.dir_to_facedir(placer:get_look_dir())
		local p1 = {x=pos.x, y=pos.y, z=pos.z} -- player's left
		local p2 = {x=pos.x, y=pos.y, z=pos.z} -- player's right
		if wheretoplace == 0 then --facing direction z
			p1 = {x=pos.x-1, y=pos.y, z=pos.z}  -- -x
			p2 = {x=pos.x+1, y=pos.y, z=pos.z} -- x
		elseif wheretoplace == 1 then -- facing direction x
			p1 = {x=pos.x, y=pos.y, z=pos.z+1}  -- +z
			p2 = {x=pos.x, y=pos.y, z=pos.z-1} -- -z
		elseif wheretoplace == 2 then -- facing direction -z
			p1 = {x=pos.x+1, y=pos.y, z=pos.z}  -- x
			p2 = {x=pos.x-1, y=pos.y, z=pos.z}  -- -x
		else  -- facing direction -x
			p1 = {x=pos.x, y=pos.y, z=pos.z-1}  -- -z
			p2 = {x=pos.x, y=pos.y, z=pos.z+1}  -- +z
		end
		local n1 = minetest.get_node(p1)
		local n2 = minetest.get_node(p2)
			if n1.name == "air" then
				minetest.add_node(p1,{name="church_pews:church_pew_left_"..name, param2=minetest.dir_to_facedir(placer:get_look_dir())})
			end
			if n2.name == "air" then
				minetest.add_node(p2,{name="church_pews:church_pew_right_"..name, param2=minetest.dir_to_facedir(placer:get_look_dir())})
			end
		end,
  on_rightclick = function(pos, node, clicker)
		local objs = minetest.get_objects_inside_radius(pos, 0.5)
		for _, p in pairs(objs) do
			if p:get_player_name() ~= clicker:get_player_name() then return end
		end
		pos.y = pos.y -0.25
		sit(pos, node, clicker)
	end,
	can_dig = function(pos, player)
		local pname = player:get_player_name()
		local objs = minetest.get_objects_inside_radius(pos, 0.5)

    for _, p in pairs(objs) do
     if p:get_player_name() ~= nil or
      default.player_attached[pname] == true or not
      player or not player:is_player() then
      return false
     end
    end
    return true
   end
	})


---------------------------
-- Register Craft Recipes
---------------------------
	if craft_material then
		minetest.register_craft({
			output = 'church_pews:church_pew_' ..name.. ' 3',
			recipe = {{'stairs:stair_' ..name, craft_material, 'stairs:stair_' ..name}}
		})
	end

end
