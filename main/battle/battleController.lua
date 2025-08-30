local events = require("event.events")
local gameEvents = require("main/events/gameEvents")
local playerModel = require("main/battle/playerModel")
local enemyModel = require("main/battle/enemyModel")
local buffs = require("main/battle/buffs")
local hitType = require("main/battle/hitType")
local skills = require("main/battle/skills")

local M = {}

function M.addCd(skillName,enemyCasted)
	if not enemyCasted then
		for i, skill in ipairs(playerModel.skills) do
			if skill.skillName == skillName then
				skill.cd = (skill.cd or 0) + skills.getCD(skillName)
				skill.maxCd = skills.getCD(skillName)
			end
			if skill.cd < skills.getGlobalCD(skillName) then 
				skill.cd = (skill.cd or 0) + skills.getGlobalCD(skillName)
				skill.maxCd = skills.getGlobalCD(skillName)
			end
		end
		--playerModel.globalCd = (playerModel.globalCd or 0) + skills.getGlobalCD(skillName)
	end
end

function M.payResourceCost(skillName,enemyCasted)
	if not enemyCasted and playerModel.getResource() >= skills.getResourceCost(skillName) then
		playerModel.setResource(playerModel.getResource() - skills.getResourceCost(skillName))
		events.trigger(gameEvents.PAY_RESOURCE_COST)
	end
end

function M.getShootTargetX(enemyCasted)
	local targetX = 420
	if enemyCasted then 
		targetX = 850
	end
	return targetX
end

function M.calculate_damage(skillName,enemyCasted)
	local str = playerModel.str
	if enemyCasted then 
		str = enemyModel.str
	end
	local rand = math.random(4)
	return math.floor( (10+str) * (0.8+0.1*rand) * skills.getDamage(skillName) + 0.5 ) 
end

function M.attack(go_url,enemyCasted)
	local original_pos = go.get_position(go_url)
	local targetX = 600
	if enemyCasted then
		targetX = 680
	end
	local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		local rand = math.random(1,2)
		events.trigger(gameEvents.PLAY_SFX,"#hit_"..tostring(rand))
		local dmg = M.calculate_damage(skills.EMPTY,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.BASIC)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)
end

function M.fire_bolt(go_url, enemyCasted)
	M.payResourceCost(skills.FIRE_BOLT, enemyCasted)
	M.addCd(skills.FIRE_BOLT,enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"fire_bolt",0,0,1,0.5,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.fire_bolt_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.FIRE_BOLT,enemyCasted)
	events.trigger(gameEvents.getEffectEvent(enemyCasted),"explosion",0,0,0,0.8,enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#explosion1")
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.NONE)
end

function M.arcane_bolt(go_url,enemyCasted)
	M.addCd(skills.ARCANE_BOLT,enemyCasted)
	M.payResourceCost(skills.ARCANE_BOLT, enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"arcane_bolt",0,0,1,0.3,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.arcane_bolt_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.ARCANE_BOLT,enemyCasted)
	events.trigger(gameEvents.getEffectEvent(enemyCasted),"hit3",0,0,0,0.8,enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#hit_1")
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.NONE)
end

function M.frost_bolt(go_url,enemyCasted)
	M.addCd(skills.FROST_BOLT,enemyCasted)
	M.payResourceCost(skills.FROST_BOLT, enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"frost_bolt",0,0,1,0.8,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.frost_bolt_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.FROST_BOLT,enemyCasted)
		events.trigger(gameEvents.getParticleEvent(enemyCasted),"#frost_bolt")
		events.trigger(gameEvents.PLAY_SFX,"#hit_1")
		events.trigger(gameEvents.PLAY_SFX,"#explosion2")
		if enemyCasted then
			playerModel.addBuff(buffs.FROST,7)
		else
			enemyModel.addBuff(buffs.FROST,7)
		end
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.NONE)
end

function M.lion_strike(go_url,enemyCasted)
	M.payResourceCost(skills.LION_STRIKE, enemyCasted)
	M.addCd(skills.LION_STRIKE,enemyCasted)
	local original_pos = go.get_position(go_url)
	local targetX = 600
	if enemyCasted then 
		targetX = 680
	end
	local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#swoosh")
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"lionstrike",0,0,0,1,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)

	timer.delay(0.3, false, function() 
		local rand = math.random(1,2)
		events.trigger(gameEvents.PLAY_SFX,"#hit_"..tostring(rand))
		local dmg = M.calculate_damage(skills.LION_STRIKE,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.FLASHING)
	end)
end

function M.meteor_smash(go_url,enemyCasted)
	M.payResourceCost(skills.METEOR_SMASH, enemyCasted)
	M.addCd(skills.METEOR_SMASH,enemyCasted)
	local original_pos = go.get_position(go_url)
	local targetX = 800
	if enemyCasted then 
		targetX = 480
	end
	local target_pos1 = vmath.vector3(targetX, 600, original_pos.z)
	events.trigger(gameEvents.PLAY_SFX,"#swoosh2")
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos1.x, go.EASING_LINEAR, 0.2, 0)
	go.animate(go_url, "position.y", go.PLAYBACK_ONCE_FORWARD, target_pos1.y, go.EASING_LINEAR, 0.2, 0)
	go.animate(go_url, "position.y", go.PLAYBACK_ONCE_FORWARD, original_pos.y, go.EASING_LINEAR, 0.1, 0.25,function()
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"smoke",-10,-50,0,1.2)
		events.trigger(gameEvents.SHAKE_EFFECT,0.2,20)	
		events.trigger(gameEvents.PLAY_SFX,"#explosion1")
		local dmg = M.calculate_damage(skills.METEOR_SMASH,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.NONE)
	end)
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2, 0.35)
end

function M.berserk(go_url,enemyCasted)
	M.payResourceCost(skills.BERSERK, enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#explosion_long2")
	events.trigger(gameEvents.SHAKE_EFFECT,0.2,20)	
	M.addCd(skills.BERSERK,enemyCasted)
	if enemyCasted then
		enemyModel.addBuff(buffs.BERSERK,5)
	else
		playerModel.addBuff(buffs.BERSERK,5)
	end
end

return M