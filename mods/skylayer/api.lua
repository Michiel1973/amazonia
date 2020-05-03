-------------------------
-- Sky Layers: API

-- Git: https://gitlab.com/rautars/skylayer
-- License: MIT
-- Credits: rautars
-------------------------

-- include skylayer core functions
local modpath = minetest.get_modpath("skylayer");
local core = dofile(modpath.."/core.lua")

skylayer = {}

-- set flag for enable / disable skylayer
skylayer.is_enabled = function(enabled)
	core.settings.enabled = enabled
end

skylayer.add_layer = function(player_name, layer)
	if layer == nil or layer.name == nil then
		minetest.log("error", "Incorrect skylayer definition")
		return
	end

	local player_data = core.get_player_data(player_name)
	if player_data == nil then
		player_data = core.create_new_player_data(player_name)
	end

	if player_data == nil then
		minetest.log("error", "Fail to add skylayer to player '" .. player_name .. "'")
		return
	end
	layer.added_time = os.time()
	layer.updated = false
	layer.update_interval = layer.update_interval and layer.update_interval or core.settings.update_interval

	table.insert(player_data.skylayers, layer)
end

skylayer.remove_layer = function(player_name, layer_name)
	local player_data = core.get_player_data(player_name)
	if player_data == nil or player_data.skylayers == nil then
		return
	end

	if #player_data.skylayers == 0 then
		return
	end

	for k, layer in ipairs(player_data.skylayers) do
		if layer.name == layer_name then
			table.remove(player_data.skylayers, k)
			if #player_data.skylayers == 0 then
				local player = core.get_player_by_name(player_name)
				if player ~= nil then
					core.reset_sky(player)
				end
			end
			return
		end
	end
end
