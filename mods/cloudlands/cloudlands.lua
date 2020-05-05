local S = minetest.get_translator(MODNAME)

-- nodes

minetest.register_node("cloudlands:dirt", {
	description = S("Dirt"),
	tiles = {"cloudlands_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
	drop = "cloudlands:dirt",
})

minetest.register_node("cloudlands:dirt_with_grass", {
	description = S("Dirt with Grass"),
	tiles = {"cloudlands_grass.png", "cloudlands_dirt.png",
		{name = "cloudlands_dirt.png^cloudlands_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "cloudlands:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

local ALTITUDE               = 7080      -- average altitude of islands
local ALTITUDE_AMPLITUDE     = 80       -- rough island altitude variance (plus or minus)
local GENERATE_ORES          = true    -- set to true for island core stone to contain patches of dirt and sand etc.
local LOWLAND_BIOMES         = true

local LOWLAND_BIOME_ALTITUDE = 7000       -- Higher than beaches, lower than mountains (See LOWLAND_BIOMES)
local VINE_COVERAGE          = 0      -- set to 0 to turn off vines
local REEF_RARITY            = 0.015    -- Chance of a viable island having a reef or atoll
local TREE_RARITY            = 0     -- Chance of a viable island having a giant tree growing out of it
local PORTAL_RARITY          = 0.04     -- Chance of a viable island having some ancient portalstone on it (If portals API available and ENABLE_PORTALS is true)
local BIOLUMINESCENCE        = false

local ENABLE_PORTALS         = false     -- Whether to allow players to build portals to islands. Portals require the Nether mod.
local EDDYFIELD_SIZE         = 0.7        -- size of the "eddy field-lines" that smaller islands follow
local ISLANDS_SEED           = 1000     -- You only need to change this if you want to try different island layouts without changing the map seed

-- Some lists of known node aliases (any nodes which can't be found won't be used).
local NODENAMES_STONE       = {"default:stone"}
local NODENAMES_WATER       = {"default:water_source"}
local NODENAMES_ICE         = {"default:water_source"}
local NODENAMES_GRAVEL      = {"default:gravel"}
local NODENAMES_GRASS       = {"cloudlands:dirt_with_grass"} -- currently only used with games that don't register biomes, e.g. Hades Revisted
local NODENAMES_DIRT        = {"cloudlands:dirt"}            -- currently only used with games that don't register biomes, e.g. Hades Revisted
local NODENAMES_SILT        = {"default:clay"} -- silt isn't a thing yet, but perhaps one day it will be. Use sand for the bottom of ponds in the meantime.
local NODENAMES_VINES       = {"ethereal:vine"} -- ethereal vines don't grow, so only select that if there's nothing else.
local NODENAMES_HANGINGVINE = {"vines:vine_end"}
local NODENAMES_HANGINGROOT = {"vines:root_end"}
local NODENAMES_TREEWOOD    = {"default:tree"}
local NODENAMES_TREELEAVES  = {"default:leaves"}
local NODENAMES_FRAMEGLASS  = {"default:glass"}
local NODENAMES_WOOD        = {"default:wood"}

local MODNAME                    = minetest.get_current_modname()
local VINES_REQUIRED_HUMIDITY    = 49
local VINES_REQUIRED_TEMPERATURE = 40
local ICE_REQUIRED_TEMPERATURE   = 8

local DEBUG                  = false -- dev logging
local DEBUG_GEOMETRIC        = false -- turn off noise from island shapes
local DEBUG_SKYTREES         = false -- dev logging

-- OVERDRAW can be set to 1 to cause a y overdraw of one node above the chunk, to avoid creating a dirt "surface"
-- at the top of the chunk that trees mistakenly grow on when the chunk is decorated.
-- However, it looks like that tree problem has been solved by either engine or biome updates, and overdraw causes
-- it's own issues (e.g. nodeId_top not getting set correctly), so I'm leaving overdraw off (i.e. zero) until I
-- notice problems requiring it.
local OVERDRAW = 0

cloudlands = {} -- API functions can be accessed via this global:
                -- cloudlands.get_island_details(minp, maxp)                   -- returns an array of island-information-tables, y is ignored.
                -- cloudlands.find_nearest_island(x, z, search_radius)         -- returns a single island-information-table, or nil
                -- cloudlands.get_height_at(x, z, [island-information-tables]) -- returns (y, isWater), or nil if no island here

cloudlands.coreTypes = {
  -- {
    -- territorySize     = 200,
    -- coresPerTerritory = 3,
    -- radiusMax         = 96,
    -- depthMax          = 50,
    -- thicknessMax      = 8,
    -- frequency         = 0.1,
    -- pondWallBuffer    = 0.03,
    -- requiresNexus     = true,
    -- exclusive         = false
  -- },
 
   {
    territorySize     = 200,
    coresPerTerritory = 6,
    radiusMax         = 225,
    depthMax          = 60,
    thicknessMax      = 10,
    frequency         = 0.1,
    pondWallBuffer    = 0.02,
    requiresNexus     = true,
    exclusive         = false
  },
  {
    territorySize     = 60,
    coresPerTerritory = 2,
    radiusMax         = 110,
    depthMax          = 50,
    thicknessMax      = 6,
    frequency         = 0.1,
    pondWallBuffer    = 0.04,
    requiresNexus     = false,
    exclusive         = true
  },
  {
    territorySize     = 30,
    coresPerTerritory = 1,
    radiusMax         = 58, -- I feel this and depthMax should be bigger, say 18, and territorySize increased to 34 to match, but I can't change it any more or existing worlds will mismatch along previously emerged chunk boundaries
    depthMax          = 19,
    thicknessMax      = 4,
    frequency         = 0.1,
    pondWallBuffer    = 0.09, -- larger values will make ponds smaller and further from island edges, so it should be as low as you can get it without the ponds leaking over the edge. A small leak-prone island is at (3160, -2360) on seed 1
    requiresNexus     = false,
    exclusive         = true
  }
}

if minetest.get_biome_data == nil then error(MODNAME .. " requires Minetest v5.0 or greater", 0) end

local function fromSettings(settings_name, default_value)
  local result
  if type(default_value) == "number" then
    result = tonumber(minetest.settings:get(settings_name) or default_value)
  elseif type(default_value) == "boolean" then
    result = minetest.settings:get_bool(settings_name, default_value)
  end
  return result
end

-- override any settings with user-specified values before these values are needed
ALTITUDE             = fromSettings(MODNAME .. "_altitude",           ALTITUDE)
ALTITUDE_AMPLITUDE   = fromSettings(MODNAME .. "_altitude_amplitude", ALTITUDE_AMPLITUDE)
GENERATE_ORES        = fromSettings(MODNAME .. "_generate_ores",      GENERATE_ORES)
VINE_COVERAGE        = fromSettings(MODNAME .. "_vine_coverage",      VINE_COVERAGE * 100) / 100
LOWLAND_BIOMES       = false
TREE_RARITY          = fromSettings(MODNAME .. "_giant_tree_rarety",  TREE_RARITY * 100) / 100
BIOLUMINESCENCE      = false
ENABLE_PORTALS       = false

local noiseparams_eddyField = {
	offset      = -1,
	scale       = 2,
	spread      = {x = 350 * EDDYFIELD_SIZE, y = 350 * EDDYFIELD_SIZE, z= 350 * EDDYFIELD_SIZE},
	seed        = ISLANDS_SEED, --WARNING! minetest.get_perlin() will add the server map's seed to this value
	octaves     = 2,
	persistence = 0.7,
	lacunarity  = 2.0,
}
local noiseparams_heightMap = {
	offset      = 0,
	scale       = ALTITUDE_AMPLITUDE,
	spread      = {x = 160, y = 160, z= 160},
	seed        = ISLANDS_SEED, --WARNING! minetest.get_perlin() will add the server map's seed to this value
	octaves     = 3,
	persistence = 0.5,
	lacunarity  = 2.0,
}
local DENSITY_OFFSET = 0.7
local noiseparams_density = {
	offset      = DENSITY_OFFSET,
	scale       = .3,
	spread      = {x = 25, y = 25, z= 25},
	seed        = 1000, --WARNING! minetest.get_perlin() will add the server map's seed to this value
	octaves     = 4,
	persistence = 0.5,
	lacunarity  = 2.0,
}
local SURFACEMAP_OFFSET = 0.5
local noiseparams_surfaceMap = {
	offset      = SURFACEMAP_OFFSET,
	scale       = .7,
	spread      = {x = 40, y = 40, z= 40},
	seed        = ISLANDS_SEED, --WARNING! minetest.get_perlin() will add the server map's seed to this value
	octaves     = 4,
	persistence = 0.5,
	lacunarity  = 2.0,
}
local noiseparams_skyReef = {
	offset      = .3,
	scale       = .9,
	spread      = {x = 3, y = 3, z= 3},
	seed        = 1000,
	octaves     = 2,
	persistence = 0.5,
	lacunarity  = 2.0,
}

local noiseAngle = -15 --degrees to rotate eddyField noise, so that the vertical and horizontal tendencies are off-axis
local ROTATE_COS = math.cos(math.rad(noiseAngle))
local ROTATE_SIN = math.sin(math.rad(noiseAngle))

local noise_eddyField
local noise_heightMap
local noise_density
local noise_surfaceMap
local noise_skyReef

local worldSeed
local nodeId_ignore = minetest.CONTENT_IGNORE
local nodeId_air
local nodeId_stone
local nodeId_grass
local nodeId_dirt
local nodeId_water
local nodeId_ice
local nodeId_silt
local nodeId_gravel
local nodeId_vine
local nodeName_vine
local nodeName_ignore = minetest.get_name_from_content_id(nodeId_ignore)

local REQUIRED_DENSITY = 0.4

local randomNumbers = {} -- array of 0-255 random numbers with values between 0 and 1 (inclusive)
local data          = {} -- reuse the massive VoxelManip memory buffers instead of creating on every on_generate()
local biomes        = {}

-- optional region specified in settings to restrict islands too
local region_restrictions = false
local region_min_x, region_min_z, region_max_x, region_max_z = -32000, -32000, 32000, 32000

-- optional biomes specified in settings to restrict islands too
local limit_to_biomes = nil
local limit_to_biomes_altitude = nil

--[[==============================
           Math functions
    ==============================]]--

-- avoid having to perform table lookups each time a common math function is invoked
local math_min, math_max, math_floor, math_sqrt, math_cos, math_sin, math_abs, math_pow, PI = math.min, math.max, math.floor, math.sqrt, math.cos, math.sin, math.abs, math.pow, math.pi

local function clip(value, minValue, maxValue)
  if value <= minValue then
    return minValue
  elseif value >= maxValue then
    return maxValue
  else
    return value
  end
end

local function round(value)
  return math_floor(0.5 + value)
end

--[[==============================
           Interop functions
    ==============================]]--

local get_heat, get_humidity = minetest.get_heat, minetest.get_humidity

local biomeinfoAvailable = minetest.get_modpath("biomeinfo") ~= nil and minetest.global_exists("biomeinfo")
local isMapgenV6 = minetest.get_mapgen_setting("mg_name") == "v6"
if isMapgenV6 then
  if not biomeinfoAvailable then
    -- The biomeinfo mod by Wuzzy can be found at https://repo.or.cz/minetest_biomeinfo.git
    minetest.log("warning", MODNAME .. " detected mapgen v6: Full mapgen v6 support requires adding the biomeinfo mod.")
  else
    get_heat = function(pos)
      return biomeinfo.get_v6_heat(pos) * 100
    end
    get_humidity = function(pos)
      return biomeinfo.get_v6_humidity(pos) * 100
    end
  end
end

local interop = {}
-- returns the id of the first nodename in the list that resolves to a node id, or nodeId_ignore if not found
interop.find_node_id = function (node_contender_names)
  local result = nodeId_ignore
  for _,contenderName in ipairs(node_contender_names) do

    local nonAliasName = minetest.registered_aliases[contenderName] or contenderName
    if minetest.registered_nodes[nonAliasName] ~= nil then
      result = minetest.get_content_id(nonAliasName)
    end

    --if DEBUG then minetest.log("info", contenderName .. " returned " .. result .. " (" .. minetest.get_name_from_content_id(result) .. ")") end
    if result ~= nodeId_ignore then return result end
  end
  return result
end

-- returns the name of the first nodename in the list that resolves to a node id, or 'ignore' if not found
interop.find_node_name = function (node_contender_names)
  return minetest.get_name_from_content_id(interop.find_node_id(node_contender_names))
end

interop.get_first_element_in_table = function(tbl)
  for k,v in pairs(tbl) do return v end
  return nil
end

-- returns the top-texture name of the first nodename in the list that's a registered node, or nil if not found
interop.find_node_texture = function (node_contender_names)
  local result = nil
  local nodeName = minetest.get_name_from_content_id(interop.find_node_id(node_contender_names))
  if nodeName ~= nil then
    local node = minetest.registered_nodes[nodeName]
    if node ~= nil then
      result = node.tiles
      if type(result) == "table" then result = result["name"] or interop.get_first_element_in_table(result) end -- incase it's not a string
      if type(result) == "table" then result = result["name"] or interop.get_first_element_in_table(result) end -- incase multiple tile definitions
    end
  end
  return result
end

-- returns the node name of the clone node.
interop.register_clone = function(node_name, clone_name)
  local node = minetest.registered_nodes[node_name]
  if node == nil then
    minetest.log("error", "cannot clone " .. node_name)
    return nil
  else
    if clone_name == nil then clone_name = MODNAME .. ":" .. string.gsub(node.name, ":", "_") end
    if minetest.registered_nodes[clone_name] == nil then
      if DEBUG then minetest.log("info", "attempting to register: " .. clone_name) end
      local clone = {}
      for key, value in pairs(node) do clone[key] = value end
      clone.name = clone_name
      minetest.register_node(clone_name, clone)
      --minetest.log("info", clone_name .. " id: " .. minetest.get_content_id(clone_name))
      --minetest.log("info", clone_name .. ": " .. dump(minetest.registered_nodes[clone_name]))
    end
    return clone_name
  end
end

-- converts "modname:nodename" into (modname, nodename), if no colon is found then modname is nil
interop.split_nodename = function(nodeName)
  local result_modname = nil
  local result_nodename = nodeName

  local pos = nodeName:find(':')
  if pos ~= nil then
    result_modname  = nodeName:sub(0, pos - 1)
    result_nodename = nodeName:sub(pos + 1)
  end
  return result_modname, result_nodename
end;

-- returns a unique id for the biome, normally this is numeric but with mapgen v6 it can be a string name.
interop.get_biome_key = function(pos)
  if isMapgenV6 and biomeinfoAvailable then
    return biomeinfo.get_v6_biome(pos)
  else
    return minetest.get_biome_data(pos).biome
  end
end

-- returns true if filename is a file that exists.
interop.file_exists = function(filename)
  local f = io.open(filename, "r")
  if f == nil then
    return false
  else
    f:close()
    return true
  end
end

-- returns a written book item (technically an item stack), or nil if no books mod available
interop.write_book = function(title, author, text, description)

  local stackName_writtenBook
  if minetest.get_modpath("mcl_books") then
    stackName_writtenBook = "mcl_books:written_book"
    text = title .. "\n\n" .. text -- MineClone2 books doen't show a title (or author)

  elseif minetest.get_modpath("book") ~= nil then
    stackName_writtenBook = "book:book_written"
    text = "\n\n" .. text -- Crafter books put the text immediately under the title

  elseif minetest.get_modpath("default") ~= nil then
    stackName_writtenBook = "default:book_written"

  else
    return nil
  end

  local book_itemstack = ItemStack(stackName_writtenBook)
  local book_data = {}
  book_data.title = title
  book_data.text  = text
  book_data.owner = author
  book_data.author = author
  book_data.description = description
  book_data.page = 1
  book_data.page_max = 1
  book_data.generation = 0
  book_data["book.book_title"] = title -- Crafter book title
  book_data["book.book_text"]  = text  -- Crafter book text

  book_itemstack:get_meta():from_table({fields = book_data})

  return book_itemstack
end

--[[==============================
              Portals
    ==============================]]--

local addDetail_ancientPortal = nil;

if ENABLE_PORTALS and minetest.get_modpath("nether") ~= nil and minetest.global_exists("nether") and nether.register_portal ~= nil then
  -- The Portals API is available
  -- Register a player-buildable portal to Hallelujah Mountains.


  -- returns a position on the island which is suitable for a portal to be placed, or nil if none can be found
  local function find_potential_portal_location_on_island(island_info)

    local result = nil

    if island_info ~= nil then
      local searchRadius = island_info.radius * 0.6 -- islands normally don't reach their full radius, and lets not put portals too near the edge
      local coreList = cloudlands.get_island_details(
        {x = island_info.x - searchRadius, z = island_info.z - searchRadius},
        {x = island_info.x + searchRadius, z = island_info.z + searchRadius}
      );

      -- Deterministically sample the island for a low location that isn't water.
      -- Seed the prng so this function always returns the same coords for the island
      local prng = PcgRandom(island_info.x * 65732 + island_info.z * 729 + minetest.get_mapgen_setting("seed") * 3)
      local positions = {}

      for attempt = 1, 15 do -- how many attempts we'll make at finding a good location
        local angle = (prng:next(0, 10000) / 10000) * 2 * PI
        local distance = math_sqrt(prng:next(0, 10000) / 10000) * searchRadius
        if attempt == 1 then distance = 0 end -- Always sample the middle of the island, as it's the safest fallback location
        local x = round(island_info.x + math_cos(angle) * distance)
        local z = round(island_info.z + math_sin(angle) * distance)
        local y, isWater = cloudlands.get_height_at(x, z, coreList)
        if y ~= nil then
          local weight = 0
          if not isWater                          then weight = weight + 1 end -- avoid putting portals in ponds
          if y >= island_info.y + ALTITUDE             then weight = weight + 2 end -- avoid putting portals down the sides of eroded cliffs
          positions[#positions + 1] = {x = x, y = y + 1, z = z, weight = weight}
        end
      end

      -- Order the locations by how good they are
      local compareFn = function(pos_a, pos_b)
        if pos_a.weight > pos_b.weight then return true end
        if pos_a.weight == pos_b.weight and pos_a.y < pos_b.y then return true end -- I can't justify why I think lower positions are better. I'm imagining portals nested in valleys rather than on ridges.
        return false
      end
      table.sort(positions, compareFn)

      -- Now the locations are sorted by how good they are, find the first/best that doesn't
      -- grief a player build.
      -- Ancient Portalstone has is_ground_content set to true, so we won't have to worry about
      -- old/broken portal frames interfering with the results of nether.volume_is_natural()
      for _, position in ipairs(positions) do
        -- Unfortunately, at this point we don't know the orientation of the portal, so use worst case
        local minp = {x = position.x - 2, y = position.y,     z = position.z - 2}
        local maxp = {x = position.x + 3, y = position.y + 4, z = position.z + 3}
        if nether.volume_is_natural(minp, maxp) then
          result = position
          break
        end
      end
    end

    return result
  end


  -- returns nil if no suitable location could be found, otherwise returns (portal_pos, island_info)
  local function find_nearest_island_location_for_portal(surface_x, surface_z)

    local result = nil

    local island = cloudlands.find_nearest_island(surface_x, surface_z, 75)
    if island == nil then island = cloudlands.find_nearest_island(surface_x, surface_z, 150) end
    if island == nil then island = cloudlands.find_nearest_island(surface_x, surface_z, 400) end

    if island ~= nil then
      result = find_potential_portal_location_on_island(island)
    end

    return result, island
  end

  -- Ideally the Nether mod will provide a block obtainable by exploring the Nether which is
  -- earmarked for mods like this one to use for portals, but until this happens I'll create
  -- our own tempory placeholder "portalstone".
  -- The Portals API is currently provided by nether, which depends on default, so we can assume default textures are available
  local portalstone_end = "default_furnace_top.png^(default_ice.png^[opacity:120)^[multiply:#668"  -- this gonna look bad with non-default texturepacks, hopefully Nether mod will provide a real block
  local portalstone_side = "[combine:16x16:0,0=default_furnace_top.png:4,0=default_furnace_top.png:8,0=default_furnace_top.png:12,0=default_furnace_top.png:^(default_ice.png^[opacity:120)^[multiply:#668"
  minetest.register_node("cloudlands:ancient_portalstone", {
    description = S("Ancient Portalstone"),
    tiles = {portalstone_end, portalstone_end, portalstone_side, portalstone_side, portalstone_side, portalstone_side},
    paramtype2 = "facedir",
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 1, level = 2},
    on_blast = function() --[[blast proof]] end
  })

  minetest.register_ore({
    ore_type       = "scatter",
    ore            = "cloudlands:ancient_portalstone",
    wherein        = "nether:rack",
    clust_scarcity = 28 * 28 * 28,
    clust_num_ores = 6,
    clust_size     = 3,
    y_max = nether.DEPTH,
    y_min = nether.DEPTH_FLOOR or -32000,
  })

  local _  = {name = "air",                                         prob = 0}
  local A  = {name = "air",                                         prob = 255, force_place = true}
  local PU = {name = "cloudlands:ancient_portalstone", param2 =  0, prob = 255, force_place = true}
  local PW = {name = "cloudlands:ancient_portalstone", param2 = 12, prob = 255, force_place = true}
  local PN = {name = "cloudlands:ancient_portalstone", param2 =  4, prob = 255, force_place = true}
  minetest.register_decoration({
    name = "Ancient broken portal",
    deco_type = "schematic",
    place_on = "nether:rack",
    sidelen = 80,
    fill_ratio = 0.0003,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH,
    y_min = nether.DEPTH_FLOOR or -32000,
    schematic = {
      size = {x = 4, y = 4, z = 1},
      data = {
          PN, A, PW, PN,
          PU, A,  A, PU,
          A,  _,  _, PU,
          _,  _,  _, PU
      },
      yslice_prob = {
          {ypos = 3, prob = 92},
          {ypos = 1, prob = 30},
      }
    },
    place_offset_y = 1,
    flags = "force_placement,all_floors",
    rotation = "random"
  })

  -- this uses place_schematic() without minetest.after(), so should be called after vm:write_to_map()
  addDetail_ancientPortal = function(core)

    if (core.radius < 8 or PORTAL_RARITY == 0) then return false end -- avoid portals hanging off the side of small islands

    local fastHash = 3
    fastHash = (37 * fastHash) + 9354 -- to keep this probability distinct from reefs and atols
    fastHash = (37 * fastHash) + ISLANDS_SEED
    fastHash = (37 * fastHash) + core.x
    fastHash = (37 * fastHash) + core.z
    fastHash = (37 * fastHash) + math_floor(core.radius)
    fastHash = (37 * fastHash) + math_floor(core.depth)
    if (PORTAL_RARITY * 10000) < math_floor((math_abs(fastHash)) % 10000) then return false end

    local portalPos = find_potential_portal_location_on_island(core)

    if portalPos ~= nil then
      local orientation = (fastHash % 2) * 90
      portalPos.y = portalPos.y - ((core.x + core.z) % 3) -- partially bury some ancient portals

      minetest.place_schematic(
        portalPos,
        {
          size = {x = 4, y = 5, z = 1},
          data = {
              PN, PW, PW, PN,
              PU,  _,  _, PU,
              PU,  _,  _, PU,
              PU,  _,  _, PU,
              PN, PW, PW, PN
          },
        },
        orientation,
        { -- node replacements
          ["default:obsidian"] = "cloudlands:ancient_portalstone",
        },
        true
      )
    end
  end


  nether.register_portal("cloudlands_portal", {
    shape               = nether.PortalShape_Traditional,
    frame_node_name     = "cloudlands:ancient_portalstone",
    wormhole_node_color = 2, -- 2 is blue
    particle_color      = "#77F",
    particle_texture    = {
      name      = "nether_particle_anim1.png",
      animation = {
        type = "vertical_frames",
        aspect_w = 7,
        aspect_h = 7,
        length = 1,
      },
      scale = 1.5
    },
    title = S("Cloudlands Portal"),
    book_of_portals_pagetext =
      S("Construction requires 14 blocks of ancient portalstone. We have no knowledge of how portalstones were created, the means to craft them are likely lost to time, so our only source has been to scavenge the Nether for the remnants of ancient broken portals. A finished frame is four blocks wide, five blocks high, and stands vertically, like a doorway.") .. "\n\n" ..
      S("The only portal we managed to scavenge enough portalstone to build took us to a land of floating islands. There were hills and forests and even water up there, but the edges are a perilous drop — a depth of which we cannot even begin to plumb."),

    is_within_realm = function(pos)
      -- return true if pos is in the cloudlands
      -- I'm doing this based off height for speed, so it sometimes gets it wrong when the
      -- Hallelujah mountains start reaching the ground.
      local largestCoreType  = cloudlands.coreTypes[1] -- the first island type is the biggest/thickest
      local island_bottom = ALTITUDE - (largestCoreType.depthMax * 0.66) + round(noise_heightMap:get2d({x = pos.x, y = pos.z}))
      return pos.y > math_max(40, island_bottom)
    end,

    find_realm_anchorPos = function(surface_anchorPos)
      -- Find the nearest island and obtain a suitable surface position on it
      local destination_pos, island = find_nearest_island_location_for_portal(surface_anchorPos.x, surface_anchorPos.z)

      if island ~= nil then
        -- Allow any existing or player-positioned portal on the island to be linked to
        -- first before resorting to the island's default portal position
        local existing_portal_location, existing_portal_orientation = nether.find_nearest_working_portal(
          "cloudlands_portal",
          {x = island.x, y = 100000, z = island.z}, -- Using 100000 for y to ensure the position is in the cloudlands realm and so find_nearest_working_portal() will only returns island portals.
          island.radius * 0.9,                      -- Islands normally don't reach their full radius. Ensure this distance limit encompasses any location find_nearest_island_location_for_portal() can return.
          0 -- a y_factor of 0 makes the search ignore the altitude of the portals (as long as they are in the Cloudlands realm)
        )
        if existing_portal_location ~= nil then
          return existing_portal_location, existing_portal_orientation
        end
      end

      return destination_pos
    end,

    find_surface_anchorPos = function(realm_anchorPos)
      -- This function isn't needed since find_surface_target_y() will be used by default,
      -- but by implementing it I can look for any existing nearby portals before falling
      -- back to find_surface_target_y.

      -- Using -100000 for y to ensure the position is outside the cloudlands realm and so
      -- find_nearest_working_portal() will only returns ground portals.
      -- a y_factor of 0 makes the search ignore the -100000 altitude of the portals (as
      -- long as they are outside the cloudlands realm)
      local existing_portal_location, existing_portal_orientation =
        nether.find_nearest_working_portal("cloudlands_portal", {x = realm_anchorPos.x, y = -100000, z = realm_anchorPos.z}, 150, 0)

      if existing_portal_location ~= nil then
        return existing_portal_location, existing_portal_orientation
      else
        local y = nether.find_surface_target_y(realm_anchorPos.x, realm_anchorPos.z, "cloudlands_portal")
        return {x = realm_anchorPos.x, y = y, z = realm_anchorPos.z}
      end
    end,

    on_ignite = function(portalDef, anchorPos, orientation)
      -- make some sparks fly on ignition
      local p1, p2 = portalDef.shape:get_p1_and_p2_from_anchorPos(anchorPos, orientation)
      local pos = vector.divide(vector.add(p1, p2), 2)

      local textureName = portalDef.particle_texture
      if type(textureName) == "table" then textureName = textureName.name end

      local velocity
      if orientation == 0 then
        velocity = {x = 0, y = 0, z = 7}
      else
        velocity = {x = 7, y = 0, z = 0}
      end

      local particleSpawnerDef = {
        amount = 180,
        time   = 0.15,
        minpos = {x = pos.x - 1, y = pos.y - 1.5, z = pos.z - 1},
        maxpos = {x = pos.x + 1, y = pos.y + 1.5, z = pos.z + 1},
        minvel = velocity,
        maxvel = velocity,
        minacc = {x =  0, y =  0, z =  0},
        maxacc = {x =  0, y =  0, z =  0},
        minexptime = 0.1,
        maxexptime = 0.5,
        minsize = 0.3 * portalDef.particle_texture_scale,
        maxsize = 0.8 * portalDef.particle_texture_scale,
        collisiondetection = false,
        texture = textureName .. "^[colorize:#99F:alpha",
        animation = portalDef.particle_texture_animation,
        glow = 8
      }

      minetest.add_particlespawner(particleSpawnerDef)

      velocity = vector.multiply(velocity, -1);
      particleSpawnerDef.minvel, particleSpawnerDef.maxvel = velocity, velocity
      minetest.add_particlespawner(particleSpawnerDef)
    end

  })
end



--[[==============================
       Initialization and Mapgen
    ==============================]]--

local function init_mapgen()
  -- invoke get_perlin() here, since it can't be invoked before the environment
  -- is created because it uses the world's seed value.
  noise_eddyField  = minetest.get_perlin(noiseparams_eddyField)
  noise_heightMap  = minetest.get_perlin(noiseparams_heightMap)
  noise_density    = minetest.get_perlin(noiseparams_density)
  noise_surfaceMap = minetest.get_perlin(noiseparams_surfaceMap)
  noise_skyReef    = minetest.get_perlin(noiseparams_skyReef)

  local prng = PcgRandom(122456 + ISLANDS_SEED)
  for i = 0,255 do randomNumbers[i] = prng:next(0, 0x10000) / 0x10000 end

  if isMapgenV6 then
    biomes["Normal"] = {node_top="mapgen_dirt_with_grass", node_filler="mapgen_dirt",        node_stone="mapgen_stone"}
    biomes["Desert"] = {node_top="mapgen_desert_sand",     node_filler="mapgen_desert_sand", node_stone="mapgen_desert_stone"}
    biomes["Jungle"] = {node_top="mapgen_dirt_with_grass", node_filler="mapgen_dirt",        node_stone="mapgen_stone"}
    biomes["Tundra"] = {node_top="mapgen_dirt_with_snow",  node_filler="mapgen_dirt",        node_stone="mapgen_stone"}
    biomes["Taiga"]  = {node_top="mapgen_dirt_with_snow",  node_filler="mapgen_dirt",        node_stone="mapgen_stone"}
  else
    for k,v in pairs(minetest.registered_biomes) do
      biomes[minetest.get_biome_id(k)] = v;
    end
  end
  if DEBUG then minetest.log("info", "registered biomes: " .. dump(biomes)) end

  nodeId_air      = minetest.get_content_id("air")

  nodeId_stone    = interop.find_node_id(NODENAMES_STONE)
  nodeId_grass    = interop.find_node_id(NODENAMES_GRASS)
  nodeId_dirt     = interop.find_node_id(NODENAMES_DIRT)
  nodeId_water    = interop.find_node_id(NODENAMES_WATER)
  nodeId_ice      = interop.find_node_id(NODENAMES_ICE)
  nodeId_silt     = interop.find_node_id(NODENAMES_SILT)
  nodeId_gravel   = interop.find_node_id(NODENAMES_GRAVEL)
  nodeId_vine     = interop.find_node_id(NODENAMES_VINES)
  nodeName_vine   = minetest.get_name_from_content_id(nodeId_vine)

  local regionRectStr = minetest.settings:get(MODNAME .. "_limit_rect")
  if type(regionRectStr) == "string" then
    local minXStr, minZStr, maxXStr, maxZStr = string.match(regionRectStr, '(-?[%d%.]+)[,%s]+(-?[%d%.]+)[,%s]+(-?[%d%.]+)[,%s]+(-?[%d%.]+)')
    if minXStr ~= nil then
      local minX, minZ, maxX, maxZ = tonumber(minXStr), tonumber(minZStr), tonumber(maxXStr), tonumber(maxZStr)
      if minX ~= nil and maxX ~= nil and minX < maxX then
        region_min_x, region_max_x = minX, maxX
      end
      if minZ ~= nil and maxZ ~= nil and minZ < maxZ then
        region_min_z, region_max_z = minZ, maxZ
      end
    end
  end

  local limitToBiomesStr = minetest.settings:get(MODNAME .. "_limit_biome")
  if type(limitToBiomesStr) == "string" and string.len(limitToBiomesStr) > 0 then
    limit_to_biomes = limitToBiomesStr:lower()
  end
  limit_to_biomes_altitude = tonumber(minetest.settings:get(MODNAME .. "_limit_biome_altitude"))

  region_restrictions =
    region_min_x > -32000 or region_min_z > -32000
    or region_max_x < 32000 or region_max_z < 32000
    or limit_to_biomes ~= nil
end

-- Updates coreList to include all cores of type coreType within the given bounds
local function addCores(coreList, coreType, x1, z1, x2, z2)

  -- this function is used by the API functions, so may be invoked without our on_generated
  -- being called
  cloudlands.init();

  for z = math_floor(z1 / coreType.territorySize), math_floor(z2 / coreType.territorySize) do
    for x = math_floor(x1 / coreType.territorySize), math_floor(x2 / coreType.territorySize) do

      -- Use a known PRNG implementation, to make life easier for Amidstest
      local prng = PcgRandom(
        x * 8973896 +
        z * 7467838 +
        worldSeed + 8438 + ISLANDS_SEED
      )

      local coresInTerritory = {}

      for i = 1, coreType.coresPerTerritory do
        local coreX = x * coreType.territorySize + prng:next(0, coreType.territorySize - 1)
        local coreZ = z * coreType.territorySize + prng:next(0, coreType.territorySize - 1)

        -- there's strong vertical and horizontal tendency in 2-octave noise,
        -- so rotate it a little to avoid it lining up with the world axis.
        local noiseX = ROTATE_COS * coreX - ROTATE_SIN * coreZ
        local noiseZ = ROTATE_SIN * coreX + ROTATE_COS * coreZ
        local eddyField = noise_eddyField:get2d({x = noiseX, y = noiseZ})

        if (math_abs(eddyField) < coreType.frequency) then

          local nexusConditionMet = not coreType.requiresNexus
          if not nexusConditionMet then
            -- A 'nexus' is a made up name for a place where the eddyField is flat.
            -- There are often many 'field lines' leading out from a nexus.
            -- Like a saddle in the perlin noise the height "coreType.frequency"
            local eddyField_orthA = noise_eddyField:get2d({x = noiseX + 2, y = noiseZ})
            local eddyField_orthB = noise_eddyField:get2d({x = noiseX, y = noiseZ + 2})
            if math_abs(eddyField - eddyField_orthA) + math_abs(eddyField - eddyField_orthB) < 0.02 then
              nexusConditionMet = true
            end
          end

          if nexusConditionMet then
            local radius     = (coreType.radiusMax + prng:next(0, coreType.radiusMax) * 2) / 3 -- give a 33%/66% weighting split between max-radius and random
            local depth      = (coreType.depthMax  + prng:next(0, coreType.depthMax)  * 2) / 2 -- ERROR!! fix this bug! should be dividing by 3. But should not change worldgen now, so adjust depthMax of islands so nothing changes when bug is fixed?
            local thickness  = prng:next(0, coreType.thicknessMax)


            if coreX >= x1 and coreX < x2 and coreZ >= z1 and coreZ < z2 then

              local spaceConditionMet = not coreType.exclusive
              if not spaceConditionMet then
                -- see if any other cores occupy this space, and if so then
                -- either deny the core, or raise it
                spaceConditionMet = true
                local minDistSquared = radius * radius * .7

                for _,core in ipairs(coreList) do
                  if core.type.radiusMax == coreType.radiusMax then
                    -- We've reached the cores of the current type. We can't exclude based on all
                    -- cores of the same type as we can't be sure neighboring territories will have been generated.
                    break
                  end
                  if (core.x - coreX)*(core.x - coreX) + (core.z - coreZ)*(core.z - coreZ) <= minDistSquared + core.radius * core.radius then
                    spaceConditionMet = false
                    break
                  end
                end
                if spaceConditionMet then
                  for _,core in ipairs(coresInTerritory) do
                    -- We can assume all cores of the current type are being generated in this territory,
                    -- so we can exclude the core if it overlaps one already in this territory.
                    if (core.x - coreX)*(core.x - coreX) + (core.z - coreZ)*(core.z - coreZ) <= minDistSquared + core.radius * core.radius then
                      spaceConditionMet = false
                      break
                    end
                  end
                end;
              end

              if spaceConditionMet then
                -- all conditions met, we've located a new island core
                --minetest.log("Adding core "..x..","..y..","..z..","..radius);
                local y = round(noise_heightMap:get2d({x = coreX, y = coreZ}))
                local newCore = {
                  x         = coreX,
                  y         = y,
                  z         = coreZ,
                  radius    = radius,
                  thickness = thickness,
                  depth     = depth,
                  type      = coreType,
                }
                coreList[#coreList + 1] = newCore
                coresInTerritory[#coreList + 1] = newCore
              end

            else
              -- We didn't test coreX,coreZ against x1,z1,x2,z2 immediately and save all
              -- that extra work, as that would break the determinism of the prng calls.
              -- i.e. if the area was approached from a different direction then a
              -- territory might end up with a different list of cores.
              -- TODO: filter earlier but advance prng?
            end
          end
        end
      end
    end
  end
end


-- removes any islands that fall outside region restrictions specified in the options
local function removeUnwantedIslands(coreList)

  local testBiome = limit_to_biomes ~= nil
  local get_biome_name = nil
  if testBiome then
    -- minetest.get_biome_name() was added in March 2018, we'll ignore the
    -- limit_to_biomes option on versions of Minetest that predate this
    get_biome_name = minetest.get_biome_name
    testBiome = get_biome_name ~= nil
    if get_biome_name == nil then
      minetest.log("warning", MODNAME .. " ignoring " .. MODNAME .. "_limit_biome option as Minetest API version too early to support get_biome_name()")
      limit_to_biomes = nil
    end
  end

  for i = #coreList, 1, -1 do
    local core = coreList[i]
    local coreX = core.x
    local coreZ = core.z

    if coreX < region_min_x or coreX > region_max_x or coreZ < region_min_z or coreZ > region_max_z then
      table.remove(coreList, i)

    elseif testBiome then
      local biomeAltitude
      if (limit_to_biomes_altitude == nil) then biomeAltitude = ALTITUDE + core.y else biomeAltitude = limit_to_biomes_altitude end

      local biomeName = get_biome_name(minetest.get_biome_data({x = coreX, y = biomeAltitude, z = coreZ}).biome)
      if not string.match(limit_to_biomes, biomeName:lower()) then
        table.remove(coreList, i)
      end
    end
  end
end


-- gets an array of all cores which may intersect the (minp, maxp) area
-- y is ignored
cloudlands.get_island_details = function(minp, maxp)
  local result = {}

  for _,coreType in pairs(cloudlands.coreTypes) do
    addCores(
      result,
      coreType,
      minp.x - coreType.radiusMax,
      minp.z - coreType.radiusMax,
      maxp.x + coreType.radiusMax,
      maxp.z + coreType.radiusMax
    )
  end

  -- remove islands only after cores have all generated to avoid the restriction
  -- settings from rearranging islands.
  if region_restrictions then removeUnwantedIslands(result) end

  return result;
end


cloudlands.find_nearest_island = function(x, z, search_radius)

  local coreList = {}
  for _,coreType in pairs(cloudlands.coreTypes) do
    addCores(
      coreList,
      coreType,
      x - (search_radius + coreType.radiusMax),
      z - (search_radius + coreType.radiusMax),
      x + (search_radius + coreType.radiusMax),
      z + (search_radius + coreType.radiusMax)
    )
  end
  -- remove islands only after cores have all generated to avoid the restriction
  -- settings from rearranging islands.
  if region_restrictions then removeUnwantedIslands(coreList) end

  local result = nil
  for _,core in ipairs(coreList) do
    local distance = math.hypot(core.x - x, core.z - z)
    if distance >= core.radius then
      core.distance = 1 + distance - core.radius
    else
      -- distance is fractional
      core.distance = distance / (core.radius + 1)
    end

    if result == nil or core.distance < result.distance then result = core end
  end

  return result;
end


-- coreList can be left as null, but if you wish to sample many heights in a small area
-- then use cloudlands.get_island_details() to get the coreList for that area and save
-- having to recalculate it during each call to get_height_at().
cloudlands.get_height_at = function(x, z, coreList)

  local result, isWater = nil, false;

  if coreList == nil then
    local pos = {x = x, z = z}
    coreList = cloudlands.get_island_details(pos, pos)
  end

  for _,core in ipairs(coreList) do

    -- duplicates the code from renderCores() to find surface height
    -- See the renderCores() version for explanatory comments
    local horz_easing
    local distanceSquared = (x - core.x)*(x - core.x) + (z - core.z)*(z - core.z)
    local radiusSquared = core.radius * core.radius

    local noise_weighting = 1
    local shapeType = math_floor(core.depth + core.radius + core.x) % 5
    if shapeType < 2 then -- convex, see renderCores() implementatin for comments
      horz_easing = 1 - distanceSquared / radiusSquared
    elseif shapeType == 2 then -- conical, see renderCores() implementatin for comments
      horz_easing = 1 - math_sqrt(distanceSquared) / core.radius
    else -- concave, see renderCores() implementatin for comments
      local radiusRoot = math_sqrt(core.radius)
      local squared  = 1 - distanceSquared / radiusSquared
      local distance = math_sqrt(distanceSquared)
      local distance_normalized = distance / core.radius
      local root = 1 - math_sqrt(distance) / radiusRoot
      horz_easing = math_min(1, 0.8*distance_normalized*squared + 1.2*(1-distance_normalized)*root)
      noise_weighting = 0.63
    end
    if core.radius + core.depth > 80  then noise_weighting = 0.6  end
    if core.radius + core.depth > 120 then noise_weighting = 0.35 end

    local surfaceNoise = noise_surfaceMap:get2d({x = x, y = z})
    if DEBUG_GEOMETRIC then surfaceNoise = SURFACEMAP_OFFSET end
    local coreTop = ALTITUDE + core.y
    local surfaceHeight = coreTop + round(surfaceNoise * 3 * (core.thickness + 1) * horz_easing)

    if result == nil or math_max(coreTop, surfaceHeight) > result then

      local coreBottom = math_floor(coreTop - (core.thickness + core.depth))
      local yBottom = coreBottom
      if result ~= nil then yBottom = math_max(yBottom, result + 1) end

      for y = math_max(coreTop, surfaceHeight), yBottom, -1 do
        local vert_easing = math_min(1, (y - coreBottom) / core.depth)

        local densityNoise = noise_density:get3d({x = x, y = y - coreTop, z = z})
        densityNoise = noise_weighting * densityNoise + (1 - noise_weighting) * DENSITY_OFFSET
        if DEBUG_GEOMETRIC then densityNoise = DENSITY_OFFSET end

        if densityNoise * ((horz_easing + vert_easing) / 2) >= REQUIRED_DENSITY then
          result = y
          isWater = surfaceNoise < 0
          break

          --[[abandoned because do we need to calc the bottom of ponds? It also needs the outer code refactored to work
          if not isWater then
            -- we've found the land height
            break
          else
            -- find the pond bottom, since the water level is already given by (ALTITUDE + island.y)
            local surfaceDensity = densityNoise * ((horz_easing + 1) / 2)
            local onTheEdge = math_sqrt(distanceSquared) + 1 >= core.radius
            if onTheEdge or surfaceDensity > (REQUIRED_DENSITY + core.type.pondWallBuffer) then
              break
            end
          end]]
        end
      end
    end
  end

  return result, isWater
end


local function setCoreBiomeData(core)
  local pos = {x = core.x, y = ALTITUDE + core.y, z = core.z}
  if LOWLAND_BIOMES then pos.y = LOWLAND_BIOME_ALTITUDE end
  core.biomeId     = interop.get_biome_key(pos)
  core.biome       = biomes[core.biomeId]
  core.temperature = get_heat(pos)
  core.humidity    = get_humidity(pos)

  if core.temperature == nil then core.temperature = 50 end
  if core.humidity    == nil then core.humidity    = 50 end

  if core.biome == nil then
    -- Some games don't use the biome list, so come up with some fallbacks
    core.biome = {}
    core.biome.node_top    = minetest.get_name_from_content_id(nodeId_grass)
    core.biome.node_filler = minetest.get_name_from_content_id(nodeId_dirt)
  end

end

local function addDetail_vines(decoration_list, core, data, area, minp, maxp)

  if VINE_COVERAGE > 0 and nodeId_vine ~= nodeId_ignore then

    local y = ALTITUDE + core.y
    if y >= minp.y and y <= maxp.y then
      -- if core.biome is nil then renderCores() never rendered it, which means it
      -- doesn't instersect this draw region.
      if core.biome ~= nil and core.humidity >= VINES_REQUIRED_HUMIDITY and core.temperature >= VINES_REQUIRED_TEMPERATURE then

        local nodeId_top
        local nodeId_filler
        local nodeId_stoneBase
        local nodeId_dust
        if core.biome.node_top    == nil then nodeId_top       = nodeId_stone  else nodeId_top       = minetest.get_content_id(core.biome.node_top)    end
        if core.biome.node_filler == nil then nodeId_filler    = nodeId_stone  else nodeId_filler    = minetest.get_content_id(core.biome.node_filler) end
        if core.biome.node_stone  == nil then nodeId_stoneBase = nodeId_stone  else nodeId_stoneBase = minetest.get_content_id(core.biome.node_stone)  end
        if core.biome.node_dust   == nil then nodeId_dust      = nodeId_stone  else nodeId_dust      = minetest.get_content_id(core.biome.node_dust)   end

        local function isIsland(nodeId)
          return (nodeId == nodeId_filler    or nodeId == nodeId_top
               or nodeId == nodeId_stoneBase or nodeId == nodeId_dust
               or nodeId == nodeId_silt      or nodeId == nodeId_water)
        end

        local function findHighestNodeFace(y, solidIndex, emptyIndex)
          -- return the highest y value (or maxp.y) where solidIndex is part of an island
          -- and emptyIndex is not
          local yOffset = 1
          while y + yOffset <= maxp.y and isIsland(data[solidIndex + yOffset * area.ystride]) and not isIsland(data[emptyIndex + yOffset * area.ystride]) do
            yOffset = yOffset + 1
          end
          return y + yOffset - 1
        end

        local radius = round(core.radius)
        local xCropped = math_min(maxp.x, math_max(minp.x, core.x))
        local zStart = math_max(minp.z, core.z - radius)
        local vi = area:index(xCropped, y, zStart)

        for z = 0, math_min(maxp.z, core.z + radius) - zStart do
          local searchIndex = vi + z * area.zstride
          if isIsland(data[searchIndex]) then

            -- add vines to east face
            if randomNumbers[(zStart + z + y) % 256] <= VINE_COVERAGE then
              for x = xCropped + 1, maxp.x do
                if not isIsland(data[searchIndex + 1]) then
                  local yhighest = findHighestNodeFace(y, searchIndex, searchIndex + 1)
                  decoration_list[#decoration_list + 1] = {pos={x=x, y=yhighest, z= zStart + z}, node={name = nodeName_vine, param2 = 3}}
                  break
                end
                searchIndex = searchIndex + 1
              end
            end
            -- add vines to west face
            if randomNumbers[(zStart + z + y + 128) % 256] <= VINE_COVERAGE then
              searchIndex = vi + z * area.zstride
              for x = xCropped - 1, minp.x, -1 do
                if not isIsland(data[searchIndex - 1]) then
                  local yhighest = findHighestNodeFace(y, searchIndex, searchIndex - 1)
                  decoration_list[#decoration_list + 1] = {pos={x=x, y=yhighest, z= zStart + z}, node={name = nodeName_vine, param2 = 2}}
                  break
                end
                searchIndex = searchIndex - 1
              end
            end
          end
        end

        local zCropped = math_min(maxp.z, math_max(minp.z, core.z))
        local xStart = math_max(minp.x, core.x - radius)
        local zstride = area.zstride
        vi = area:index(xStart, y, zCropped)

        for x = 0, math_min(maxp.x, core.x + radius) - xStart do
          local searchIndex = vi + x
          if isIsland(data[searchIndex]) then

            -- add vines to north face (make it like moss - grows better on the north side)
            if randomNumbers[(xStart + x + y) % 256] <= (VINE_COVERAGE * 1.2) then
              for z = zCropped + 1, maxp.z do
                if not isIsland(data[searchIndex + zstride]) then
                  local yhighest = findHighestNodeFace(y, searchIndex, searchIndex + zstride)
                  decoration_list[#decoration_list + 1] = {pos={x=xStart + x, y=yhighest, z=z}, node={name = nodeName_vine, param2 = 5}}
                  break
                end
                searchIndex = searchIndex + zstride
              end
            end
            -- add vines to south face (make it like moss - grows better on the north side)
            if randomNumbers[(xStart + x + y + 128) % 256] <= (VINE_COVERAGE * 0.8) then
              searchIndex = vi + x
              for z = zCropped - 1, minp.z, -1 do
                if not isIsland(data[searchIndex - zstride]) then
                  local yhighest = findHighestNodeFace(y, searchIndex, searchIndex - zstride)
                  decoration_list[#decoration_list + 1] = {pos={x=xStart + x, y=yhighest, z=z}, node={name = nodeName_vine, param2 = 4}}
                  break
                end
                searchIndex = searchIndex - zstride
              end
            end
          end
        end

      end
    end
  end
end


-- A rare formation of rocks circling or crowning an island
-- returns true if voxels were changed
local function addDetail_skyReef(decoration_list, core, data, area, minp, maxp)

  local coreTop          = ALTITUDE + core.y
  local overdrawTop      = maxp.y + OVERDRAW
  local reefAltitude     = math_floor(coreTop - 1 - core.thickness / 2)
  local reefMaxHeight    = 12
  local reefMaxUnderhang = 4

  if (maxp.y < reefAltitude - reefMaxUnderhang) or (minp.y > reefAltitude + reefMaxHeight) then
    --no reef here
    return false
  end

  local isReef  = core.radius < core.type.radiusMax * 0.4 -- a reef can't extend beyond radiusMax, so needs a small island
  local isAtoll = core.radius > core.type.radiusMax * 0.8
  if not (isReef or isAtoll) then return false end

  local fastHash = 3
  fastHash = (37 * fastHash) + core.x
  fastHash = (37 * fastHash) + core.z
  fastHash = (37 * fastHash) + math_floor(core.radius)
  fastHash = (37 * fastHash) + math_floor(core.depth)
  if ISLANDS_SEED ~= 1000 then fastHash = (37 * fastHash) + ISLANDS_SEED end
  local rarityAdj = 1
  if core.type.requiresNexus and isAtoll then rarityAdj = 4 end -- humongous islands are very rare, and look good as an atoll
  if (REEF_RARITY * rarityAdj * 1000) < math_floor((math_abs(fastHash)) % 1000) then return false end

  local coreX = core.x --save doing a table lookup in the loop
  local coreZ = core.z --save doing a table lookup in the loop

  -- Use a known PRNG implementation
  local prng = PcgRandom(
    coreX * 8973896 +
    coreZ * 7467838 +
    worldSeed + 32564
  )

  local reefUnderhang
  local reefOuterRadius = math_floor(core.type.radiusMax)
  local reefInnerRadius = prng:next(core.type.radiusMax * 0.5, core.type.radiusMax * 0.7)
  local reefWidth       = reefOuterRadius - reefInnerRadius
  local noiseOffset     = 0

  if isReef then
    reefMaxHeight   = round((core.thickness + 4) / 2)
    reefUnderhang   = round(reefMaxHeight / 2)
    noiseOffset     = -0.1
  end
  if isAtoll then
    -- a crown attached to the island
    reefOuterRadius = math_floor(core.radius * 0.8)
    reefWidth       = math_max(4, math_floor(core.radius * 0.15))
    reefInnerRadius = reefOuterRadius - reefWidth
    reefUnderhang   = 0
    if maxp.y < reefAltitude - reefUnderhang then return end -- no atoll here
  end

  local reefHalfWidth           = reefWidth / 2
  local reefMiddleRadius        = (reefInnerRadius + reefOuterRadius) / 2
  local reefOuterRadiusSquared  = reefOuterRadius  * reefOuterRadius
  local reefInnerRadiusSquared  = reefInnerRadius  * reefInnerRadius
  local reefMiddleRadiusSquared = reefMiddleRadius * reefMiddleRadius
  local reefHalfWidthSquared    = reefHalfWidth    * reefHalfWidth

  -- get the biome details for this core
  local nodeId_first
  local nodeId_second
  local nodeId_top
  local nodeId_filler
  if core.biome == nil then setCoreBiomeData(core) end -- We can't assume the core biome has already been resolved, core might not have been big enough to enter the draw region
  if core.biome.node_top    == nil then nodeId_top    = nodeId_stone  else nodeId_top       = minetest.get_content_id(core.biome.node_top)    end
  if core.biome.node_filler == nil then nodeId_filler = nodeId_stone  else nodeId_filler    = minetest.get_content_id(core.biome.node_filler) end
  if core.biome.node_dust   ~= nil then
    nodeId_first  = minetest.get_content_id(core.biome.node_dust)
    nodeId_second = nodeId_top
  else
    nodeId_first  = nodeId_top
    nodeId_second = nodeId_filler
  end

  local zStart  = round(math_max(core.z - reefOuterRadius, minp.z))
  local zStop   = round(math_min(core.z + reefOuterRadius, maxp.z))
  local xStart  = round(math_max(core.x - reefOuterRadius, minp.x))
  local xStop   = round(math_min(core.x + reefOuterRadius, maxp.x))
  local yCenter = math_min(math_max(reefAltitude, minp.y), maxp.y)
  local pos = {}

  local dataBufferIndex = area:index(xStart, yCenter, zStart)
  local vi = -1
  for z = zStart, zStop do
    local zDistSquared = (z - coreZ) * (z - coreZ)
    pos.y = z
    for x = xStart, xStop do
      local distanceSquared = (x - coreX) * (x - coreX) + zDistSquared
      if distanceSquared < reefOuterRadiusSquared and distanceSquared > reefInnerRadiusSquared then
        pos.x = x
        local offsetEase = math_abs(distanceSquared - reefMiddleRadiusSquared) / reefHalfWidthSquared
        local fineNoise = noise_skyReef:get2d(pos)
        local reefNoise = (noiseOffset* offsetEase) + fineNoise + 0.2 * noise_surfaceMap:get2d(pos)

        if (reefNoise > 0) then
          local distance = math_sqrt(distanceSquared)
          local ease = 1 - math_abs(distance - reefMiddleRadius) / reefHalfWidth
          local yStart = math_max(math_floor(reefAltitude - ease * fineNoise * reefUnderhang), minp.y)
          local yStop  = math_min(math_floor(reefAltitude + ease * reefNoise * reefMaxHeight), overdrawTop)

          for y = yStart, yStop do
            vi = dataBufferIndex + (y - yCenter) * area.ystride
            if data[vi] == nodeId_air then
              if y == yStop then
                data[vi] = nodeId_first
              elseif y == yStop - 1 then
                data[vi] = nodeId_second
              else
                data[vi] = nodeId_filler
              end
            end
          end
        end
      end
      dataBufferIndex = dataBufferIndex + 1
    end
    dataBufferIndex = dataBufferIndex + area.zstride - (xStop - xStart + 1)
  end

  return vi >= 0
end


local function renderCores(cores, minp, maxp, blockseed)

  local voxelsWereManipulated = false

  local vm, emerge_min, emerge_max = minetest.get_mapgen_object("voxelmanip")
  vm:get_data(data)        -- put all nodes except the ground surface in this array
  local area = VoxelArea:new{MinEdge=emerge_min, MaxEdge=emerge_max}
  local overdrawTop = maxp.y + OVERDRAW

  local currentBiomeId = -1
  local nodeId_dust
  local nodeId_top
  local nodeId_filler
  local nodeId_stoneBase
  local nodeId_pondBottom
  local depth_top
  local depth_filler
  local fillerFallsWithGravity
  local floodableDepth

  for z = minp.z, maxp.z do

    local dataBufferIndex = area:index(minp.x, minp.y, z)
    for x = minp.x, maxp.x do
      for _,core in pairs(cores) do
        local coreTop = ALTITUDE + core.y

        local distanceSquared = (x - core.x)*(x - core.x) + (z - core.z)*(z - core.z)
        local radius        = core.radius
        local radiusSquared = radius * radius

        if distanceSquared <= radiusSquared then

          -- get the biome details for this core
          if core.biome == nil then setCoreBiomeData(core) end
          if currentBiomeId ~= core.biomeId then
            if core.biome.node_top      == nil then nodeId_top        = nodeId_stone  else nodeId_top        = minetest.get_content_id(core.biome.node_top)      end
            if core.biome.node_filler   == nil then nodeId_filler     = nodeId_stone  else nodeId_filler     = minetest.get_content_id(core.biome.node_filler)   end
            if core.biome.node_stone    == nil then nodeId_stoneBase  = nodeId_stone  else nodeId_stoneBase  = minetest.get_content_id(core.biome.node_stone)    end
            if core.biome.node_dust     == nil then nodeId_dust       = nodeId_ignore else nodeId_dust       = minetest.get_content_id(core.biome.node_dust)     end
            if core.biome.node_riverbed == nil then nodeId_pondBottom = nodeId_silt   else nodeId_pondBottom = minetest.get_content_id(core.biome.node_riverbed) end

            if core.biome.depth_top    == nil then depth_top    = 1 else depth_top    = core.biome.depth_top    end
            if core.biome.depth_filler == nil then depth_filler = 3 else depth_filler = core.biome.depth_filler end
            fillerFallsWithGravity = core.biome.node_filler ~= nil and minetest.registered_items[core.biome.node_filler].groups.falling_node == 1

            --[[Commented out as unnecessary, as a supporting node will be added, but uncommenting
                this will make the strata transition less noisey.
            if fillerFallsWithGravity then
              -- the filler node is affected by gravity and can fall if unsupported, so keep that layer thinner than
              -- core.thickness when possible.
              --depth_filler = math_min(depth_filler, math_max(1, core.thickness - 1))
            end--]]

            floodableDepth = 0
            if nodeId_top ~= nodeId_stone and minetest.registered_items[core.biome.node_top].floodable then
              -- nodeId_top is a node that water floods through, so we can't have ponds appearing at this depth
              floodableDepth = depth_top
            end

            currentBiomeId = core.biomeId
          end

          -- decide on a shape
          local horz_easing
          local noise_weighting = 1
          local shapeType = math_floor(core.depth + radius + core.x) % 5
          if shapeType < 2 then
            -- convex
            -- squared easing function, e = 1 - x²
            horz_easing = 1 - distanceSquared / radiusSquared
          elseif shapeType == 2 then
            -- conical
            -- linear easing function, e = 1 - x
            horz_easing = 1 - math_sqrt(distanceSquared) / radius
          else
            -- concave
            -- root easing function blended/scaled with square easing function,
            -- x = normalised distance from center of core
            -- a = 1 - x²
            -- b = 1 - √x
            -- e = 0.8*a*x + 1.2*b*(1 - x)

            local radiusRoot = core.radiusRoot
            if radiusRoot == nil then
              radiusRoot = math_sqrt(radius)
              core.radiusRoot = radiusRoot
            end

            local squared  = 1 - distanceSquared / radiusSquared
            local distance = math_sqrt(distanceSquared)
            local distance_normalized = distance / radius
            local root = 1 - math_sqrt(distance) / radiusRoot
            horz_easing = math_min(1, 0.8*distance_normalized*squared + 1.2*(1-distance_normalized)*root)

            -- this seems to be a more delicate shape that gets wiped out by the
            -- density noise, so lower that
            noise_weighting = 0.63
          end
          if radius + core.depth > 80 then
            -- larger islands shapes have a slower easing transition, which leaves large areas
            -- dominated by the density noise, so reduce the density noise when the island is large.
            -- (the numbers here are arbitrary)
            if radius + core.depth > 120 then
              noise_weighting = 0.35
            else
              noise_weighting = math_min(0.6, noise_weighting)
            end
          end

          local surfaceNoise = noise_surfaceMap:get2d({x = x, y = z})
          if DEBUG_GEOMETRIC then surfaceNoise = SURFACEMAP_OFFSET end
          local surface = round(surfaceNoise * 3 * (core.thickness + 1) * horz_easing) -- if you change this formular then update maxSufaceRise in on_generated()
          local coreBottom = math_floor(coreTop - (core.thickness + core.depth))
          local noisyDepthOfFiller = depth_filler;
          if noisyDepthOfFiller >= 3 then noisyDepthOfFiller = noisyDepthOfFiller + math_floor(randomNumbers[(x + z) % 256] * 3) - 1 end

          local yBottom       = math_max(minp.y, coreBottom - 4) -- the -4 is for rare instances when density noise pushes the bottom of the island deeper
          local yBottomIndex  = dataBufferIndex + area.ystride * (yBottom - minp.y) -- equivalent to yBottomIndex = area:index(x, yBottom, z)
          local topBlockIndex = -1
          local bottomBlockIndex = -1
          local vi = yBottomIndex
          local densityNoise  = nil

          for y = yBottom, math_min(overdrawTop, coreTop + surface) do
            local vert_easing = math_min(1, (y - coreBottom) / core.depth)

            -- If you change the densityNoise calculation, remember to similarly update the copy of this calculation in the pond code
            densityNoise = noise_density:get3d({x = x, y = y - coreTop, z = z}) -- TODO: Optimize this!!
            densityNoise = noise_weighting * densityNoise + (1 - noise_weighting) * DENSITY_OFFSET

            if DEBUG_GEOMETRIC then densityNoise = DENSITY_OFFSET end

            if densityNoise * ((horz_easing + vert_easing) / 2) >= REQUIRED_DENSITY then
              if vi > topBlockIndex then topBlockIndex = vi end
              if bottomBlockIndex < 0 and y > minp.y then bottomBlockIndex = vi end -- if y==minp.y then we don't know for sure this is the lowest block

              if y > coreTop + surface - depth_top and data[vi] == nodeId_air then
                data[vi] = nodeId_top
              elseif y >= coreTop + surface - (depth_top + noisyDepthOfFiller) then
                data[vi] = nodeId_filler
              else
                data[vi] = nodeId_stoneBase
              end
            end
            vi = vi + area.ystride
          end

          -- ensure nodeId_top blocks also cover the rounded sides of islands (which may be lower
          -- than the flat top), then dust the top surface.
          if topBlockIndex >= 0 then
            voxelsWereManipulated = true;

            -- we either have the highest block, or overdrawTop - but we don't want to set overdrawTop nodes to nodeId_top
            -- (we will err on the side of caution when we can't distinguish the top of a island's side from overdrawTop)
            if overdrawTop >= coreTop + surface or vi > topBlockIndex + area.ystride then
              if topBlockIndex > yBottomIndex and data[topBlockIndex - area.ystride] ~= nodeId_air and data[topBlockIndex + area.ystride] == nodeId_air then
                -- We only set a block to nodeId_top if there's a block under it "holding it up" as
                -- it's better to leave 1-deep noise as stone/whatever.
                data[topBlockIndex] = nodeId_top
              end
              if nodeId_dust ~= nodeId_ignore and data[topBlockIndex + area.ystride] == nodeId_air then
                -- Delay writing dust to the data buffer until after decoration so avoid preventing tree growth etc
                if core.dustLocations == nil then core.dustLocations = {} end
                core.dustLocations[#core.dustLocations + 1] = topBlockIndex + area.ystride
              end
            end

            if fillerFallsWithGravity and bottomBlockIndex >= 0 and data[bottomBlockIndex] == nodeId_filler then
              -- the bottom node is affected by gravity and can fall if unsupported, put some support in
              data[bottomBlockIndex] = nodeId_stoneBase
            end
          end

          -- add ponds of water, trying to make sure they're not on an edge.
          -- (the only time a pond needs to be rendered when densityNoise is nil (i.e. when there was no land at this x, z),
          -- is when the pond is at minp.y - i.e. the reason no land was rendered is it was below minp.y)
          if surfaceNoise < 0 and (densityNoise ~= nil or (coreTop + surface < minp.y and coreTop >= minp.y)) and nodeId_water ~= nodeId_ignore then
            local pondWallBuffer = core.type.pondWallBuffer
            local pondBottom = nodeId_filler
            local pondWater  = nodeId_water
            if radius > 18 and core.depth > 15 and nodeId_pondBottom ~= nodeId_ignore then
              -- only give ponds a sandbed when islands are large enough for it not to stick out the side or bottom
              pondBottom = nodeId_pondBottom
            end
            if core.temperature <= ICE_REQUIRED_TEMPERATURE and nodeId_ice ~= nodeId_ignore then pondWater = nodeId_ice end

            if densityNoise == nil then
              -- Rare edge case. If the pond is at minp.y, then no land has been rendered, so
              -- densityNoise hasn't been calculated. Calculate it now.
              densityNoise = noise_density:get3d({x = x, y = minp.y, z = z})
              densityNoise = noise_weighting * densityNoise + (1 - noise_weighting) * DENSITY_OFFSET
              if DEBUG_GEOMETRIC then densityNoise = DENSITY_OFFSET end
            end

            local surfaceDensity = densityNoise * ((horz_easing + 1) / 2)
            local onTheEdge = math_sqrt(distanceSquared) + 1 >= radius
            for y = math_max(minp.y, coreTop + surface), math_min(overdrawTop, coreTop - floodableDepth) do
              if surfaceDensity > REQUIRED_DENSITY then
                vi  = dataBufferIndex + area.ystride * (y - minp.y) -- this is the same as vi = area:index(x, y, z)

                if surfaceDensity > (REQUIRED_DENSITY + pondWallBuffer) and not onTheEdge then
                  data[vi] = pondWater
                  if y > minp.y then data[vi - area.ystride] = pondBottom end
                  --remove any dust above ponds
                  if core.dustLocations ~= nil and core.dustLocations[#core.dustLocations] == vi + area.ystride then core.dustLocations[#core.dustLocations] = nil end
                else
                  -- make sure there are some walls to keep the water in
                  if y == coreTop then
                    data[vi] = nodeId_top -- to let isIsland() know not to put vines here (only seems to be an issue when pond is 2 deep or more)
                  else
                    data[vi] = nodeId_filler
                  end
                end;
              end
            end
          end;

        end
      end
      dataBufferIndex = dataBufferIndex + 1
    end
  end

  local decorations = {}
  -- for _,core in ipairs(cores) do
    -- addDetail_vines(decorations, core, data, area, minp, maxp)
    -- voxelsWereManipulated = addDetail_skyReef(decorations, core, data, area, minp, maxp) or voxelsWereManipulated
    -- addDetail_secrets(decorations, core, data, area, minp, maxp)
  -- end

  if voxelsWereManipulated then

    vm:set_data(data)
    if GENERATE_ORES then minetest.generate_ores(vm) end
    minetest.generate_decorations(vm)

    -- for _,core in ipairs(cores) do
      -- addDetail_skyTree(decorations, core, minp, maxp)
    -- end
    for _,decoration in ipairs(decorations) do
      local nodeAtPos = minetest.get_node(decoration.pos)
      if nodeAtPos.name == "air" or nodeAtPos.name == nodeName_ignore then minetest.set_node(decoration.pos, decoration.node) end
    end

    local dustingInProgress = false
    for _,core in ipairs(cores) do
      if core.dustLocations ~= nil then
        if not dustingInProgress then
          vm:get_data(data)
          dustingInProgress = true
        end

        nodeId_dust = minetest.get_content_id(core.biome.node_dust)
        for _, location in ipairs(core.dustLocations) do
          if data[location] == nodeId_air and data[location - area.ystride] ~= nodeId_air then
            data[location] = nodeId_dust
          end
        end
      end
    end
    if dustingInProgress then vm:set_data(data) end


    -- Lighting is a problem. Two problems really...
    --
    -- Problem 1:
    -- We can't use the usual lua mapgen lighting trick of flags="nolight" e.g.:
    --    minetest.set_mapgen_params({mgname = "singlenode", flags = "nolight"})
    -- (https://forum.minetest.net/viewtopic.php?t=19836)
    --
    -- because the mod is designed to run with other mapgens. So we must set the light
    -- values to zero at islands before calling calc_lighting() to propegate lighting
    -- down from above.
    --
    -- This causes lighting bugs if we zero the whole emerge_min-emerge_max area because
    -- it leaves hard black at the edges of the emerged area (calc_lighting must assume
    -- a value of zero for light outside the region, and be blending that in)
    --
    -- But we can't simply zero only the minp-maxp area instead, because then calc_lighting
    -- reads the daylight values out of the overdraw area and blends those in, cutting
    -- up shadows with lines of daylight along chunk boundaries.
    --
    -- The correct solution is to zero and calculate the whole emerge_min-emerge_max area,
    -- but only write the calculated lighting information from minp-maxp back into the map,
    -- however the API doesn't appear to provide a fast way to do that.
    --
    -- Workaround: zero an area that extends into the overdraw region, but keeps a gap around
    -- the edges to preserve and allow the real light values to propegate in. Then when
    -- calc_lighting is called it will have daylight (or existing values) at the emerge boundary
    -- but not near the chunk boundary. calc_lighting is able to take the edge lighting into
    -- account instead of assuming zero. It's not a perfect solution, but allows shading without
    -- glaringly obvious lighting artifacts, and the minor ill effects should only affect the
    -- islands and be corrected any time lighting is updated.
    --
    --
    -- Problem 2:
    -- We don't want islands to blacken the landscape below them in shadow.
    --
    -- Workaround 1: Instead of zeroing the lighting before propegating from above, set it
    -- to 2, so that shadows are never pitch black. Shadows will still go back to pitch black
    -- though if lighting gets recalculated, e.g. player places a torch then removes it.
    --
    -- Workaround 2: set the bottom of the chunk to full daylight, ensuring that full
    -- daylight is what propegates down below islands. This has the problem of causing a
    -- bright horizontal band of light where islands approach a chunk floor or ceiling,
    -- but Hallelujah Mountains already had that issue due to having propagate_shadow
    -- turned off when calling calc_lighting. This workaround has the same drawback, but
    -- does a much better job of preventing undesired shadows.

    local shadowGap = 1
    local brightMin = {x = emerge_min.x + shadowGap, y = minp.y    , z = emerge_min.z + shadowGap}
    local brightMax = {x = emerge_max.x - shadowGap, y = minp.y + 1, z = emerge_max.z - shadowGap}
    local darkMin   = {x = emerge_min.x + shadowGap, y = minp.y + 1, z = emerge_min.z + shadowGap}
    local darkMax   = {x = emerge_max.x - shadowGap, y = maxp.y    , z = emerge_max.z - shadowGap}

    vm:set_lighting({day=2,  night=0}, darkMin, darkMax)
    vm:calc_lighting()
    vm:set_lighting({day=15, night=0}, brightMin, brightMax)

    vm:write_to_map() -- seems to be unnecessary when other mods that use vm are running

    for _,core in ipairs(cores) do
      -- place any schematics which should be placed after the landscape
      if addDetail_ancientPortal ~= nil then addDetail_ancientPortal(core) end
    end
  end
end


cloudlands.init = function()
  if noise_eddyField == nil then
    init_mapgen()
    --init_secrets()
  end
end

local function on_generated(minp, maxp, blockseed)

  local memUsageT0
  local osClockT0 = os.clock()
  if DEBUG then memUsageT0 = collectgarbage("count") end

  local largestCoreType  = cloudlands.coreTypes[1] -- the first island type is the biggest/thickest
  local maxCoreThickness = largestCoreType.thicknessMax
  local maxCoreDepth     = largestCoreType.radiusMax * 3 / 2 -- todo: not sure why this is radius based and not maxDepth based??
  local maxSufaceRise    = 3 * (maxCoreThickness + 1)

  if minp.y > ALTITUDE + (ALTITUDE_AMPLITUDE + maxSufaceRise + 10) or   -- the 10 is an arbitrary number because sometimes the noise values exceed their normal range.
     maxp.y < ALTITUDE - (ALTITUDE_AMPLITUDE + maxCoreThickness + maxCoreDepth + 10) then
    -- Hallelujah Mountains don't generate here
    return
  end

  cloudlands.init();
  local cores = cloudlands.get_island_details(minp, maxp)

  if DEBUG then
    minetest.log("info", "Cores for on_generated(): " .. #cores)
    for _,core in pairs(cores) do
      minetest.log("core ("..core.x..","..core.y..","..core.z..") r"..core.radius);
    end
  end

  if #cores > 0 then
    -- voxelmanip has mem-leaking issues, avoid creating one if we're not going to need it
    renderCores(cores, minp, maxp, blockseed)

    if DEBUG then
      minetest.log(
        "info",
        MODNAME .. " took "
        .. round((os.clock() - osClockT0) * 1000)
        .. "ms for " .. #cores .. " cores. Uncollected memory delta: "
        .. round(collectgarbage("count") - memUsageT0) .. " KB"
      )
    end
  end
end


minetest.register_on_generated(on_generated)

minetest.register_on_mapgen_init(
  -- invoked after mods initially run but before the environment is created, while the mapgen is being initialized
  function(mgparams)
    worldSeed = mgparams.seed
    --if DEBUG then minetest.set_mapgen_params({mgname = "singlenode"--[[, flags = "nolight"]]}) end
  end
)
