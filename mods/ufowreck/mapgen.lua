minetest.register_on_generated(function(minp, maxp, seed)

if minp.y < 26800 or minp.y > 27500 then
		return
end
	
local mapdata = {}
local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
vm:get_data(mapdata)
minetest.generate_decorations(vm)
vm:write_to_map()
end)