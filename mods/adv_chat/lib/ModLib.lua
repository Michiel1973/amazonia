-- Constants that must NEVER change

local REGISTRY_KEY = "ModLib:registry"
local LIB_DIRS_KEY = "ModLib:libdirs"
local THIS_LIB_NAME = "ModLib"


-- Constants for THIS version

local THIS_VERSION_STR = "1.1"

local LIB_NAME_PATT = "^[a-zA-Z][a-zA-Z0-9]*$"

local LIB_FILENAME_PATT = "^([a-zA-Z][a-zA-Z0-9]*)_([0-9]+)()"
local LIB_FILENAME_EXTRA_PATT = "^%-([0-9]+)()"
local LIB_FILENAME_END_PATT = "^%.lua$"

local HACKY_DIR_LIST_FILENAME = "ModLib_list.txt"


-- Class Version, used to store both a hash and sorted table of library
-- instances by canonicalized version number.


--- Type initialized from "x.y.z" version strings, able to compare
 -- lexicographically, component by component (x, then y, then z, etc.).
 -- For example, if these versions are defined:
 --
 --    verA = ModLib.Version("1")
 --    verB = ModLib.Version("1.0")
 --    verC = ModLib.Version("1.0.0.3")
 --    verD = ModLib.Version("1.1")
 --    verE = ModLib.Version("2.0")
 --
 -- then the following expression will evaluate to true:
 --
 --    verA == verB and verB < verC and verC < verD and verD < verE
 --
 -- Converting a version back to a string will return the "canonicalized"
 -- version number by stripping all trailing zeroes (until there is only one
 -- component remaining).  For example, given the above definitions, all of the
 -- following are true:
 --
 --    tostring(verB) == "1"
 --    tostring(verD) == "1.1"
 --    tostring(ModLib.Version("0.0.0")) = "0"
 --    tostring(ModLib.Version("0.1")) = "0.1"
local Version = {}
local Version_meta = {}
local Version_inst_meta = {}
setmetatable(Version, Version_meta)

local function Version_constr(class, verstr)
   self = {}

   local len = string.len(verstr)
   local si = 1
   local ei, comp
   while si <= len do
      ei = string.find(verstr, ".", si, true)
      if not ei then ei = len+1 end
      if ei <= si or ei == len then
         self = nil
         break
      end
      comp = string.sub(verstr, si, ei-1)
      if not string.find(comp, "^[0-9]+$") then
         self = nil
         break;
      end
      table.insert(self, tonumber(comp))
      si = ei+1
   end
   if self then
      while #self > 1 and self[#self] == 0 do
         table.remove(self)
      end
      setmetatable(self, Version_inst_meta)
   end
   return self
end
Version_meta.__call = Version_constr

local function Version_cmp(ver1, ver2)
   local diff
   for i = 1, math.min(#ver1, #ver2) do
      diff = ver1[i] - ver2[i]
      if diff > 0 then return 1 elseif diff < 0 then return -1 end
   end
   diff = #ver1 - #ver2
   if diff > 0 then return 1 elseif diff < 0 then return -1 end
   return 0
end
Version_inst_meta.__eq = function(ver1, ver2)
   if #ver1 ~= #ver2 then return false end
   return (Version_cmp(ver1, ver2) == 0)
end
Version_inst_meta.__lt = function(ver1, ver2)
   return (Version_cmp(ver1, ver2) < 0)
end

local function Version_concat(val1, val2)
   if type(val1) == "table" then
      val1 = tostring(val1)
   end
   if type(val2) == "table" then
      val2 = tostring(val2)
   end
   return val1..val2
end
Version_inst_meta.__concat = Version_concat

local function Version_tostring(ver)
   return table.concat(ver, ".")
end
Version_inst_meta.__tostring = Version_tostring


-- Bootstrap stuff, so we only "load" this library once

local THIS_VERSION = Version(THIS_VERSION_STR)

local registry = _G[REGISTRY_KEY] or {}
_G[REGISTRY_KEY] = registry

local libDirs = _G[LIB_DIRS_KEY] or {}
_G[LIB_DIRS_KEY] = libDirs

local modLibVersions = registry[THIS_LIB_NAME] or {}
registry[THIS_LIB_NAME] = modLibVersions
local modLibVersionsByValue = modLibVersions.byValue or {}
modLibVersions.byValue = modLibVersionsByValue
local modLibVersionsSorted = modLibVersions.sorted or {}
modLibVersions.sorted = modLibVersionsSorted

local ModLib = modLibVersionsByValue[tostring(THIS_VERSION)]
if ModLib then return ModLib end


-- Finally the ModLib class itself, with Version enclosed for external use:


--- Used to load versions of libraries with version requirements, and load each
 -- version only once.
 --
 -- Example of use:
 --
 --    local MOD_NAME = minetest.get_current_modname()
 --    local MOD_PATH = minetest.get_modpath(MOD_NAME)
 --    local ModLib = dofile(MOD_PATH.."/lib/ModLib_1-0.lua")
 --    ModLib.addDir(MOD_PATH.."/lib")
 --    local MyLib = ModLib.load("MyLib", "i.j.k", "m.n.p")
 --
 -- where "i.j.k" and "m.n.p" are version strings indicating the minimum and
 -- maximum versions of "MyLib" that can be used by the module (with any number
 -- of components, not limited to the three shown here).  This will attempt to
 -- load a file called "MyLib_a-b-c.lua" from any of the directories added
 -- through ModLib.addDir(dir) meeting the requirement that
 -- "i.j.k" <= "a.b.c" <= "m.n.p" lexicographically (after trailing zero
 -- components are stripped from each version string).  If multiple files meet
 -- the requirement, the one with greatest "a.b.c" will be used.  To require an
 -- exact version, use the same value for the minimum and maximum versions.  To
 -- require ANY version (the highest version will be used), omit both
 -- versions (or use nil for them).  To specify a half-open range, use nil for
 -- either (or omit the maximum).
 --
 -- These are the requirements for mod libraries:
 --
 -- 1.) The library name must begin with a letter, and must contain only
 --     letters and digits.
 -- 2.) They MUST NOT set any global variables except in the rare case that it
 --     is always going to be okay to share the value between ALL versions
 --     of the library (note the local variables in the example above).  In
 --     particular, the "MyLib" variable here must NOT be set as a global
 --     variable by the library, and must instead be a local variable returned
 --     from the file.
 -- 3.) They MUST return the main class of the library itself from the file.
 -- 4.) They MAY optionally set MyLib.VERSION in the returned main class, but
 --     this will be overwritten by ModLib with the canonicalized version
 --     string "a.b.c", constructed from the name of the file the library is
 --     loaded from.
 --
 -- Note that ModLib itself is a mod library, so it could conceivably be used
 -- to load a different version of itself after the initial bootstrap loading
 -- (though it's unlikely you'd want to)!
 --
 -- Here is an example of a dirt simple mod library that defines a field and a
 -- function:
 --
 --    -- MyDumbLib_1-0.lua
 --    local MyDumbLib = {}
 --    MyDumbLib.value = 1
 --    function MyDumbLib.foo() print("foo!") end
 --    return MyDumbLib
 --
 -- NOTE: Due to a deficiency in the Lua 5.1 standard library, directories
 -- cannot be listed without the aid of a C extension to the API.  Therefore,
 -- you must create a file called "ModLib_list.txt" in each directory added
 -- through ModLib.addDir(dir) that contains one simple filename per line of
 -- the valid library files in that directory.  This can be done in Linux using
 -- the command "ls -1 >ModLib_list.txt" from within the directory.  Hopefully
 -- this library becomes a part of the Minetest core at some point, and all of
 -- this can be done flawlessly from the C++ instead.
ModLib = {}
ModLib.Version = Version
ModLib.VERSION = tostring(THIS_VERSION)

-- Returns index of the last array element from a sorted array less than or
-- equal to a value, zero if all elements of the table are greater than the
-- value or if the table is empty.
local function binarySearchUpperBound(table, value)
   if #table < 1 then return 0 end
   if table[#table] <= value then return #table end
   if table[1] > value then return 0 end

   local si = 1
   local ei = #table
   local mi = math.floor((si+ei)/2)
   local mv = table[mi]

   while mi > si do
      local mv = table[mi]
      if mv <= value then
         si = mi
      else
         ei = mi
      end
      mi = math.floor((si+ei)/2)
      mv = table[mi]
   end

   return si
end

local function addLib(libName, ver, filePath)
   local verStr = tostring(ver)
   if not registry[libName].byValue[verStr] then
      local loader = loadfile(filePath)
      local lib = loader(libName)
      lib.VERSION = tostring(ver)

      registry[libName].byValue[verStr] = lib

      local sorted = registry[libName].sorted
      local pos = binarySearchUpperBound(sorted, ver)
      if not pos then pos = 0 end
      table.insert(sorted, pos+1, ver)
   end
end

local function ModLib_load(libName, minVerStr, maxVerStr)
   local minVer = minVerStr and Version(minVerStr)
   local maxVer = maxVerStr and Version(maxVerStr)
   if minVerStr and not minVer then
      error("Bad version string '"..minVerStr.."'", 2)
   end
   if maxVerStr and not maxVer then
      error("Bad version string '"..maxVerStr.."'", 2)
   end
   if not string.match(libName, LIB_NAME_PATT) then
      error("Bad library name '"..libName.."'", 2)
   end
   if minVer and maxVer and minVer > maxVer then
      error("Min version greater than max version", 2)
   end

   local libVersions = registry[libName] or {}
   registry[libName] = libVersions
   local libVersionsByValue = libVersions.byValue or {}
   libVersions.byValue = libVersionsByValue
   local libVersionsSorted = libVersions.sorted or {}
   libVersions.sorted = libVersionsSorted

   if maxVer then
      local lib = libVersionsByValue[tostring(maxVer)]
      if lib then return lib end
   end

   for i, dir in ipairs(libDirs) do
      local listFile = io.open(dir.."/"..HACKY_DIR_LIST_FILENAME)
      if listFile then
         listFile:close()
         for fileName in io.lines(dir.."/"..HACKY_DIR_LIST_FILENAME) do
            local name, verStr, i = string.match(fileName, LIB_FILENAME_PATT)
            if name and verStr and i then
               while i <= #fileName do
                  local verComp, ni = string.match(fileName,
                                                   LIB_FILENAME_EXTRA_PATT,
                                                   i)
                  if verComp and ni then
                     verStr = verStr.."."..verComp
                     i = ni
                  else
                     break
                  end
               end
               if not string.match(fileName, LIB_FILENAME_END_PATT, i) then
                  name = nil
                  verStr = nil
               end
            end
            if name and verStr and name == libName then
               local ver = Version(verStr)
               if (not minVer or ver >= minVer) and
                  (not maxVer or ver <= maxVer)
               then
                  local filePath = dir.."/"..fileName
                  local file = io.open(filePath)
                  if file then
                     file:close()
                     addLib(libName, ver, filePath)
                     if maxVer and ver == maxVer then
                        return libVersionsByValue[tostring(maxVer)]
                     end
                  end
               end
            end
         end
      end
   end

   local pos = (maxVer) and binarySearchUpperBound(libVersionsSorted, maxVer)
                        or #libVersionsSorted
   local ver = (pos and pos >= 1 and pos <= #libVersionsSorted)
                  and libVersionsSorted[pos]
                  or nil
   if not ver or (minVer and ver < minVer) then
      local msg = "Library "
      if minVer then msg = msg..tostring(minVer).." < " end
      msg = msg.."'"..libName.."'"
      if maxVer then msg = msg.." < "..tostring(maxVer) end
      msg = msg.." not found"
      error(msg, 2)
   end

   return libVersionsByValue[tostring(ver)]
end
ModLib.load = ModLib_load

local function ModLib_addDir(dir)
   if not libDirs[dir] then
      table.insert(libDirs, dir)
      libDirs[dir] = #libDirs
   end
end
ModLib.addDir = ModLib_addDir

modLibVersionsByValue[tostring(THIS_VERSION)] = ModLib
return ModLib
