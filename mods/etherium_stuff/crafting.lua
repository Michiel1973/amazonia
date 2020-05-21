
minetest.register_craft({
	output = 'etherium_stuff:torch 4',
	recipe = {
		{'ethereal:etherium_dust'},
		{'default:coal_lump'},
		{'group:stick'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "etherium_stuff:bucket_crystal_water",
	recipe = {
		"bucket:bucket_water", "ethereal:crystal_spike", "ethereal:etherium_dust"
	},
	
})
if not minetest.get_modpath("technic") then

	minetest.register_craft({
		output = "etherium_stuff:sandstone",
		recipe = {
		{"etherium_stuff:sand", "etherium_stuff:sand"},
		{"etherium_stuff:sand", "etherium_stuff:sand"},
		},
	})

	minetest.register_craft({
	output = "etherium_stuff:sand 2",
	recipe = {
		{"etherium_stuff:sandstone"},
	}
	})
	minetest.register_craft({
	output = "etherium_stuff:crystal_glass 4",
	recipe = {
		{"", "etherium_stuff:glass", ""},
		{"etherium_stuff:glass", "ethereal:crystal_spike", "etherium_stuff:glass"},
		{"", "etherium_stuff:glass", ""},
		},
	})

else
	technic.register_compressor_recipe({input = {"etherium_stuff:sand 2"}, output = "etherium_stuff:sandstone"})
	technic.register_alloy_recipe({input = {"etherium_stuff:glass 4", "ethereal:crystal_spike"}, output = "etherium_stuff:crystal_glass 4", time = 2})
	technic.register_grinder_recipe({input = {"etherium_stuff:sandstone"}, output = "etherium_stuff:sand 2"})
end




minetest.register_craft({
	output = "etherium_stuff:sandstone_brick 4",
	recipe = {
		{"etherium_stuff:sandstone", "etherium_stuff:sandstone"},
		{"etherium_stuff:sandstone", "etherium_stuff:sandstone"},
	}
})

minetest.register_craft({
	output = "etherium_stuff:sandstone_block 9",
	recipe = {
		{"etherium_stuff:sandstone", "etherium_stuff:sandstone", "etherium_stuff:sandstone"},
		{"etherium_stuff:sandstone", "etherium_stuff:sandstone", "etherium_stuff:sandstone"},
		{"etherium_stuff:sandstone", "etherium_stuff:sandstone", "etherium_stuff:sandstone"},
	}
})

minetest.register_craft({
	output = "etherium_stuff:sand 8",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "ethereal:etherium_dust", "group:sand"},
		{"group:sand", "group:sand", "group:sand"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "etherium_stuff:glass",
	recipe = "etherium_stuff:sand",
})

if not minetest.get_modpath("morelights") then
	
	minetest.register_craft({
	output = "etherium_stuff:sandstone_light_block",
	recipe = {
	    {"", "etherium_stuff:crystal_glass", ""},
	    {"", "default:torch", ""},
	    {"", "etherium_stuff:sandstone_block", ""},
	  }
	})
	
else
	minetest.register_craft({
	output = "etherium_stuff:sandstone_light_block",
	recipe = {
	    {"", "etherium_stuff:crystal_glass", ""},
	    {"", "morelights:bulb", ""},
	    {"", "etherium_stuff:sandstone_block", ""},
	  }
	})
end