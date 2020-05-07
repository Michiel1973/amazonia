local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/nodes.lua")
dofile(modpath.."/invader.lua")
dofile(modpath.."/engine.lua")
dofile(modpath.."/tools.lua")
dofile(modpath.."/miniufo.lua")
dofile(modpath.."/lighter.lua")
dofile(modpath.."/base.lua")

local _ = {
  name = "vacuum:vacuum",
  prob = 0,
}

local A = {
  name = "air",
  force_place = true,
}

local M = {
  name = "ufowreck:alien_metal",
  force_place = true,
}

local M1 = {
  name = "ufowreck:alien_metal",
  force_place = true,
}

local L = {
  name = "ufowreck:alien_light",
  force_place = true,
}

local G = {
  name = "ufowreck:alien_glass",
  force_place = true,
}

local D1 = {
  name = "ufowreck:alien_door_closed", param2=3,
  force_place = true,
}

local D2 = {
  name = "ufowreck:alien_door_closed", param2=1,
  force_place = true,
}

local D3 = {
  name = "ufowreck:alien_door_closed_top", param2=3,
  force_place = true,
}

local D4 = {
  name = "ufowreck:alien_door_closed_top", param2=1,
  force_place = true,
}

local C = {
  name = "ufowreck:alien_control",
  force_place = true,
}


local E = {name = "ufowreck:alien_engine", force_place = true, prob = 5}

local H = {name = "ufowreck:alien_health_charger8", force_place = true, prob = 10}

local F1 = {name = "technic:mineral_uranium", force_place = true, prob = 180}

local F2 = {name = "default:stone_with_mese", force_place = true, prob = 128}

local P1 = {name = "ufowreck:locked_crate", force_place = true, prob = 150}

local P2 = {name = "ufowreck:crate", force_place = true, prob = 80}

local P3 = {name = "ufowreck:bar_light", force_place = true, prob = 65}

local S = {name = "ufowreck:floob_spawner", force_place = true, prob = 220}

-- make schematic
ufowreck_schematic_1 = {
  size = {x = 10, y = 5, z = 10},
  data = {
--1   
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, M, M, M, G, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--2
    _, _, _, M1, M, M1, M1, _, _, _,
    _, M, M, A, A, M, A, M, M1, _,
    _, M, M, A, A, H, A, G, G, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--3
    _, _, M, M, M, M1, M, M, _, _,
    _, M, A, E, A, A, A, A, M, _,
    _, M, A, A, A, A, A, A, G, _,
    _, _, M, A, A, A, A, M1, _, _,
    _, _, _, M, M, M, M1, _, _, _,
--4
    _, M, M, M1, M, M, M1, M, M, _,
    M, M, M, L, L, M, A, A, A, M,
    S, M, M, L, L, M, A, A, A, G,
    _, M, M, L, L, M, A, A, M, _,
    _, _, M, M1, M, M, M1, M1, _, _,
--5
    _, M, M, M1, M, M, S, M, M, _,
    _, D1, A, A, A, A, A, A, C, M,
    _, D3, A, A, A, A, A, A, A, G,
    _, M, A, A, A, A, A, A, M, _,
    _, _, M, M1, M, M, M, M1, _, _,
--6
    _, M, M, S, M, M1, M, M, M1, _,
    _, D2, A, A, A, A, A, A, C, M,
    _, D4, A, A, A, A, A, A, A, G,
    _, M, A, A, A, A, A, A, M, _,
    _, _, M1, M, M, M, M, M, _, _,
--7
    _, M, M, M, M, M, M1, M, M, _,
    M, M, M, L, L, M, A, A, A, M,
    M, M, M, L, L, M, A, A, A, G,
    _, M, M, L, L, M, A, A, M, _,
    _, _, M, M, M, M1, M1, M, _, _,
--8
    _, _, M, M, M, M, M, M, _, _,
    _, M, P2, A, A, A, A, A, M, _,
    _, M, P2, A, A, A, A, A, G, _,
    _, _, M, A, A, A, A, M, _, _,
    _, _, _, M1, M, M, M1, _, _, _,
--9
    _, _, _, M, M, M, M1, _, _, _,
    _, M, M, P3, P1, M, A, M, M, _,
    _, M, M, A, A, M, A, G, G, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--10
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, M, M, M1, M1, _, _, _,
    _, _, _, M, M, M, G, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    
  }
}

ufowreck_schematic_2 = {
  size = {x = 10, y = 5, z = 10},
  data = {
--1   
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, M, M, M, G, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--2
    _, _, _, M1, M, M1, M1, _, _, _,
    _, M, M, F1, A, M, A, M, M1, _,
    _, M, M, A, A, H, A, G, G, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--3
    _, _, M, M, M, M1, M, M, _, _,
    _, M, F1, F1, F1, A, A, A, M, _,
    _, M, A, F1, A, A, A, A, G, _,
    _, _, M, A, A, A, A, M1, _, _,
    _, _, _, M, M, M, M1, _, _, _,
--4
    _, M, M, M1, M, M, M1, M, M, _,
    M, M, M, L, L, M, A, A, A, M,
    S, M, M, L, L, M, A, A, A, G,
    _, M, M, L, L, M, A, A, M, _,
    _, _, M, M1, M, M, M1, M1, _, _,
--5
    _, M, M, M1, M, M, M, M, M, _,
    _, D1, A, A, A, A, A, A, C, M,
    _, D3, A, A, A, A, A, A, A, G,
    _, M, A, A, A, A, A, A, M, _,
    _, _, M, M1, M, M, M, M1, _, _,
--6
    _, M, M, S, M, M, M, M, M1, _,
    _, D2, A, A, A, A, A, A, C, M,
    _, D4, A, A, A, A, A, A, A, G,
    _, M, A, A, A, A, A, A, M, _,
    _, _, M1, M, M, M, M, M, _, _,
--7
    _, M, M, M, M, M, M1, M, M, _,
    M, M, M, L, L, M, A, A, A, M,
    M, M, M, L, L, M, A, A, A, G,
    _, M, M, L, L, M, A, A, M, _,
    _, _, M, M, M, M1, M1, M, _, _,
--8
    _, _, M, M, M, M, M, M, _, _,
    _, M, P1, A, A, A, A, A, M, _,
    _, M, P2, A, A, A, A, A, G, _,
    _, _, M, A, A, A, A, M, _, _,
    _, _, _, M, M, M, M1, _, _, _,
--9
    _, _, _, M, M, M, M1, _, _, _,
    _, M, M, P2, P2, M, A, M, M, _,
    _, M, M, A, A, M, A, G, G, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--10
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, M, M, M1, M1, _, _, _,
    _, _, _, M, M, M, G, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    
  }
}

ufowreck_schematic_3 = {
  size = {x = 10, y = 5, z = 10},
  data = {
--1   
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, M, M, M, G, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--2
    _, _, _, M1, M, M1, M1, _, _, _,
    _, M, M, F2, A, M, A, M, M1, _,
    _, M, M, A, A, H, A, G, G, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--3
    _, _, M, M, M, M1, M, M, _, _,
    _, M, F2, F2, F2, A, A, A, M, _,
    _, M, _, F2, A, A, A, A, G, _,
    _, _, M, A, A, A, A, M1, _, _,
    _, _, _, M, M, M, M1, _, _, _,
--4
    _, M, M, M1, M, M, M1, M, M, _,
    M, M, M, L, L, M, A, A, A, M,
    S, M, M, L, L, M, A, A, A, G,
    _, M, M, L, L, M, A, A, M, _,
    _, _, M, M1, M, M, M1, M1, _, _,
--5
    _, M, M, M1, M, M, M, M, M, _,
    _, D1, A, A, A, A, A, A, C, M,
    _, D3, A, A, A, A, A, A, A, G,
    _, M, A, A, A, A, A, A, M, _,
    _, _, M, M1, M, M, M, M1, _, _,
--6
    _, M, M, S, M, M, M, M, M1, _,
    _, D2, A, A, A, A, A, A, C, M,
    _, D4, A, A, A, A, A, A, A, G,
    _, M, A, A, A, A, A, A, M, _,
    _, _, M1, M, M, M, M, M, _, _,
--7
    _, M, M, M, M, M, M1, M, M, _,
    M, M, M, L, L, M, A, A, A, M,
    M, M, M, L, L, M, A, A, A, G,
    _, M, M, L, L, M, A, A, M, _,
    _, _, M, M, M, M1, M1, M, _, _,
--8
    _, _, M, M, M, M, M, M, _, _,
    _, M, P1, A, A, A, A, A, M, _,
    _, M, A, A, A, A, A, A, G, _,
    _, _, M, A, A, A, A, M, _, _,
    _, _, _, M, M, M, M1, _, _, _,
--9
    _, _, _, M, M, M, M1, _, _, _,
    _, M, M, P3, P3, M, A, M, M, _,
    _, M, M, A, A, M, A, G, G, _,
    _, _, _, M, M, M, M, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
--10
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, M, M, M1, M1, _, _, _,
    _, _, _, M, M, M, G, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _, _,
    
  }
}

if math.random(2) == 1 then rotx = '180'
else rotx = '0'
end

--with engine
minetest.register_decoration({
  deco_type = "schematic",
  place_on = {"cratermg:dust"},
  sidelen = 8,
  fill_ratio = 0.000000000000000000001,
  -- noise_params = {
		-- offset = 0,
		-- scale = 1,
		-- spread = {x=2048, y=2048, z=2048},
		-- seed = 1337,
		-- octaves = 6,
		-- persist = 0.6
   -- },
  schematic = ufowreck_schematic_1,
  rotation = rotx,
  y_min = 26950,
  y_max = 27050,
  flags = {place_center_z = true, place_center_x = true},
})

minetest.register_decoration({
  deco_type = "schematic",
  place_on = {"cratermg:dust"},
  sidelen = 8,
  fill_ratio = 0.000000000000000000001,
  -- noise_params = {
		-- offset = 0,
		-- scale = 1,
		-- spread = {x=2048, y=2048, z=2048},
		-- seed = 6432,
		-- octaves = 6,
		-- persist = 0.6
	-- },
  schematic = ufowreck_schematic_2,
  rotation = rotx,
  y_min = 26950,
  y_max = 27050,
  flags = {place_center_z = true, place_center_x = true},
})

minetest.register_decoration({
  deco_type = "schematic",
  place_on = {"cratermg:dust"},
  sidelen = 8,
  fill_ratio = 0.000000000000000000001,
  -- noise_params = {
		-- offset = 0,
		-- scale = 1,
		-- spread = {x=2048, y=2048, z=2048},
		-- seed = 3731,
		-- octaves = 6,
		-- persist = 0.6
   -- },
  schematic = ufowreck_schematic_3,
  rotation = rotx,
  y_min = 26950,
  y_max = 27050,
  flags = {place_center_z = true, place_center_x = true},
})

dofile(modpath.."//mapgen.lua")