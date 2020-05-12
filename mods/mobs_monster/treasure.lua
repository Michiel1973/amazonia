minetest.register_node("mobs_monster:dungeonmaster_heart", {
		description = "Dungeon Master Heart",
	tiles = {
		{
			name = "lavarock.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
		{
			name = "lavarock.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	groups = {cracky = 3},
	light_source = default.LIGHT_MAX - 6,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("mobs_monster:oerkki_heart", {
		description = "Oerkki Heart",
	tiles = {
		{
			name = "lavarock_blue.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
		{
			name = "lavarock_blue.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	groups = {cracky = 3},
	light_source = default.LIGHT_MAX - 6,
	sounds = default.node_sound_stone_defaults(),
})