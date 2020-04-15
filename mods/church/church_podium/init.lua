
screwdriver = screwdriver or {}

local podiums = {}

-------------------
-- Register Nodes
-------------------

podiums.materials = {
	{"acacia_wood", "Acacia Wood", "default_acacia_wood.png", "default:acacia_wood"},
	{"aspen_wood", "Aspen Wood", "default_aspen_wood.png", "default:aspen_wood"},
	{"junglewood", "Jungle Wood", "default_junglewood.png", "default:junglewood"},
	{"pine_wood", "Pine Wood", "default_pine_wood.png", "default:pine_wood"},
	{"wood", "Appletree Wood", "default_wood.png", "default:wood"},
}

for _, row in ipairs(podiums.materials) do
	local name = row[1]
	local desc = row[2]
	local tiles = row[3]
	local craft_material = row[4]

	minetest.register_node(":church_podiums:podium_top_"..name, {
		drawtype = "nodebox",
		description = desc.." Podium",
		tiles = { tiles },
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = "",
		groups = {oddly_breakable_by_hand= 2, choppy = 3, not_in_creative_inventory = 1},
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.rotate_simple,
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.3125, -0.5, 0.5, -0.25, 0.5},
			{-0.4375, -0.375, -0.4375, 0.4375, -0.3125, 0.4375},
			{-0.375, -0.5, -0.4375, 0.375, -0.375, 0.375},
			{-0.5, -0.25, 0.4375, 0.5, 0, 0.5},
			{-0.5, -0.25, -0.4375, -0.4375, -0.1875, 0.4375},
			{-0.5, -0.1875, -0.25, -0.4375, -0.125, 0.4375},
			{-0.5, -0.125, -0.0625, -0.4375, -0.0625, 0.4375},
			{-0.5, -0.0625, 0.125, -0.4375, 0, 0.4375},
			{0.4375, -0.25, -0.4375, 0.5, -0.1875, 0.4375},
			{0.4375, -0.1875, -0.25, 0.5, -0.125, 0.4375},
			{0.4375, -0.125, -0.0625, 0.5, -0.0625, 0.4375},
			{0.4375, -0.0625, 0.125, 0.5, 0, 0.4375},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
			},
		}
  })

	minetest.register_node(":church_podiums:podium_bottom_" ..name, {
		drawtype = "nodebox",
		description = desc.." Podium",
		inventory_image = "podiums_" ..name.. "_inv.png",
		--wield_image = "podiums_" ..name.. "_inv.png",
		tiles = { tiles },
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {oddly_breakable_by_hand= 2, choppy = 3},
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.rotate_simple,
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.4375, -0.4375, -0.4375, 0.4375, -0.375, 0.4375},
			{-0.375, -0.375, -0.4375, 0.375, -0.1875, 0.375},
			{0.25, -0.1875, 0.3125, 0.375, 0.5, 0.375},
			{-0.375, -0.5, 0.3125, -0.25, 0.5, 0.375},
			{-0.375, -0.1875, 0.25, 0.375, 0.5, 0.3125},
			{-0.3125, -0.1875, -0.4375, -0.25, 0.5, 0.25},
			{0.25, -0.1875, -0.4375, 0.3125, 0.5, 0.3125},
			{-0.25, 0.4375, -0.4375, 0.25, 0.5, 0.25},
			{-0.25, 0.0625, -0.375, 0.25, 0.125, 0.25},
			},
		},
		selection_box = {
   type = "fixed",
   fixed = {
    {-0.5, -0.5, -0.5, 0.5, 1.125, 0.5},
   },
	},
	after_place_node =function(pos, placer)
	local p1 = {x=pos.x, y=pos.y+1, z=pos.z}
	local n1 = minetest.get_node(p1)
		if n1.name == "air" then
			minetest.add_node(p1, {name="church_podiums:podium_top_" ..name, param2=minetest.dir_to_facedir(placer:get_look_dir())})
		end
	end,
	after_destruct = function(pos,oldnode)
	local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
		if node.name == "church_podiums:podium_top_" ..name then
			minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z})
		end
	end,

	})


---------------------------
-- Register Craft Recipes
---------------------------
if craft_material then
    minetest.register_craft({
        output = "church_podiums:podium_bottom_" ..name,
        recipe = {
            {"stairs:slab_" ..name},
            {craft_material},
            {"stairs:slab_" ..name},
        }
    })
end

end
