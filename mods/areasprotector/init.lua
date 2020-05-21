local creative_mode = minetest.settings:get_bool("creative_mode")

local function cyan(str)
	return minetest.colorize("#00FFFF",str)
end

local function red(str)
	return minetest.colorize("#FF5555",str)
end

local radius_large = minetest.settings:get("areasprotector_radius_large")
					or minetest.settings:get("areasprotector_radius")
					or 16
					
radius_large = tonumber(radius_large) or 16

local height_large = minetest.settings:get("areasprotector_height_large")
					or minetest.settings:get("areasprotector_radius_large")
					or minetest.settings:get("areasprotector_radius")
					or 16
					
height_large = tonumber(height_large) or 16

local radius_small = minetest.settings:get("areasprotector_radius_small")
					or 7
					
radius_small = tonumber(radius_small) or 7

local height_small = minetest.settings:get("areasprotector_height_small")
					or minetest.settings:get("areasprotector_radius_small")
					or 7
					
height_small = tonumber(height_small) or 7
					
local max_protectors = minetest.settings:get("areasprotector_max_protectors") or 16

max_protectors = tonumber(max_protectors) or 16

local function remove_display(pos)
	local objs = minetest.get_objects_inside_radius(pos, 0.5)
	for _,o in pairs(objs) do
		o:remove()
	end
end

local function on_place(itemstack, player, pointed, radius, height, sizeword)
	local pos = pointed.above
	local pos1 = vector.add(pos,vector.new(radius, height, radius))
	local pos2 = vector.add(pos,vector.new(-radius, -height, -radius))
	local name = player:get_player_name()
	local perm,err = areas:canPlayerAddArea(pos1,pos2,name)
	if not perm then
		minetest.chat_send_player(name,red("You are not allowed to protect that area: ")..err)
		return itemstack
	end
	local conflicts = minetest.find_nodes_in_area(pos1,pos2,{"areasprotector:protector_small","areasprotector:protector_large",})
	if conflicts and #conflicts > 0 and not minetest.check_player_privs(name,"areas") then
		minetest.chat_send_player(name,red("Another protector block is too close: ").."another protector block was found at "..cyan(minetest.pos_to_string(conflicts[1]))..", and this size of protector block cannot be placed within "..cyan(tostring(radius).."m").." of others.")
		return itemstack
	end
	local userareas = 0
	for k,v in pairs(areas.areas) do
		if v.owner == name and string.sub(v.name,1,28) == "Protected by Protector Block" then
			userareas = userareas + 1
		end
	end
	if userareas >= max_protectors and not minetest.check_player_privs(name,"areas") then
		minetest.chat_send_player(name,red("You are using too many protector blocks:").." this server allows you to use up to "..cyan(tostring(max_protectors)).." protector blocks, and you already have "..cyan(tostring(userareas))..".")
		if sizeword == "small" then
			minetest.chat_send_player(name,"If you need to protect more, please consider using the larger protector blocks, using the chat commands instead, or at the very least taking the time to rename some of your areas to something more descriptive first.")
		else
			minetest.chat_send_player(name,"If you need to protect more, please consider using the chat commands instead, or at the very least take the time to rename some of your areas to something more descriptive first.")
		end
		return itemstack
	end
	local id = areas:add(name,"Protected by Protector Block at "..minetest.pos_to_string(pos, 0),pos1,pos2)
	areas:save()
	local msg = string.format("The area from %s to %s has been protected as #%s",cyan(minetest.pos_to_string(pos1)),cyan(minetest.pos_to_string(pos2)),cyan(id))
	minetest.chat_send_player(name,msg)
	minetest.set_node(pos,{name="areasprotector:protector_"..sizeword})
	local meta = minetest.get_meta(pos)
	local infotext = string.format("Protecting area %d owned by %s",id,name)
	meta:set_string("infotext",infotext)
	meta:set_int("area_id",id)
	meta:set_string("owner",name)
	if not creative_mode then
		itemstack:take_item()
	end
	return itemstack
end

local function after_dig(pos, oldnode, oldmetadata, digger, sizeword)
	if oldmetadata and oldmetadata.fields then
		local owner = oldmetadata.fields.owner
		local id = tonumber(oldmetadata.fields.area_id)
		local playername = digger:get_player_name()
		if areas.areas[id] and areas:isAreaOwner(id,owner) then
			if digger:get_player_control().sneak then
				local inv = digger:get_inventory()
				if not creative_mode then
					if inv:room_for_item("main", "default:steel_ingot 6") then
						inv:remove_item("main", "areasprotector:protector_"..sizeword.." 1")
						inv:add_item("main", "default:steel_ingot 6")
					else
						minetest.chat_send_player(playername, "No room for the replacement ingots, just digging the protector and deleting the area normally.")
						areas:remove(id)
						areas:save()
					end
				end
			else
				areas:remove(id)
				areas:save()
			end
		end
	end
end

local function on_punch(pos, node, puncher, sizeword)
	local objs = minetest.get_objects_inside_radius(pos,.5) -- a radius of .5 since the entity serialization seems to be not that precise
	local removed = false
	for _, o in pairs(objs) do
		if (not o:is_player()) and o:get_luaentity().name == "areasprotector:display_"..sizeword then
			o:remove()
			removed = true
		end
	end
	if not removed then -- nothing was removed: there wasn't the entity
		minetest.add_entity(pos, "areasprotector:display_"..sizeword)
		minetest.after(4, remove_display, pos)
	end
end

local function on_step(self, dtime, sizeword)
	if minetest.get_node(self.object:get_pos()).name ~= "areasprotector:protector_"..sizeword then
		self.object:remove()
		return
	end
end

local function make_display_nodebox(radius, height)
	local nb_radius = radius + 0.55
	local nb_height = height + 0.55
	local t = {
		-- sides
		{ -nb_radius, -nb_height, -nb_radius, -nb_radius,  nb_height,  nb_radius },
		{ -nb_radius, -nb_height,  nb_radius,  nb_radius,  nb_height,  nb_radius },
		{  nb_radius, -nb_height, -nb_radius,  nb_radius,  nb_height,  nb_radius },
		{ -nb_radius, -nb_height, -nb_radius,  nb_radius,  nb_height, -nb_radius },
		-- top
		{ -nb_radius,  nb_height, -nb_radius,  nb_radius,  nb_height,  nb_radius },
		-- bottom
		{ -nb_radius, -nb_height, -nb_radius,  nb_radius, -nb_height,  nb_radius },
		-- middle (surround protector)
		{-.55,-.55,-.55, .55,.55,.55},
	}
	return t
end

local nbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
}

minetest.register_node("areasprotector:protector_large", {
	description = "Protector Block (large volume)",
	groups = {cracky=1},
	tiles = {
		"default_steel_block.png",
		"default_steel_block.png",
		"default_steel_block.png^areasprotector_large_overlay.png^basic_materials_padlock.png"
	},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = nbox,
	on_place = function(itemstack, player, pointed_thing)
		return on_place(itemstack, player, pointed_thing, radius_large, height_large, "large")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		after_dig(pos, oldnode, oldmetadata, digger, "large")
	end,
	on_punch = function(pos, node, puncher)
		on_punch(pos, node, puncher, "large")
	end
})

minetest.register_node("areasprotector:protector_small", {
	description = "Protector Block (small volume)",
	groups = {cracky=1},
	tiles = {
		"default_steel_block.png",
		"default_steel_block.png",
		"default_steel_block.png^basic_materials_padlock.png"
	},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = nbox,
	on_place = function(itemstack, player, pointed_thing)
		return on_place(itemstack, player, pointed_thing, radius_small, height_small, "small")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		after_dig(pos, oldnode, oldmetadata, digger, "small")
	end,
	on_punch = function(pos, node, puncher)
		on_punch(pos, node, puncher, "small")
	end
})

-- entities code below (and above) mostly copied-pasted from Zeg9's protector mod

-- wielditem seems to be scaled to 1.5 times original node size
local vsize = {x=1.0/1.5, y=1.0/1.5}
local ecbox = {0, 0, 0, 0, 0, 0}

minetest.register_entity("areasprotector:display_large", {
	physical = false,
	collisionbox = ecbox,
	visual = "wielditem",
	visual_size = vsize, 
	textures = {"areasprotector:display_node_large"},
	on_step = function(self, dtime)
		on_step(self, dtime, "large")
	end
})

minetest.register_entity("areasprotector:display_small", {
	physical = false,
	collisionbox = ecbox,
	visual = "wielditem",
	visual_size = vsize,
	textures = {"areasprotector:display_node_small"},
	on_step = function(self, dtime)
		on_step(self, dtime, "small")
	end
})

minetest.register_node("areasprotector:display_node_large", {
	tiles = {"areasprotector_display.png"},
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = make_display_nodebox(radius_large, height_large)
	},
	selection_box = {
		type = "regular",
	},
	paramtype = "light",
	groups = {dig_immediate=3,not_in_creative_inventory=1},
	drop = ""
})

minetest.register_node("areasprotector:display_node_small", {
	tiles = {"areasprotector_display.png"},
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = make_display_nodebox(radius_small, height_small)
	},
	selection_box = {
		type = "regular",
	},
	paramtype = "light",
	groups = {dig_immediate=3,not_in_creative_inventory=1},
	drop = ""
})

minetest.register_craft({
	output = "areasprotector:protector_small 2",
	type = "shapeless",
	recipe = {"default:steelblock","basic_materials:padlock"},
})

minetest.register_craft({
	output = "areasprotector:protector_large",
	type = "shapeless",
	recipe = {
		"areasprotector:protector_small",
		"areasprotector:protector_small",
		"areasprotector:protector_small",
		"areasprotector:protector_small",
		"areasprotector:protector_small",
		"areasprotector:protector_small",
		"areasprotector:protector_small",
		"areasprotector:protector_small"
	}
})

minetest.register_alias("areasprotector:protector",    "areasprotector:protector_large")
minetest.register_alias("areasprotector:display_node", "areasprotector:display_node_large")
