local S = minetest.get_translator("currency")

minetest.register_craftitem("currency:minegeld_cent_5", {
	description = S("@1 Minecents", "5"),
	inventory_image = "minegeld_cent_5.png",
		stack_max = 1000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_cent_10", {
	description = S("@1 Minecents", "10"),
	inventory_image = "minegeld_cent_10.png",
		stack_max = 1000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_cent_25", {
	description = S("@1 Minecents", "25"),
	inventory_image = "minegeld_cent_25.png",
		stack_max = 1000,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld", {
	description = S("@1 Minecoin Note", "1"),
	inventory_image = "minegeld.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_5", {
	description = S("@1 Minecoin Note", "5"),
	inventory_image = "minegeld_5.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_10", {
	description = S("@1 Minecoin Note", "10"),
	inventory_image = "minegeld_10.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_50", {
	description = S("@1 Minecoin Note", "50"),
	inventory_image = "minegeld_50.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_100", {
	description = S("@1 Minecoin Note", "100"),
	inventory_image = "minegeld_100.png",
		stack_max = 65535,
		groups = {minegeld = 1}
})

minetest.register_craftitem("currency:minegeld_bundle", {
	description = S("Bundle of random Minecoin notes"),
	inventory_image = "minegeld_bundle.png",
		stack_max = 65535,
})
