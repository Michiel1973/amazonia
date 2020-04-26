local S = df_mapitems.S

minetest.register_node("df_mapitems:salt_crystal", {
	description = S("Luminous Salt Crystal"),
	_doc_items_longdesc = df_mapitems.doc.salt_desc,
	_doc_items_usagehelp = df_mapitems.doc.salt_usage,
	tiles = {"dfcaverns_salt_crystal.png"},
	groups = {cracky = 2},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "mesh",
	mesh = "underch_crystal.obj",
	light_source = 6,
	sounds = default.node_sound_glass_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
	is_ground_content = false,
	on_place = df_mapitems.place_against_surface,
})

minetest.register_node("df_mapitems:salty_cobble", {
	description = S("Salty Cobble"),
	_doc_items_longdesc = df_mapitems.doc.salty_cobble_desc,
	_doc_items_usagehelp = df_mapitems.doc.salty_cobble_desc,
	tiles = {"default_cobble.png^dfcaverns_salty.png"},
	groups = {cracky = 3, stone = 1, lava_heatable = 1},
	_magma_conduits_heats_to = "default:cobble",
	is_ground_content = false,
	light_source = 2,
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})