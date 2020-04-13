local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)
local modpath = minetest.get_modpath(modname)
dofile(modpath.."/traps.lua")

-- Npc by TenPlus1 converted for FLG Goblins :D

local goblin_drops = {
	"default:pick_steel",  "default:sword_steel",
	"default:shovel_steel", "farming:bread", "bucket:bucket_water"
}

local goblin_sounds = {
	random = "goblins_goblin_ambient",
	warcry = "goblins_goblin_attack",
	attack = "goblins_goblin_attack",
	damage = "goblins_goblin_damage",
	death = "goblins_goblin_death",
	replace = "goblins_goblin_pick",
	distance = 6,
}

local goblin_replacenodes = {
	"technic:granite",
	"technic:marble",
	"default:stone",
	"default:gravel",
	"default:desert_stone",
	"group:sand",
	"group:soil",
	"aotearoa:gneiss",
	"aotearoa:schist",
	"aotearoa:greywacke",
	"aotearoa:conglomerate",
	"aotearoa:granite",
	"aotearoa:andesite",
	"aotearoa:mud",
	"aotearoa:grey_sandstone",
	"aotearoa:pale_sandstone",
	"aotearoa:basalt",
	"default:torch",
}
	
	
	
local debugging_goblins = false

-- local routine for do_custom so that api doesn't need changed
local search_replace2 = function(
	self,
	search_rate,
	search_rate_above,
	search_rate_below,
	search_offset,
	search_offset_above,
	search_offset_below,
	replace_rate,
	replace_what,
	replace_with,
	replace_rate_secondary,
	replace_with_secondary)

	if math.random(1, search_rate) == 1 then
		-- look for nodes
		local pos  = self.object:get_pos() --
		local pos1 = self.object:get_pos()
		local pos2 = self.object:get_pos()
		--local pos  = vector.round(self.object:get_pos())  --will have to investigate these further
		--local pos1 = vector.round(self.object:get_pos())
		--local pos2 = vector.round(self.object:get_pos())

		-- if we are looking, will we look below and by how much?
		if math.random(1, search_rate_below) == 1 then
			pos1.y = pos1.y - search_offset_below
		end

		-- if we are looking, will we look above and by how much?
		if math.random(1, search_rate_above) == 1 then
			pos2.y = pos2.y + search_offset_above
		end

		pos1.x = pos1.x - search_offset
		pos1.z = pos1.z - search_offset
		pos2.x = pos2.x + search_offset
		pos2.z = pos2.z + search_offset

		if debugging_goblins then
			minetest.debug(self.name:split(":")[2] .. " at\n "
			.. minetest.pos_to_string(pos) .. " is searching between\n "
			.. minetest.pos_to_string(pos1) .. " and\n "
			.. minetest.pos_to_string(pos2))
		end

		local nodelist = minetest.find_nodes_in_area(pos1, pos2, replace_what)
		if #nodelist > 0 then
			if debugging_goblins == true then
				minetest.debug(#nodelist.." nodes found by " .. self.name:split(":")[2]..":")
				for k,v in pairs(nodelist) do minetest.debug(minetest.get_node(v).name:split(":")[2].. " found.") end
			end
			for key,value in pairs(nodelist) do 
				-- ok we see some nodes around us, are we going to replace them?
				if math.random(1, replace_rate) == 1 then
					if replace_rate_secondary and
					math.random(1, replace_rate_secondary) == 1 then
						minetest.set_node(value, {name = replace_with_secondary})
						if debugging_goblins == true then
							minetest.debug(replace_with_secondary.." secondary node placed by " .. self.name:split(":")[2])
						end
					else
						minetest.set_node(value, {name = replace_with})
						if debugging_goblins == true then
							minetest.debug(replace_with.." placed by " .. self.name:split(":")[2])
						end
					end
					minetest.sound_play(self.sounds.replace, {
						object = self.object,
						max_hear_distance = self.sounds.distance
					})
				end
			end
		end
	end
end

local goblin_base = {
	passive = false,
	attack_type = "dogfight",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	--pathfinding = 2,
	jump = true,
	jump_height = 2,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 2,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin",
	--order = "follow",
	--follow = {"default:diamond", "default:apple", "farming:bread"},
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
	-- on_rightclick = function(self, clicker)
		-- -- feed to heal goblin (breed and tame set to false)
		-- if not mobs:feed_tame(self, clicker, 8, false, false) then
			-- local item = clicker:get_wielded_item()
			-- local name = clicker:get_player_name()
	
			-- -- right clicking with gold lump drops random item from goblin_drops
			-- if item:get_name() == "default:gold_lump" then
				-- if not minetest.setting_getbool("creative_mode") then
					-- item:take_item()
					-- clicker:set_wielded_item(item)
				-- end
				-- local pos = self.object:get_pos()
				-- pos.y = pos.y + 0.5
				-- minetest.add_item(pos, {
					-- name = goblin_drops[math.random(1, #goblin_drops)]
				-- })
				-- return
			-- end
		-- end
	-- end,
}

local function goblin_def(overrides)
	local out = {}
	for k, v in pairs(goblin_base) do
		out[k] = v
	end
	for k, v in pairs(overrides) do
		out[k] = v
	end
	return out
end

mobs:register_mob("goblins:goblin_cobble", goblin_def({
	description = S("Cobble Goblin"),
	type = "animal",
	damage = 2,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 20,
	hp_max = 30,
	armor = 150,
	suffocation = true,
	passive = false,
	--pathfinding = 2,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 2,
	fear_height = 3,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 2,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin cobble",
	textures = {
		{"goblins_goblin_cobble1.png"},
		{"goblins_goblin_cobble2.png"},
	},
	drops = {
		{name = "default:mossycobble",
		chance = 1, min = 1, max = 3},
		{name = "default:apple",
		chance = 3, min = 1, max = 3},
		{name = "default:torch",
		chance = 3, min = 1, max = 3},
	},
	lifetimer = 360,

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		1, --search_rate_above
		1, --search_rate_below
		1, --search_offset
		2, --search_offset_above
		1, --search_offset_below
		12, --replace_rate
		{	"default:stone",
			"default:desert_stone",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"aotearoa:schist",
			"aotearoa:greywacke",
			"aotearoa:conglomerate",
			"technic:granite",
			"technic:marble",
			"aotearoa:granite",
			"aotearoa:andesite",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"default:mossycobble", --replace_with
		15, --replace_rate_secondary
		"goblins:mossycobble_trap" --replace_with_secondary
		)
	end,
}))

mobs:register_egg("goblins:goblin_cobble", S("Goblin Egg (cobble)"), "default_mossycobble.png", 1)

mobs:register_mob("goblins:goblin_digger", {
	description = S("Digger Goblin"),
	type = "animal",
	damage = 2,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 20,
	hp_max = 30,
	armor = 150,
	passive = false,
	--pathfinding = 2,
	suffocation = true,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 2,
	fear_height = 3,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 2,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin digger",
	textures = {
		{"goblins_goblin_digger.png"},
	},
	drops = {
		{name = "default:mossycobble",
		chance = 1, min = 1, max = 3},
		{name = "default:apple",
		chance = 3, min = 1, max = 3},
		{name = "default:torch",
		chance = 3, min = 1, max = 3},
	},
	lifetimer = 360,

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		20, --search_rate_above
		20, --search_rate_below
		1, --search_offset
		1, --search_offset_above
		1.5, --search_offset_below
		10, --replace_rate
		{	"group:soil",
			"group:sand",
			"default:gravel",
			"default:stone",
			"default:desert_stone",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"technic:granite",
			"technic:marble",
			"aotearoa:schist",
			"aotearoa:greywacke",
			"aotearoa:conglomerate",
			"aotearoa:granite",
			"aotearoa:andesite",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"air", --replace_with
		nil, --replace_rate_secondary
		nil --replace_with_secondary
		)
	end,
})
mobs:register_egg("goblins:goblin_digger", S("Goblin Egg (digger)"), "default_mossycobble.png", 1)

mobs:register_mob("goblins:goblin_coal", {
	description = S("Coal Goblin"),
	type = "animal",
	damage = 2,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 20,
	hp_max = 30,
	armor = 150,
	passive = false,
	--pathfinding = 2,
	suffocation = true,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 2,
	water_damage = 2,
	lava_damage = 2,
	fear_height = 3,
	light_damage = 2,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin coal",
	textures = {
		{"goblins_goblin_coal1.png"},
		{"goblins_goblin_coal2.png"},
	},
	drops = {
		{name = "default:coal_lump",
		chance = 3, min = 1, max = 5},
		{name = "default:apple",
		chance = 2, min = 1, max = 2},
		{name = "default:torch",
		chance = 2, min = 1, max = 3},
	},

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		1, --search_rate_above
		20, --search_rate_below
		1, --search_offset
		2, --search_offset_above
		1, --search_offset_below
		12, --replace_rate
		{	"default:stone",
			"default:stone_with_coal",
			"aotearoa:conglomerate",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"aotearoa:schist",
			"technic:granite",
			"technic:marble",
			"aotearoa:greywacke",
			"aotearoa:granite",
			"aotearoa:andesite",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"air", --replace_with
		15, --replace_rate_secondary
		"goblins:stone_with_coal_trap" --replace_with_secondary
		)
	end,

})
mobs:register_egg("goblins:goblin_coal", S("Goblin Egg (coal)"), "default_mossycobble.png", 1)

mobs:register_mob("goblins:goblin_iron", {
	description = S("Iron Goblin"),
	type = "monster",
	damage = 3,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 30,
	hp_max = 50,
	armor = 200,
	passive = false,
	--pathfinding = 2,
	suffocation = true,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	fear_height = 3,
	jump = true,
	jump_height = 2,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 2,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin iron",
	textures = {
		{"goblins_goblin_iron1.png"},
		{"goblins_goblin_iron2.png"},
	},
	drops = {
		{name = "default:iron_lump",
		chance = 3, min = 1, max = 4},
		{name = "default:apple",
		chance = 2, min = 1, max = 3},
		{name = "default:pick_steel",
		chance = 5, min = 1, max = 1},
		{name = "default:torch",
		chance = 2, min = 1, max = 3},
	},

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		1, --search_rate_above
		20, --search_rate_below
		1, --search_offset
		2, --search_offset_above
		1, --search_offset_below
		12, --replace_rate
		{	"default:stone",
			"default:desert_stone",
			"default:stone_with_iron",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"aotearoa:conglomerate",
			"aotearoa:schist",
			"technic:granite",
			"technic:marble",
			"aotearoa:greywacke",
			"aotearoa:granite",
			"aotearoa:andesite",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"air", --replace_with
		15, --replace_rate_secondary
		"goblins:stone_with_iron_trap" --replace_with_secondary
		)
	end,
})
mobs:register_egg("goblins:goblin_iron", S("Goblin Egg (iron)"), "default_mossycobble.png", 1)

mobs:register_mob("goblins:goblin_copper", {
	description = S("Copper Goblin"),
	type = "monster",
	damage = 3,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 30,
	hp_max = 50,
	armor = 200,
	passive = false,
	--pathfinding = 2,
	suffocation = true,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	fear_height = 3,
	jump = true,
	jump_height = 2,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 3,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin copper",
	textures = {
		{"goblins_goblin_copper1.png"},
		{"goblins_goblin_copper2.png"},
	},
	drops = {
		{name = "default:copper_lump",
		chance = 3, min = 1, max = 4},
		{name = "default:apple",
		chance = 2, min = 1, max = 4},
		{name = "default:pick_copper",
		chance = 5, min = 1, max = 1},
		{name = "default:torch",
		chance = 2, min = 1, max = 3},
	},

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		1, --search_rate_above
		20, --search_rate_below
		1, --search_offset
		2, --search_offset_above
		1, --search_offset_below
		12, --replace_rate
		{	"default:stone",
			"default:desert_stone",
			"default:stone_with_copper",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"aotearoa:schist",
			"technic:granite",
			"technic:marble",
			"aotearoa:greywacke",
			"aotearoa:conglomerate",
			"aotearoa:granite",
			"aotearoa:andesite",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"air", --replace_with
		15, --replace_rate_secondary
		"goblins:stone_with_copper_trap" --replace_with_secondary
		)
	end,
})
mobs:register_egg("goblins:goblin_copper", S("Goblin Egg (copper)"), "default_mossycobble.png", 1)

mobs:register_mob("goblins:goblin_gold", {
	description = S("Gold Goblin"),
	type = "monster",
	damage = 4,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 40,
	hp_max = 60,
	armor = 250,
	passive = false,
	--pathfinding = 2,
	suffocation = true,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	fear_height = 3,
	jump = true,
	jump_height = 2,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 3,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin gold",
	textures = {
		{"goblins_goblin_gold1.png"},
		{"goblins_goblin_gold2.png"},
	},
	drops = {
		{name = "default:gold_lump",
		chance = 4, min = 1, max = 4},
		{name = "default:apple",
		chance = 2, min = 1, max = 3},
		{name = "default:gold_ingot",
		chance = 5, min = 1, max = 1},
		{name = "default:torch",
		chance = 2, min = 1, max = 3},
	},

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		1, --search_rate_above
		20, --search_rate_below
		1, --search_offset
		2, --search_offset_above
		1, --search_offset_below
		12, --replace_rate
		{	"default:stone",
			"default:desert_stone",
			"default:stone_with_gold",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"aotearoa:schist",
			"aotearoa:greywacke",
			"technic:granite",
			"technic:marble",
			"aotearoa:granite",
			"aotearoa:andesite",
			"aotearoa:conglomerate",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"air", --replace_with
		15, --replace_rate_secondary
		"goblins:stone_with_gold_trap" --replace_with_secondary
		)
	end,
})
mobs:register_egg("goblins:goblin_gold", S("Goblin Egg (gold)"), "default_mossycobble.png", 1)

mobs:register_mob("goblins:goblin_diamond", {
	description = S("Diamond Goblin"),
	type = "monster",
	damage = 4,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 40,
	hp_max = 60,
	armor = 250,
	passive = false,
	--pathfinding = 2,
	suffocation = true,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	fear_height = 3,
	jump = true,
	jump_height = 2,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 3,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 6,
	owner = "",
	--nametag = "goblin diamond",
	textures = {
		{"goblins_goblin_diamond1.png"},
		{"goblins_goblin_diamond2.png"},
	},
	drops = {
		{name = "default:pick_diamond",
		chance = 10, min = 1, max = 1},
		{name = "default:apple",
		chance = 2, min = 1, max = 3},
		{name = "default:diamond",
		chance = 6, min = 1, max = 1},
		{name = "default:torch",
		chance = 2, min = 1, max = 3},
	},

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		1, --search_rate_above
		20, --search_rate_below
		1, --search_offset
		2, --search_offset_above
		1, --search_offset_below
		12, --replace_rate
		{	"default:stone",
			"default:desert_stone",
			"default:stone_with_diamond",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"aotearoa:schist",
			"aotearoa:greywacke",
			"technic:granite",
			"technic:marble",
			"aotearoa:granite",
			"aotearoa:andesite",
			"aotearoa:conglomerate",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"air", --replace_with
		15, --replace_rate_secondary
		"goblins:stone_with_diamond_trap" --replace_with_secondary
		)
	end,

})
mobs:register_egg("goblins:goblin_diamond", S("Goblin Egg (diamond)"), "default_mossycobble.png", 1)

mobs:register_mob("goblins:goblin_king", {
	description = S("Goblin King"),
	type = "monster",
	damage = 5,
	attacks_monsters = false,
	attacks_animals = false,
	hp_min = 60,
	hp_max = 100,
	armor = 300,
	--pathfinding = 2,
	passive = false,
	suffocation = true,
	attack_type = "dogfight",
	blood_amount = 2,
	blood_texture = "goblins_blood.png",
	collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
	visual = "mesh",
	visual_size = {x = 1.20, y = 1.20},
	mesh = "goblins_goblin.b3d",
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
	drawtype = "front",
	makes_footstep_sound = true,
	sounds = goblin_sounds,
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	jump_height = 2,
	fear_height = 3,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 3,
	light_damage_min = 7,
	light_damage_max = 15,
	view_range = 8,
	owner = "",
	--nametag = "goblin king",
	textures = {
		{"goblins_goblin_king.png"},
	},
	drops = {
		{name = "default:pick_mese",
		chance = 10, min = 1, max = 1},
		{name = "default:apple",
		chance = 2, min = 2, max = 4},
		{name = "default:mese_crystal",
		chance = 5, min = 1, max = 2},
		{name = "default:torch",
		chance = 2, min = 1, max = 3},
	},

	do_custom = function(self)
		search_replace2(
		self,
		10, --search_rate
		1, --search_rate_above
		20, --search_rate_below
		1, --search_offset
		2, --search_offset_above
		1, --search_offset_below
		15, --replace_rate
		{	"default:stone",
			"default:desert_stone",
			"default:stone_with_diamond",
			"group:sand",
			"group:soil",
			"aotearoa:gneiss",
			"aotearoa:schist",
			"aotearoa:greywacke",
			"technic:granite",
			"technic:marble",
			"aotearoa:granite",
			"aotearoa:conglomerate",
			"aotearoa:andesite",
			"aotearoa:mud",
			"aotearoa:grey_sandstone",
			"aotearoa:pale_sandstone",
			"aotearoa:basalt",
			"default:torch"}, --replace_what
		"default:mossycobble", --replace_with
		20, --replace_rate_secondary
		"goblins:mossycobble_trap" --replace_with_secondary
		)
	end,
})
mobs:register_egg("goblins:goblin_king", S("Goblin King Egg"), "default_mossycobble.png", 1)


--[[ function mobs_goblins:spawn_specific(
name,
nodes, 
neighbors, 
min_light, 
max_light, 
interval, 
chance, 
active_object_count, 
min_height, 
max_height)
]]

mobs:spawn_specific("goblins:goblin_cobble", 	{"group:stone"}, 										"air",0, 4, 60, 5000, 3, -2000, -500)
mobs:spawn_specific("goblins:goblin_digger", 	{"group:stone"},  										"air",0, 4, 60, 5000, 3, -2000, -500)
mobs:spawn_specific("goblins:goblin_coal",		{"default:stone_with_coal", 	"default:mossycobble"},	"air",0, 4, 60, 5000, 3, -2000, -500)
mobs:spawn_specific("goblins:goblin_iron", 		{"default:stone_with_iron", 	"default:mossycobble"},	"air",0, 4, 60, 5000, 2, -2000, -750)
mobs:spawn_specific("goblins:goblin_copper", 	{"default:stone_with_copper", 	"default:mossycobble"}, "air",0, 4, 60, 5000, 2, -2000, -750)
mobs:spawn_specific("goblins:goblin_gold", 		{"default:stone_with_gold", 	"default:mossycobble"}, "air",0, 4, 60, 6000, 2, -2000, -750)
mobs:spawn_specific("goblins:goblin_diamond", 	{"default:stone_with_diamond",	"default:mossycobble"},	"air",0, 4, 60, 7000, 1, -2000, -750)
mobs:spawn_specific("goblins:goblin_king", 		{"default:stone_with_mese",		"default:mossycobble"},	"air",0, 4, 60, 7000, 1, -2000, -1000)


minetest.log("action", "[MOD] Goblins loaded")