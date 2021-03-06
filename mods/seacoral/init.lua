-- NODES


minetest.register_node("seacoral:coralcyan", {
	description = "Cyan Coral",
	waving = 1,
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "seacoral_coralcyan.png", tileable_vertical = false}},
	inventory_image = "seacoral_coralcyan.png",
	wield_image = "seacoral_coralcyan.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,basecolor_cyan=1},
	sounds = default.node_sound_dirt_defaults(),
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node("seacoral:coralmagenta", {
	description = "Magenta Coral",
	waving = 1,
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "seacoral_coralmagenta.png", tileable_vertical = false}},
	inventory_image = "seacoral_coralmagenta.png",
	wield_image = "seacoral_coralmagenta.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,basecolor_magenta=1},
	sounds = default.node_sound_dirt_defaults(),
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node("seacoral:coralaqua", {
	description = "Aqua Coral",
	waving = 1,
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "seacoral_coralaqua.png", tileable_vertical = false}},
	inventory_image = "seacoral_coralaqua.png",
	wield_image = "seacoral_coralaqua.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,excolor_aqua=1},
	sounds = default.node_sound_dirt_defaults(),
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node("seacoral:corallime", {
	description = "Lime Coral",
	waving = 1,
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "seacoral_corallime.png", tileable_vertical = false}},
	inventory_image = "seacoral_corallime.png",
	wield_image = "seacoral_corallime.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,excolor_lime=1},
	sounds = default.node_sound_dirt_defaults(),
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node("seacoral:coralskyblue", {
	description = "Skyblue Coral",
	waving = 1,
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "seacoral_coralskyblue.png", tileable_vertical = false}},
	inventory_image = "seacoral_coralskyblue.png",
	wield_image = "seacoral_coralskyblue.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,excolor_skyblue=1},
	sounds = default.node_sound_dirt_defaults(),
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node("seacoral:coralredviolet", {
	description = "Redviolet Coral",
	waving = 1,
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "seacoral_coralredviolet.png", tileable_vertical = false}},
	inventory_image = "seacoral_coralredviolet.png",
	wield_image = "seacoral_coralredviolet.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,excolor_redviolet=1},
	sounds = default.node_sound_dirt_defaults(),
	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node("seacoral:seacoralsandcyan", {
	description = "Sea coral sand cyan",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtcyan", {
	description = "Sea coral dirt cyan",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandmagenta", {
	description = "Sea coral sand magenta",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtmagenta", {
	description = "Sea coral dirt magenta",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandaqua", {
	description = "Sea coral sand aqua",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtaqua", {
	description = "Sea coral dirt aqua",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandlime", {
	description = "Sea coral sand lime",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtlime", {
	description = "Sea coral dirt lime",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandskyblue", {
	description = "Sea coral sand skyblue",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtskyblue", {
	description = "Sea coral dirt skyblue",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandredviolet", {
	description = "Sea coral sand redviolet",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtredviolet", {
	description = "Sea coral dirt redviolet",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})


-- CRAFTING


minetest.register_craft({
type = "shapeless",
output = "dye:cyan 1",
recipe = {"seacoral:coralcyan"},
})

minetest.register_craft({
type = "shapeless",
output = "dye:magenta 1",
recipe = {"seacoral:coralmagenta"},
})

minetest.register_craft({
type = "shapeless",
output = "dye:lime 1",
recipe = {"seacoral:corallime"},
})

minetest.register_craft({
type = "shapeless",
output = "dye:azure 1",
recipe = {"seacoral:coralaqua"},
})

minetest.register_craft({
type = "shapeless",
output = "dye:cerulean 1",
recipe = {"seacoral:coralskyblue"},
})

minetest.register_craft({
type = "shapeless",
output = "dye:indigo 1",
recipe = {"seacoral:coralredviolet"},
})

-- SEACORAL SAND AND DIRT GENERATION


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandcyan",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -3,
	y_min     = -300,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtcyan",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -2,
	y_min     = -150,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandmagenta",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -4,
	y_min     = -200,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtmagenta",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -5,
	y_min     = -28,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandaqua",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -3,
	y_min     = -88,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtaqua",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -6,
	y_min     = -34,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandlime",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -3,
	y_min     = -180,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtlime",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -2,
	y_min     = -58,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandskyblue",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -4,
	y_min     = -28,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtskyblue",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -3,
	y_min     = -108,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandredviolet",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -2,
	y_min     = -98,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtredviolet",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	y_max     = -3,
	y_min     = -248,
})

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, y_min, y_max)
	if maxp.y < y_min or minp.y > y_max then
		return
	end
	local y_min = math.max(minp.y, y_min)
	local y_max = math.min(maxp.y, y_max)
	if chunk_size >= y_max - y_min + 1 then
		return
	end
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= y_min and y0 <= y_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.get_node(p2).name == wherein then
						minetest.set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
end


-- ABM'S


-- minetest.register_abm({
-- nodenames = {"seacoral:seacoraldirtcyan"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
			-- --pos.y = pos.y - 1
			-- minetest.add_node(pos, {name = "seacoral:coralcyan"}) 
			-- else
			-- return
			-- end
	-- end
-- })


-- minetest.register_abm({
	-- nodenames = {"clams:dirtalgae"},
	-- interval = 40,
	-- chance = 80,
	-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local y = {x = pos.x, y = pos.y + 1, z = pos.z }
	-- local yy = {x = pos.x, y = pos.y + 2, z = pos.z }
		-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(y).name == "default:water_source") then 
			-- if (minetest.get_node(yy).name == "default:water_source") then
				-- pos.y=pos.y + 1
				-- minetest.add_entity(pos, "clams:whiteshell")
			-- end
		-- end
	-- end,
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoralsandcyan"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralcyan"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoraldirtmagenta"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- ----pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralmagenta"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoralsandmagenta"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralmagenta"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoraldirtaqua"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralaqua"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoralsandaqua"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralaqua"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoraldirtlime"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:corallime"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoralsandlime"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:corallime"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoraldirtskyblue"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralskyblue"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoralsandskyblue"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralskyblue"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoraldirtredviolet"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralredviolet"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"seacoral:seacoralsandredviolet"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") then
		-- --pos.y = pos.y - 1
		-- minetest.add_node(pos, {name = "seacoral:coralredviolet"}) else
		-- return
		-- end
	-- end
-- })

-- minetest.register_abm({
-- nodenames = {"group:seacoral"},
-- interval = 6000,
-- chance = 600,
-- action = function(pos, node, active_object_count, active_object_count_wider)
	-- local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	-- local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
	-- if (active_object_count_wider + active_object_count_wider) > 10 then
		-- return
			-- elseif (minetest.get_node(yp).name == "default:water_source") and
	-- (minetest.get_node(yyp).name == "default:water_source") then
		-- local objs = minetest.get_objects_inside_radius(pos, 2)
		-- for k, obj in pairs(objs) do
			-- obj:set_hp(obj:get_hp()+ 1)
		-- end
	-- else
	-- return
	-- end
-- end
-- })


-- OPTIONAL DEPENDENCY



-- ALIASES


minetest.register_alias("seadye:cyan","dye:cyan")
minetest.register_alias("seadye:magenta","dye:magenta")
minetest.register_alias("seadye:lime","dye:lime")
minetest.register_alias("seadye:aqua","dye:aqua")
minetest.register_alias("seadye:skyblue","dye:skyblue")
minetest.register_alias("seadye:redviolet","dye:redviolet")
print ("[MOD]: seacoral loaded")
