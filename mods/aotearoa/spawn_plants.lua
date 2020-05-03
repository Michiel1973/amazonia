-------------------------------------------------------------------
--SPAWN PLANTS.
--Terrestrial non-schematic plants and decorations.


---------------------------------------------------------------
--DENSITIES.

--ground cover... scattered
local gc_fill = 0.002
local gc_fill_dense = gc_fill*6
local gc_fill_x_dense = gc_fill_dense*3
local gc_fill_rare = gc_fill/5

--ground cover... clumping
local gc_scale = 0.005
local gc_sc_dense = gc_scale*6
local gc_sc_rare = gc_scale/8
local gc_off = 0
local gc_spr = {x = 6, y = 6, z = 6}
local gc_spr2 = {x = 16, y = 16, z = 16}
local gc_oct = 2
local gc_pers = 0.7

-----------------------------------------------------------------
--ALTITUDES
--make sure matches mapgen file

--basement
local basement_max = -400
local basement_min = -9000

--ocean
local ocean_max = -21
local ocean_min = basement_max - 2

------------
--beaches
local beach_max = 3
local beach_min = -23
--dunes
local dune_max = 5
local dune_min = 2
--coastal forest etc
local coastf_max = 14
local coastf_min = 5
--lowland forest etc
local lowf_max = 40
local lowf_min = 20
--highland forest etc
local highf_max = 110
local highf_min = 70
--alpine
local alp_max = 160
local alp_min = 125
--high alpine
local high_alp_max = 6500
local high_alp_min = 180


---------------------------------------------------------------
--REGISTER
--{offset = gc_off,	scale = gc_sc_dense, spread = gc_spr,	seed = 88774, octaves = gc_oct, persist = gc_pers}

aotearoa.gc_deco_list = {
  --scoria boulders for volcanic_field
  {"aotearoa:scoria", {"aotearoa:scoria"}, nil, {"aotearoa_volcanic_field"},lowf_max/2,beach_min, {offset = gc_off,	scale = gc_scale, spread = gc_spr,	seed = 2009, octaves = gc_oct, persist = gc_pers}},
  --andesite boulders for subantarctic
  {"aotearoa:andesite", {"aotearoa:andesite", "default:dirt_with_grass"}, nil, {"aotearoa_subantarctic_shore","aotearoa_subantarctic_coast",},coastf_max,beach_min, {offset = gc_off,	scale = gc_scale, spread = gc_spr,	seed = 1109, octaves = gc_oct, persist = gc_pers}},
  --schist boulders for fellfield
  {"aotearoa:schist", {"aotearoa:schist",}, nil, {"aotearoa_fellfield",},alp_max,alp_min, {offset = gc_off,	scale = gc_scale, spread = gc_spr,	seed = 81209, octaves = gc_oct, persist = gc_pers}},
  --gravel for rocky places
  {"default:gravel", {"aotearoa:schist","aotearoa:andesite"}, nil, {"aotearoa_fellfield","aotearoa_subantarctic_shore"},alp_max,beach_min, {offset = gc_off,	scale = gc_scale, spread = gc_spr,	seed = 1100, octaves = gc_oct, persist = gc_pers}},

  --crown fern
  {"aotearoa:crown_fern", {"aotearoa:dirt_with_moss","default:dirt_with_rainforest_litter",}, gc_fill, {"aotearoa_manuka_scrub","aotearoa_mountain_beech_forest","aotearoa_kamahi_forest","aotearoa_muttonbird_scrub",},highf_max,coastf_min,},
  --dense crown fern
  {"aotearoa:crown_fern", {"aotearoa:dirt_with_beech_litter",}, gc_fill_dense, {"aotearoa_fiordland_forest","aotearoa_beech_forest",},lowf_max,lowf_min,},
  --rare kiokio
  {"aotearoa:kiokio", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_dry_litter",}, gc_fill_rare, {"aotearoa_broadleaf_scrub","aotearoa_geothermal_scrub","aotearoa_manuka_scrub","aotearoa_kauri_forest",},lowf_max,lowf_min,},
  -- kiokio
  {"aotearoa:kiokio", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_dry_litter","aotearoa:dirt_with_dark_litter",}, gc_fill, {"aotearoa_kamahi_forest","aotearoa_hinau_forest","aotearoa_southern_podocarp_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest",},lowf_max,lowf_min,},
  --coastal
  {"aotearoa:pohuehue", {"default:sand","aotearoa:iron_sand"}, nil, {"aotearoa_pohutukawa_dunes","aotearoa_sand_dunes", "aotearoa_iron_sand_dunes",},dune_max,beach_max, {offset = gc_off,	scale = gc_sc_dense, spread = gc_spr,	seed = 337121, octaves = gc_oct, persist = gc_pers}},
  {"aotearoa:wiwi", {"default:dirt_with_rainforest_litter","default:dirt_with_grass","default:sand","aotearoa:iron_sand", "default:gravel"}, gc_fill, {"aotearoa_muttonbird_scrub","aotearoa_coastal_scrub","aotearoa_pohutukawa_dunes","aotearoa_sand_dunes", "aotearoa_iron_sand_dunes", "aotearoa_gravel_dunes"},lowf_max,beach_max,},
  {"aotearoa:flax", {"default:dirt_with_grass","default:dirt_with_rainforest_litter","default:sand","aotearoa:iron_sand", "default:gravel"}, gc_fill, {"aotearoa_geothermal_scrub","aotearoa_coastal_scrub","aotearoa_pohutukawa_forest","aotearoa_pohutukawa_dunes","aotearoa_sand_dunes", "aotearoa_iron_sand_dunes", "aotearoa_gravel_dunes"},lowf_max,beach_max,},
  {"aotearoa:pingao", {"default:sand", "aotearoa:iron_sand"}, gc_fill_dense, {"aotearoa_pohutukawa_dunes","aotearoa_sand_dunes", "aotearoa_iron_sand_dunes", "aotearoa_sandy_beach","aotearoa_iron_sand_beach"},dune_max,beach_max -1,},
  {"aotearoa:spinifex", {"default:sand", "aotearoa:iron_sand"}, gc_fill_x_dense, {"aotearoa_pohutukawa_dunes","aotearoa_sand_dunes", "aotearoa_iron_sand_dunes", "aotearoa_sandy_beach","aotearoa_iron_sand_beach"},dune_max,beach_max-1,},
  {"aotearoa:sea_rush", {"aotearoa:mud"}, gc_fill_x_dense, {"aotearoa_salt_marsh"},dune_max,dune_min,},
  --sparse bracken
  {"aotearoa:bracken", {"default:dirt_with_rainforest_litter"}, gc_fill_rare, {"aotearoa_pohutukawa_forest"},coastf_max,coastf_min +2,},
  --clumped bracken
  {"aotearoa:bracken", {"default:dirt_with_grass",}, nil, {"aotearoa_coastal_scrub",},lowf_max,coastf_min +2,{offset = gc_off,	scale = gc_scale, spread = gc_spr,	seed = 557864, octaves = gc_oct, persist = gc_pers}},
  --dense bracken
  {"aotearoa:bracken", {"default:dirt_with_rainforest_litter"}, gc_fill_dense, {"aotearoa_manuka_scrub","aotearoa_geothermal_scrub", "aotearoa_broadleaf_scrub"},lowf_max,lowf_min,},

  --"babies" palms etc.
  {"aotearoa:cabbage_tree_crown", {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_grass","default:dirt_with_rainforest_litter","default:sand","aotearoa:iron_sand", "default:gravel"}, gc_fill_rare, {"aotearoa_broadleaf_scrub","aotearoa_geothermal_scrub","aotearoa_hinau_forest","aotearoa_southern_podocarp_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest","aotearoa_kauri_forest","aotearoa_coastal_scrub","aotearoa_pohutukawa_forest","aotearoa_pohutukawa_dunes","aotearoa_sand_dunes", "aotearoa_iron_sand_dunes", "aotearoa_gravel_dunes"},lowf_max,beach_max,},
  {"aotearoa:nikau_palm_crown", {"aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","default:dirt_with_grass","default:dirt_with_rainforest_litter",}, gc_fill_rare, {"aotearoa_hinau_forest","aotearoa_southern_podocarp_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest","aotearoa_kauri_forest","aotearoa_coastal_scrub","aotearoa_pohutukawa_forest",},lowf_max,coastf_min +2},
  {"aotearoa:wheki_crown", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",}, gc_fill_rare, {"aotearoa_manuka_scrub","aotearoa_broadleaf_scrub","aotearoa_geothermal_scrub","aotearoa_kamahi_forest","aotearoa_fiordland_forest","aotearoa_beech_forest","aotearoa_hinau_forest","aotearoa_southern_podocarp_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest","aotearoa_kauri_forest",},lowf_max,lowf_min,},
  {"aotearoa:mamaku_crown", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",}, gc_fill_rare, {"aotearoa_broadleaf_scrub","aotearoa_geothermal_scrub","aotearoa_hinau_forest","aotearoa_southern_podocarp_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest","aotearoa_kauri_forest",},lowf_max,lowf_min,},
  {"aotearoa:silver_fern_crown", {"default:dirt_with_rainforest_litter","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter",}, gc_fill_rare, {"aotearoa_manuka_scrub","aotearoa_broadleaf_scrub","aotearoa_geothermal_scrub","aotearoa_beech_forest","aotearoa_hinau_forest","aotearoa_southern_podocarp_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest","aotearoa_kauri_forest",},lowf_max,lowf_min,},
  --alpine
  -- bristle_tussock
  {"aotearoa:bristle_tussock", {"aotearoa:schist","default:dirt_with_dry_grass","aotearoa:volcanic_sand",}, gc_fill, {"aotearoa_fellfield","aotearoa_mountain_tussock","aotearoa_rangipo_desert",},alp_max-2,highf_min,},

  --dense flax
  {"aotearoa:flax", {"aotearoa:restiad_peat","aotearoa:forest_peat","default:dirt_with_dry_grass",}, gc_fill_dense, {"aotearoa_fen","aotearoa_kahikatea_swamp","aotearoa_coastal_tussock",},lowf_max,coastf_min,},
  --dense kauri_grass
  {"aotearoa:kauri_grass", {"aotearoa:dirt_with_dry_litter",}, gc_fill_dense, {"aotearoa_kauri_forest",},lowf_max,lowf_min,},

  --dense red tussock
  {"aotearoa:red_tussock", {"default:dirt_with_dry_grass",}, gc_fill_x_dense, {"aotearoa_mountain_tussock","aotearoa_matagouri_scrub","aotearoa_coastal_tussock",},alp_max + 5,coastf_min,},
  --rotten stump
  {"aotearoa:rotten_wood", {"aotearoa:dirt_with_moss","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","aotearoa:restiad_peat","aotearoa:gumland_soil","aotearoa:forest_peat","default:dirt_with_rainforest_litter",},gc_fill_rare,{"aotearoa_mountain_beech_forest","aotearoa_pahautea_forest","aotearoa_manuka_scrub","aotearoa_broadleaf_scrub","aotearoa_geothermal_scrub","aotearoa_kamahi_forest","aotearoa_fiordland_forest","aotearoa_beech_forest","aotearoa_hinau_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest","aotearoa_kauri_forest","aotearoa_fen","aotearoa_gumland","aotearoa_kahikatea_swamp",},highf_max,coastf_min+2,},
  --stunted manuka
  {"aotearoa:manuka_leaves", {"aotearoa:gumland_soil",},nil,{"aotearoa_gumland",},lowf_max,lowf_min, {offset = gc_off,	scale = gc_sc_dense, spread = gc_spr2,	seed = 8787761, octaves = gc_oct, persist = 0.1}},
  --dense moss
  {"aotearoa:moss", {"aotearoa:dirt_with_beech_litter","aotearoa:restiad_peat","aotearoa:forest_peat","default:dirt_with_rainforest_litter","aotearoa:andesite", "aotearoa:dirt_with_moss"}, gc_fill_x_dense, {"aotearoa_alpine_peat_bog","aotearoa_mountain_beech_forest","aotearoa_pahautea_forest","aotearoa_kamahi_forest","aotearoa_fiordland_forest","aotearoa_peat_bog","aotearoa_kahikatea_swamp","aotearoa_muttonbird_scrub","aotearoa_subantarctic_shore","aotearoa_subantarctic_coast",},highf_max,beach_max,},
  --rare moss clumps
  {"aotearoa:moss", {"default:dirt_with_rainforest_litter","aotearoa:schist","default:dirt_with_dry_grass","aotearoa:dirt_with_beech_litter","aotearoa:dirt_with_dark_litter","aotearoa:dirt_with_dry_litter","aotearoa:restiad_peat","aotearoa:gumland_soil",},nil, {"aotearoa_broadleaf_scrub", "aotearoa_geothermal_scrub","aotearoa_fellfield","aotearoa_mountain_tussock","aotearoa_beech_forest","aotearoa_hinau_forest","aotearoa_southern_podocarp_forest","aotearoa_maire_forest","aotearoa_tawa_forest","aotearoa_northern_podocarp_forest","aotearoa_kauri_forest","aotearoa_gumland","aotearoa_fen",},alp_max,lowf_min,{offset = gc_off, scale =gc_scale, spread = gc_spr2,	seed = 8755361, octaves = gc_oct, persist = 0.7}},


}

for i in ipairs(aotearoa.gc_deco_list) do
  local deco     = aotearoa.gc_deco_list[i][1]
	local substrate = aotearoa.gc_deco_list[i][2]
	local density = aotearoa.gc_deco_list[i][3]
  local habitat = aotearoa.gc_deco_list[i][4]
  local max_alt = aotearoa.gc_deco_list[i][5]
  local min_alt = aotearoa.gc_deco_list[i][6]
  local noise = aotearoa.gc_deco_list[i][7]

  if density ~= nil then
    minetest.register_decoration({
    		deco_type = "simple",
    		place_on = substrate,
    		sidelen = 16,
    		fill_ratio = density,
    		biomes = habitat,
    		y_min = min_alt,
    		y_max = max_alt,
    		decoration = deco
    })
  else
    minetest.register_decoration({
    		deco_type = "simple",
    		place_on = substrate,
    		sidelen = 16,
    		noise_params = noise,
        biomes = habitat,
    		y_min = min_alt,
    		y_max = max_alt,
    		decoration = deco
    })
  end
end
