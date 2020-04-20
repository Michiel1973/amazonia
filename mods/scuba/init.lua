minetest.register_tool("scuba:air_tank", {
    description = "Air tank for scuba diving",
    inventory_image = "underwater_air_tank.png",
    on_use = function (itemstack, user, pointed_thing) 
	local wear = itemstack:get_wear()
	local damage = 65000/30
	local recover = wear - (65000/10)
	local breath = user:get_breath()
	if recover <= 0 then recover = 1 end
	if breath >= 11 and wear > 1 then
	    minetest.sound_play("underwater_filling_tank",{to_player = user, gain = 0.5, max_hear_distance = 3})
	    itemstack:set_wear(recover)
	else 
	    if wear <= 65000 and breath < 11 then
	        minetest.sound_play("underwater_breath",{to_player = user, gain = 0.5, max_hear_distance = 3})
	        user:set_breath(10)
	        itemstack:add_wear(damage)
   	    end
	end
	return itemstack
    end,
    wear = 1, 
})

minetest.register_craft({
    output = "scuba:air_tank 1",
    recipe = {
        {"default:copper_ingot", "default:gold_ingot", "default:copper_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
    }
})

print ("[MOD]: scuba loaded")

