--[[
v1.32
This script is used in DMC's Weapon Overhaul, please make sure you have the most up to date version by checking the Steam group: http://steamcommunity.com/groups/DMCWpnOverhaul
]]

if not tweak_data then return end

tweak_data.weapon.mg42.sounds.fire = "mg42_fire"
tweak_data.weapon.mg42.sounds.fire_single = "mg42_fire"
tweak_data.weapon.m134.sounds.fire = "minigun_fire"
tweak_data.weapon.m134.sounds.fire_single = "minigun_fire"

-- Header comment that will likely be deleted. This was made by 90e.
-- Reverb fixed by Doctor Mister Cool

-- Don't play a sound conventionally (unless using the saw which lacks a single fire sound)
local base_fire_sound = RaycastWeaponBase._fire_sound
function RaycastWeaponBase:_fire_sound()
	if self:get_name_id() == "saw" or self:get_name_id() == "saw_secondary" or self:get_name_id() == "flamethrower_mk2" then
		base_fire_sound(self)
	end
end

-- Instead play the single fire noise here
local old_fire = RaycastWeaponBase.fire
function RaycastWeaponBase:fire(...)
	local result = old_fire(self, ...)
	
	-- Don't try playing the single fire sound with the saw
	if self:get_name_id() == "saw" or self:get_name_id() == "saw_secondary" or self:get_name_id() == "flamethrower_mk2" then
		return result
	end
	
	if result then
		self:play_tweak_data_sound("fire_single", "fire")
		self:play_tweak_data_sound("stop_fire") --DMC did a thing here, that's it really
	end
	
	return result
end

local base_shoot_stop = RaycastWeaponBase.stop_shooting
function RaycastWeaponBase:stop_shooting()
	if self:get_name_id() == "saw" or self:get_name_id() == "saw_secondary" or self:get_name_id() == "flamethrower_mk2" then
		base_shoot_stop(self)
	end
end
