minetest.register_node("plasticbox:plasticbox", {
	description = "Plastic Box",
	tiles = {"plasticbox_white.png"},
	is_ground_content = false,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	on_construct = unifieddyes.on_construct,
	on_dig = unifieddyes.on_dig,
})

if minetest.global_exists("stairsplus") then
	stairsplus:register_all("plasticbox", "plasticbox", "plasticbox:plasticbox", {
		description = "Plastic",
		tiles = {"plasticbox_white.png"},
		groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1},
		sounds = default.node_sound_stone_defaults(),
	})
end

minetest.register_craft( {
        output = "plasticbox:plasticbox 4",
        recipe = {
                { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
                { "basic_materials:plastic_sheet", "", "basic_materials:plastic_sheet" },
                { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
        },
})

unifieddyes.register_color_craft({
	output = "plasticbox:plasticbox 4",
	palette = "extended",
	neutral_node = "basic_materials:plastic_sheet",
	recipe = {
		{ "NEUTRAL_NODE", "NEUTRAL_NODE", "NEUTRAL_NODE" },
		{ "NEUTRAL_NODE", "MAIN_DYE",     "NEUTRAL_NODE" },
		{ "NEUTRAL_NODE", "NEUTRAL_NODE", "NEUTRAL_NODE" },

	}
})

unifieddyes.register_color_craft({
	output = "plasticbox:plasticbox",
	palette = "extended",
	type = "shapeless",
	neutral_node = "plasticbox:plasticbox",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_lbm({
	name = "plasticbox:convert_colors",
	label = "Convert plastic boxes to use param2 color",
	nodenames = {
			"plasticbox:plasticbox_black",
			"plasticbox:plasticbox_blue",
			"plasticbox:plasticbox_brown",
			"plasticbox:plasticbox_cyan",
			"plasticbox:plasticbox_green",
			"plasticbox:plasticbox_grey",
			"plasticbox:plasticbox_magenta",
			"plasticbox:plasticbox_orange",
			"plasticbox:plasticbox_pink",
			"plasticbox:plasticbox_red",
			"plasticbox:plasticbox_violet",
			"plasticbox:plasticbox_white",
			"plasticbox:plasticbox_yellow",
			"plasticbox:plasticbox_darkgreen",
			"plasticbox:plasticbox_darkgrey",
		},
	action = function(pos,node)
		local conv = {
			["black"] = 5,
			["blue"] = 73,
			["brown"] = 22,
			["cyan"] = 57,
			["green"] = 41,
			["grey"] = 3,
			["magenta"] = 89,
			["orange"] = 17,
			["pink"] = 11,
			["red"] = 9,
			["violet"] = 81,
			["white"] = 1,
			["yellow"] = 25,
			["darkgreen"] = 46,
			["darkgrey"] = 4,
		}
		local name = node.name
		local oldcolor = string.sub(name,string.len("plasticbox:plasticbox_-"),-1)
		node.name = "plasticbox:plasticbox"
		if conv[oldcolor] then node.param2 = conv[oldcolor] end
		minetest.set_node(pos,node)
	end,
})

