local modpath, S = ...

--make sure this is redefined as shown below aka
--don't run mob_rotation_degree_to_radians(rotation)
--run local radians = mob_rotation_degree_to_radians(rotation)
--or the mobs head rotation will become overwritten
local head_rotation_to_radians = function(rotation)
	return{
		x = 0, --roll should never be changed
		y = degrees_to_radians(180 - rotation.y)*-1,
		z = degrees_to_radians(90 - rotation.z)
	}
end

--a movement test to move the head
petz.move_head = function(self, tpos, dtime)
	local head_position, head_rotation = self.object:get_bone_position("head")
	local pos = self.object:get_pos()
	head_position = self.head_position
	local direction = vector.direction(pos, tpos)
	--local yaw = minetest.dir_to_yaw(look_at_dir)
	--local body_yaw = self.object:get_yaw()
	look_at_dir = vector.normalize(direction)
	local yaw = mokapi.yaw_to_degrees(math.asin(look_at_dir.y))
	--local yaw =mokapi.yaw_to_degrees(math.atan2(look_at_dir.x, look_at_dir.z))
	--yaw = mokapi.degrees(yaw)
	minetest.chat_send_all("yaw= "..tostring(yaw))
	--local pitch = mokapi.yaw_to_degrees(math.asin(look_at_dir.y))
	--local roll = 0
	--head_rotation.y = mokapi.yaw_to_degrees(yaw)
	--head_rotation.x = mokapi.yaw_to_degrees(pitch)
	--head_rotation.x = head_rotation. + yaw
	if yaw < 60 and yaw > -60 then
		head_rotation = {x= -90, y= 90-yaw, z= 0}
		minetest.chat_send_all("yes")
	else
		head_rotation = self.head_rotation
	end
	self.object:set_bone_position("head", head_position, head_rotation)
end

--void lookAt(Vec3 center)
--   Vec3 direction = (center - position).normalized;
--   pitch = asin(direction.y);
--   yaw = atan2(direction.x, direction.z);
--}

--this sets the mob to move it's head back to pointing forwards

petz.return_head_to_origin = function(self, dtime)
	local head_position, head_rotation = self.object:get_bone_position("head")
	--make the head yaw move back
	if head_rotation.x > 0 then
		head_rotation.x = head_rotation.x - 1
	elseif head_rotation.x < 0 then
		head_rotation.x = head_rotation.x + 1
	end

	--move up down (pitch) back to center
	if head_rotation.z > 0 then
		head_rotation.z = head_rotation.z - 1
	elseif head_rotation.z < 0 then
		head_rotation.z = head_rotation.z + 1
	end

	self.object:set_bone_position("head", head_position, head_rotation)
end
