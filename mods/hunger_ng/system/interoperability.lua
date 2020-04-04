-- Localize Hunger NG
local a = hunger_ng.attributes
local c = hunger_ng.configuration
local e = hunger_ng.effects
local f = hunger_ng.functions
local s = hunger_ng.settings
local S = hunger_ng.configuration.translator


-- Localize Minetest
local get_modpath = minetest.get_modpath


-- Load needed data
local path = minetest.get_modpath('hunger_ng')
local inter_path = path..DIR_DELIM..'interoperability'..DIR_DELIM
local config = Settings(path..DIR_DELIM..'mod.conf')
local depends = config:get('depends')..', '..config:get('optional_depends')


-- Check if the given file exists
--
-- This function tries to open a given file path. If the file exists then a
-- boolean true is returned, otherwise nothing will be returned.
--
-- This circumvents the removal of the built-in `file_exists` function of
-- Minetest that was removed with pull request 9451.
--
-- @see https://github.com/minetest/minetest/pull/9451
-- @param path   The file path to check for existence
-- @return mixed Either true or nil is returned (true = file exists)
local file_exists = function (path)
    local handle = io.open(path, 'r')
    if handle ~= nil then
        io.close(handle)
        return true
    end
end


-- Check if interoperability file exists and load it
for modname in depends:gmatch('[0-9a-z_-]+') do
    if get_modpath(modname) then
        local inter_file = inter_path..modname..'.lua'

        if file_exists(inter_file) then
            dofile(inter_file)
            local message = 'Loaded built-in '..modname..' support'
            minetest.log('action', c.log_prefix..message)
        end
    end
end
