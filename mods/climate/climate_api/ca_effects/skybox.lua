--[[
# Skybox Effect
Use this effect to modify a player's sky, clouds, sun, moon, or stars
Expects a table as the parameter containing the following values:
- ``sky_data <table>`` (optional): Sky paramaters to be applied using player.set_sky
- ``cloud_data <table>`` (optional): Cloud paramaters to be applied using player.set_clouds
- ``sun_data <table>`` (optional): Sun paramaters to be applied using player.set_sun
- ``moon_data <table>`` (optional): Sky paramaters to be applied using player.set_moon
- ``star_data <table>`` (optional): Sky paramaters to be applied using player.set_stars
- ``priority <number>`` (optional): A skybox with higher priority will override lower rated ones (defaults to 1)
]]

if not climate_mod.settings.skybox then return end

local EFFECT_NAME = "climate_api:skybox"

local function handle_effect(player_data, prev_data)

end

local function remove_effect(player_data)

end

climate_api.register_effect(EFFECT_NAME, handle_effect, "tick")
climate_api.register_effect(EFFECT_NAME, remove_effect, "stop")