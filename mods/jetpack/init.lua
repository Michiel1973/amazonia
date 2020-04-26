local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local players = {}
local equip = {}

-- hudbar id
local HB_NAME = 'charge'
-- update interval (charge, inventory and hudbar)
local HB_DELTA = 1
-- jetpack charge. default 150000 = 10 min (250 EU/s)
local CHARGE_MAX = 75000

-- recipes
minetest.register_craftitem("jetpack:battery", {
	description = "Jetpack battery",
	inventory_image = "jetpack_battery.png",
})

minetest.register_craftitem("jetpack:blades", {
	description = "Blades",
	inventory_image = "jetpack_blade.png",
})

minetest.register_craftitem("jetpack:motor", {
	description = "Electric engine",
	inventory_image = "jetpack_engine.png",
})

armor:register_armor("jetpack:jetpack", {
    description = "Jetpack",
    texture = "jetpack_jetpack.png",
    inventory_image = "jetpack_jetpack_inv.png",
    groups = {armor_torso=1, armor_legs=1, armor_heal=0, armor_use=800, physics_speed=-0.04, physics_gravity=0.04},
    armor_groups = {fleshy=15},
    damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
})

minetest.register_craft({
	output = "jetpack:battery",
	recipe = {
		{"technic:carbon_steel_ingot", "technic:fine_gold_wire", "technic:carbon_steel_ingot"},
		{"technic:mv_cable", "technic:green_energy_crystal", "technic:mv_cable"},
		{"technic:carbon_steel_ingot", "technic:fine_gold_wire", "technic:carbon_steel_ingot"},
	},
})

minetest.register_craft({
	output = "jetpack:blades 2",
	recipe = {
		{"", "technic:carbon_steel_ingot", ""},
		{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", "technic:carbon_steel_ingot"},
		{"", "technic:carbon_steel_ingot", ""},
	},
})

minetest.register_craft({
	output = "jetpack:motor",
    type = "shapeless",
    recipe = {"technic:motor", "jetpack:blades"},
})

minetest.register_craft({
	output = "jetpack:jetpack",
	recipe = {
		{"technic:carbon_steel_ingot", "jetpack:battery", "technic:carbon_steel_ingot"},
		{"jetpack:motor", "technic:mv_cable", "jetpack:motor"},
		{"", "", ""}
	},
})

-- register technic charge
technic.register_power_tool('jetpack:jetpack', CHARGE_MAX)

-- register charge hudbar
hb.register_hudbar(HB_NAME, 0xFFFFFF, 'Charge', { icon = 'jetpack_charge_icon.png', bgicon = 'jetpack_charge_bgicon.png',  bar = 'jetpack_charge_bar.png' }, 0, CHARGE_MAX, true)

local function jetpack_off (player)
    local playerName = player:get_player_name()
    player:set_physics_override({gravity=1,speed=1})
    if players[playerName].sndHandle then
        minetest.sound_stop(players[playerName].sndHandle)
        players[playerName].sndHandle = nil
    end
    players[playerName].engine = 0
end

minetest.register_on_joinplayer(function(player)
    local playerName = player:get_player_name()
    local inv = minetest.get_inventory({type='detached', name=playerName..'_armor'})
    hb.init_hudbar(player, HB_NAME, 0)
    hb.hide_hudbar(player, HB_NAME)
end)

-- set on equip
armor:register_on_equip(function(player, index, stack)
    local itemMeta = minetest.deserialize(stack:get_metadata())
    local playerName = player:get_player_name()
    if stack:get_name() == 'jetpack:jetpack' then
        equip[playerName] = true
        players[playerName] = {
            charge = 0,
            engine = 0,
            state = 0,
            sndHandle = nil,
            stackIndex = index
        }
        if itemMeta and itemMeta.charge then
            players[playerName].charge = itemMeta.charge
        end
        hb.change_hudbar(player, HB_NAME, players[playerName].charge)
        hb.unhide_hudbar(player, HB_NAME)
    end
end)

-- off if destroyed or unequipped
armor:register_on_destroy(function(player, index, stack)
    local playerName = player:get_player_name()
    if stack:get_name() == 'jetpack:jetpack' then
        equip[player:get_player_name()] = nil
        hb.hide_hudbar(player, HB_NAME)
        players[playerName].charge = 0
        jetpack_off(player)
    end
end)

armor:register_on_unequip(function(player, index, stack)
    local playerName = player:get_player_name()
    if stack:get_name() == 'jetpack:jetpack' then
        equip[player:get_player_name()] = nil
        hb.hide_hudbar(player, HB_NAME)
        players[playerName].stackIndex = -1
        jetpack_off(player)
    end
end)

local time = 0
minetest.register_globalstep(function(dtime)
    local player, pos, velocity, node, inv, itemMeta, stack
    local gameTime = minetest.get_gametime()

    for name, val in pairs(equip) do
        if players[name].charge == 0 then return end

        player = minetest.get_player_by_name(name)
		if not player then
		return
		end
		
        pos = player:getpos()
        velocity = player:get_player_velocity()
        node = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})

        if player:get_player_control().jump then
            -- fly up
            if node.name == 'air' then
                if players[name].state ~= 1 then
                    if velocity.y <= 15 then
                        if not players[name].sndHandle then
                            players[name].sndHandle = minetest.sound_play("jetpack_loop", {
                                max_hear_distance = 5,
                                gain = 20.0,
                                object = player,
                                loop = true
                            })
                        end
                        players[name].engine = 1
                        player:set_physics_override({gravity=-0.3,speed=2})
                        players[name].state = 1
                    end
                end
                -- check if we're going too fast
                if players[name].state == 1 and velocity.y > 15 then
                    player:set_physics_override({gravity=1})
                    players[name].state = 0
                end
            end
        else
            -- "hover" mode
            if players[name].engine == 1 then
                if players[name].state == 0 or players[name].state == 1 then
                    player:set_physics_override({gravity=0.3})
                    players[name].state = 2
                end
                if players[name].state == 2 and velocity.y < 1 then
                    player:set_physics_override({gravity=0})
                    players[name].state = 3
                end
            end
        end

        -- fly down
        if player:get_player_control().sneak then
            if players[name].engine == 1 then
                if players[name].state ~= 5 and players[name].gravity ~= 4 then
                    player:set_physics_override({gravity=0.3})
                    players[name].state = 4
                end
            end
        end

        if players[name].engine == 1 then
            -- add particles
            if gameTime % 0.1 == 0 then
                minetest.add_particle({
                    pos = {
                        x = pos.x - math.random()/3 + math.random()/3,
                        y = pos.y + 0.7,
                        z = pos.z - math.random()/3 + math.random()/3
                    },
                    vel = {x=0, y=0, z=0},
                    acc = {x=0, y=-10, z=0},
                    expirationtime = math.random()/6,
                    size = math.random()+0.5,
                    collisiondetection = true,
                    vertical = false,
                    texture = "jetpack_particle.png",
                })
            end

            -- turn off
            if node.name ~= 'air' then
                jetpack_off(player)
                players[name].state = 0
            end

            -- slowdown if we're falling too fast
            if players[name].state == 4 and velocity.y < -10 then
                player:set_physics_override({gravity=-1})
                players[name].state = 5
            end
            if players[name].state == 5 and velocity.y >= -10 then
                player:set_physics_override({gravity=1})
                players[name].state = 4
            end
        end

        time = time + dtime
        if time >= HB_DELTA then
            if players[name].engine == 1 then
                -- update charge
                players[name].charge = players[name].charge - time * 250
                if players[name].charge < HB_DELTA * 250 then
                    player:set_physics_override({gravity=1,speed=1})
                    if players[name].sndHandle then
                        minetest.sound_stop(players[name].sndHandle)
                        players[name].sndHandle = nil
                    end
                    players[name].charge = 0
                end
                -- update item in inventory
                inv = minetest.get_inventory({type='detached', name=player:get_player_name()..'_armor'})
                stack = ItemStack('jetpack:jetpack')
                itemMeta = {
                    charge = players[name].charge
                }
                stack:set_metadata(minetest.serialize(itemMeta))
                inv:set_stack('armor', players[name].stackIndex, stack)
                player:get_inventory():set_stack('armor', players[name].stackIndex, stack)
                hb.change_hudbar(player, HB_NAME, players[name].charge)
                if players[name].charge == 0 then
                    players[name].engine = 0
                end
            end
            time = 0
        end

    end
end)
