--
--PIGEON
--

local S = ...

local pet_name = "pigeon"
local scale_model = 1.8
local mesh = 'petz_pigeon.b3d'
local textures= {"petz_pigeon.png", "petz_pigeon2.png", "petz_pigeon3.png"}
local p1 = {x= -0.0625, y = -0.5, z = -0.125}
local p2 = {x= 0.125, y = -0.125, z = 0.125}
local collisionbox, collisionbox_baby = petz.get_collisionbox(p1, p2, scale_model, nil)

minetest.register_entity("petz:"..pet_name,{
	--Petz specifics
	type = "pigeon",
	init_tamagochi_timer = false,
	can_fly = true,
	is_pet = false,
	max_height = 5,
	has_affinity = false,
	feathered = true,
	is_wild = false,
	give_orders = false,
	can_be_brushed = false,
	capture_item = "net",
	follow = petz.settings.pigeon_follow,
	--automatic_face_movement_dir = 0.0,
	rotate = petz.settings.rotate,
	physical = true,
	stepheight = 1.1,	--EVIL!
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
	max_speed = 1.6,
	jump_height = 2.1,
	view_range = 4,
	lung_capacity = 10, -- seconds
	max_hp = 8,
	min_height = 4,
	max_height = 90,
	spawn_min_height = 4,
	spawn_max_height = 90,
	drops = {
	{name = "mobs:meat_raw", chance = 1, min = 1, max = 1,},
		},
	--armor_groups = {fleshy=1},
	attack={range=3, damage_groups={fleshy=2}},
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
		misc = "petz_pigeon_cooing",
		moaning = "petz_pigeon_moaning",
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

petz:register_egg("petz:pigeon", S("Pigeon"), "petz_spawnegg_pigeon.png", true)

