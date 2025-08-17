local events = require("event.events")
local gameEvents = require("main/events/gameEvents")
local playerModel = require("main/battle/playerModel")
local enemyModel = require("main/battle/enemyModel")
local buffs = require("main/battle/buffs")

local M = {}

function M.calculate_player_damage()
	local rand = math.random(4)
	return math.floor( (10+playerModel.str) * (0.8+0.1*rand) + 0.5 )
end

function M.calculate_enemy_damage()
	local rand = math.random(4)
	return math.floor( (10+enemyModel.str) * (0.8+0.1*rand) + 0.5 )
end

function M.player_attack(go_url)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(600, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		local rand = math.random(1,2)
		events.trigger(gameEvents.PLAY_SFX,"#hit_"..tostring(rand))
		local dmg = M.calculate_player_damage()
		events.trigger(gameEvents.ENEMY_HURT,dmg)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)
end

function M.player_lion_strike(go_url)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(600, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#swoosh")
		events.trigger(gameEvents.PLAY_EFFECT,"lionstrike")
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)

	timer.delay(0.3, false, function() 
		local rand = math.random(1,2)
		events.trigger(gameEvents.PLAY_SFX,"#hit_"..tostring(rand))
		local dmg = M.calculate_player_damage()
		events.trigger(gameEvents.ENEMY_HURT,dmg)
	end)
end

function M.player_meteor_smash(go_url)
	local original_pos = go.get_position(go_url)
	local target_pos1 = vmath.vector3(800, 600, original_pos.z)
	events.trigger(gameEvents.PLAY_SFX,"#swoosh2")
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos1.x, go.EASING_LINEAR, 0.2, 0)
	go.animate(go_url, "position.y", go.PLAYBACK_ONCE_FORWARD, target_pos1.y, go.EASING_LINEAR, 0.2, 0)
	go.animate(go_url, "position.y", go.PLAYBACK_ONCE_FORWARD, original_pos.y, go.EASING_LINEAR, 0.1, 0.25,function()
		events.trigger(gameEvents.PLAY_EFFECT,"smoke",-10,-100,0,1.2)
		events.trigger(gameEvents.SHAKE_EFFECT,0.2,20)	
		events.trigger(gameEvents.PLAY_SFX,"#explosion1")
	end)
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2, 0.35)
end

function M.player_berserk(go_url)
	local obj_url = msg.url(nil,go_url,"sprite")
	go.set(obj_url, "tint", vmath.vector4(1, 0, 0, 1))

	events.trigger(gameEvents.PLAY_SFX,"#explosion_long2")
	events.trigger(gameEvents.SHAKE_EFFECT,0.2,20)	

	playerModel.addBuff(buffs.BERSERK,5)
	timer.delay(5, false, function()
		go.set(obj_url, "tint", vmath.vector4(1, 1, 1, 1))
	end)
end

function M.enemy_attack(go_url)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(680, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		local rand = math.random(1,2)
		events.trigger(gameEvents.PLAY_SFX,"#hit_"..tostring(rand))

		local dmg = M.calculate_enemy_damage()
		events.trigger(gameEvents.PLAYER_HURT,dmg)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)
end

return M