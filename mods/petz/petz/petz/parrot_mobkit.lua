local S = ...

local pet_name = "parrot"
local scale_model = 1.0
local mesh = 'petz_parrot.b3d'
local textures= {"petz_parrot.png", "petz_parrot2.png", "petz_parrot3.png", "petz_parrot4.png", "petz_parrot5.png"}
local p1 = {x= -0.125, y = -0.5, z = -0.125}
local p2 = {x= 0.0625, y = 0.125, z = 0.1875}
local collisionbox, collisionbox_baby = petz.get_collisionbox(p1, p2, scale_model, nil)

minetest.register_entity("petz:"..pet_name,{
	--Petz specifics
	type = "parrot",
	init_tamagochi_timer = true,
	is_pet = true,
	can_fly = true,
	max_height = 5,
	has_affinity = true,
	is_wild = false,
	feathered = true,
	give_orders = true,
	can_be_brushed = true,
	capture_item = "net",
	follow = petz.settings.parrot_follow,
	drops = {
		{name = "petz:raw_parrot", chance = 3, min = 1, max = 1,},
	},
	--automatic_face_movement_dir = 0.0,
	rotate = petz.settings.rotate,
	physical = true,
	stepheight = 0.1,	--EVIL!
	collide_with_objects = true,
	collisionbox = collisionbox,
	visual = petz.settings.visual,
	mesh = mesh,
	textures = textures,
	visual_size = {x=petz.settings.visual_size.x*scale_model, y=petz.settings.visual_size.y*scale_model},
	static_save = true,
	get_staticdata = mobkit.statfunc,
	-- api props
	springiness= 0,
	buoyancy = 0.5, -- portion of hitbox submerged
	max_speed = 2.5,
	jump_height = 2.0,
	view_range = 12,
	lung_capacity = 10, -- seconds
	max_hp = 8,

	attack={range=0.5, damage_groups={fleshy=3}},
	animation = {
		walk={range={x=1, y=12}, speed=25, loop=true},
		run={range={x=13, y=25}, speed=25, loop=true},
		stand={
			{range={x=26, y=46}, speed=5, loop=true},
			{range={x=47, y=59}, speed=5, loop=true},
			{range={x=60, y=70}, speed=5, loop=true},
			{range={x=71, y=91}, speed=5, loop=true},
		},
		fly={range={x=92, y=98}, speed=25, loop=true},
		stand_fly={range={x=92, y=98}, speed=25, loop=true},
	},
	sounds = {
		misc = "petz_parrot_chirp",
		moaning = "petz_parrot_moaning",
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

petz:register_egg("petz:parrot", S("Parrot"), "petz_spawnegg_parrot.png", true)
