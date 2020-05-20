--
--PANDA
--
local S = ...

local pet_name = "panda"
local scale_model = 1.5
local scale_baby = 0.5
local visual_size = {x=petz.settings.visual_size.x*scale_model, y=petz.settings.visual_size.y*scale_model}
local visual_size_baby = {x=petz.settings.visual_size.x*scale_model*scale_baby, y=petz.settings.visual_size.y*scale_model*scale_baby}
local mesh = 'petz_panda.b3d'
local skin_colors = {"black", "brown", "pink"}
local textures = {}
for n = 1, #skin_colors do
	textures[n] = "petz_"..pet_name.."_"..skin_colors[n]..".png"
end
local p1 = {x= -0.25, y = -0.5, z = -0.4375}
local p2 = {x= 0.25, y = 0.25, z = 0.4375}
local collisionbox, collisionbox_baby = petz.get_collisionbox(p1, p2, scale_model, scale_baby)

minetest.register_entity("petz:"..pet_name,{
	--Petz specifics
	type = "panda",
	init_tamagochi_timer = true,
	is_pet = true,
	has_affinity = true,
	breed = true,
	mutation = 1,
	is_wild = false,
	give_orders = true,
	can_be_brushed = true,
	capture_item = "lasso",
	follow = petz.settings.panda_follow,
	drops = {
		{name = "petz:bone", chance = 6, min = 1, max = 1,},
		{name = "mobs:meat_raw", chance = 1, min = 2, max = 4,},	
	},
	rotate = petz.settings.rotate,
	physical = true,
	stepheight = 1.1,	--EVIL!
	collide_with_objects = true,
	collisionbox = collisionbox,
	collisionbox_baby = collisionbox_baby,
	visual = petz.settings.visual,
	mesh = mesh,
	textures = textures,
	skin_colors = skin_colors,
	visual_size = visual_size,
	visual_size_baby = visual_size_baby,
	static_save = true,
	get_staticdata = mobkit.statfunc,
	-- api props
	springiness= 0,
	buoyancy = 0.5, -- portion of hitbox submerged
	max_speed = 1.1,
	jump_height = 1.5,
	view_range = 4,
	lung_capacity = 10, -- seconds
	max_hp = 12,
	min_height = 1,
	max_height = 43,
	spawn_min_height = 1,
	spawn_max_height = 43,
	--armor_groups = {fleshy=1},
	attack={range=3, damage_groups={fleshy=3}},
	animation = {
		walk={range={x=1, y=12}, speed=25, loop=true},
		run={range={x=13, y=25}, speed=25, loop=true},
		stand={
			{range={x=26, y=46}, speed=5, loop=true},
			{range={x=47, y=59}, speed=5, loop=true},
		},
		sit = {range={x=60, y=65}, speed=5, loop=false},
	},
	sounds = {
		misc = "petz_panda_sound",
		moaning = "petz_panda_moaning",
	},

	logic = petz.herbivore_brain,

	on_activate = function(self, staticdata, dtime_s) --on_activate, required
		mobkit.actfunc(self, staticdata, dtime_s)
		petz.set_initial_properties(self, staticdata, dtime_s)
	end,

	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		petz.on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir)
	end,

	on_rightclick = function(self, clicker)
		petz.on_rightclick(self, clicker)
	end,

	on_step = function(self, dtime)
		mobkit.stepfunc(self, dtime) -- required
		petz.on_step(self, dtime)
	end,

})

petz:register_egg("petz:panda", S("Panda"), "petz_spawnegg_panda.png", true)
