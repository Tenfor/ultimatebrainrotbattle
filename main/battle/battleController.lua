local events = require("event.events")
local gameEvents = require("main/events/gameEvents")
local playerModel = require("main/battle/playerModel")
local enemyModel = require("main/battle/enemyModel")
local buffs = require("main/battle/buffs")
local hitType = require("main/battle/hitType")
local skills = require("main/battle/skills")

local M = {}

function M.getRealSpeed(enemyCasted)
	if enemyCasted then 
		local extra = enemyModel.hasBuff(buffs.BERSERK) and 3 or 1
		extra = enemyModel.hasBuff(buffs.FROST) and extra/3 or extra
		return enemyModel.spd * extra
	else 
		local extra = playerModel.hasBuff(buffs.BERSERK) and 3 or 1
		extra = playerModel.hasBuff(buffs.FROST) and extra/3 or extra
		return playerModel.spd * extra
	end
end

function M.addCd(skillName,enemyCasted)

	if not enemyCasted then
		for i, skill in ipairs(playerModel.skills) do
			if skill.skillName == skillName then
				skill.cd = (skill.cd or 0) + (skills.getCD(skillName) - skills.getCD(skillName) * playerModel.cdr/100)
				skill.maxCd = skills.getCD(skillName) - skills.getCD(skillName) * playerModel.cdr/100
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

function M.getShootTargetX(originalX, enemyCasted)
	local targetX = originalX - 30
	if enemyCasted then 
		targetX = originalX + 30
	end
	return targetX
end

function M.calculate_damage(skillName,enemyCasted)
	local minDmg = enemyCasted and enemyModel.minDmg or playerModel.minDmg
	local maxDmg = enemyCasted and enemyModel.maxDmg or playerModel.maxDmg
	local critPercent = enemyCasted and enemyModel.critPercent or playerModel.critPercent
	local critDmg = enemyCasted and enemyModel.critDmg or playerModel.critDmg 
	
	local critRand = math.random(1,100)
	local critMulti = critPercent >= critRand and critDmg or 1 
	
	local dmg =  math.floor( ((math.random(minDmg,maxDmg)) * skills.getDamage(skillName) * critMulti ) + 0.5) 
	
	return {dmg = dmg, crit = critMulti > 1}
end

function M.startCasting(skillId, enemyCasted)
	local castTime = skills.getCastTime(skillId)
	events.trigger(gameEvents.getStartCastingEvent(enemyCasted),skillId,castTime)
end

function M.attack(go_url,enemyCasted)
	local original_pos = go.get_position(go_url)
	local targetX = 600
	if enemyCasted then
		targetX = 680
	end
	local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

	local realSpeed = M.getRealSpeed(enemyCasted)

	local duration = realSpeed > 3 and 0.1 or 0.2

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, duration, 0, function()
		local dmg = M.calculate_damage(skills.EMPTY,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.BASIC, hitType.SFX.BASIC)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, duration)
	end)
end

function M.shield(go_url,enemyCasted)
	M.payResourceCost(skills.SHIELD, enemyCasted)
	M.addCd(skills.SHIELD,enemyCasted)
	if enemyCasted then
		enemyModel.addBuff(buffs.SHIELD,5)
	else
		playerModel.addBuff(buffs.SHIELD,5)
	end
	events.trigger(gameEvents.PLAY_SFX,"#laser")
end

function M.evasion(sprite_url,enemyCasted)
	M.payResourceCost(skills.EVASION, enemyCasted)
	M.addCd(skills.EVASION,enemyCasted)
	if enemyCasted then
	--	enemyModel.addBuff(buffs.EVASION,5)
	else
		go.animate(sprite_url, "tint.w", go.PLAYBACK_ONCE_FORWARD, 0.5, go.EASING_LINEAR, 0.2, 0)
		events.trigger(gameEvents.PLAY_PARTICLE_ON_PLAYER,"#evasion")
		playerModel.addBuff(buffs.EVASION,5)
		
	end
	events.trigger(gameEvents.PLAY_SFX,"#powerup4")
end

function M.enrage(enemyCasted)
	events.trigger(gameEvents.getEffectEvent(not enemyCasted),"enrage",-10,0,1,1)
	events.trigger(gameEvents.PLAY_SFX,"#powerup4")
	if not enemyCasted then	
		M.addCd(skills.ENRAGE,false)
	end 
	
	timer.delay(0.1, false, function()
		events.trigger(enemyCasted and gameEvents.ENRAGE_EFFECT_ON_ENEMY or gameEvents.ENRAGE_EFFECT_ON_PLAYER)
		if not enemyCasted then
			events.trigger(gameEvents.ADD_RAGE,30)
		end
		events.trigger(enemyCasted and gameEvents.ENEMY_HEAL or gameEvents.PLAYER_HEAL,15)
	end)
end

function M.lightning_bolt(go_url, enemyCasted)
	M.payResourceCost(skills.LIGHTNING_BOLT, enemyCasted)
	M.addCd(skills.LIGHTNING_BOLT,enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#thunder")
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"lightning_bolt",0,90,1,0.8,enemyCasted)
		--events.trigger(gameEvents.getProjectileEvent(enemyCasted),"lighning_bolt",0,0,1,1.5,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)

	timer.delay(0.3,false, function() 
		--if enemyCasted and not playerModel.hasBuff(buffs.SHIELD) and not playerModel.hasBuff(buffs.EVASION) then
	--		playerModel.addBuff(buffs.STUN,4)
	--	elseif not enemyCasted then
	--		enemyModel.addBuff(buffs.STUN,4)
--		end
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"electric_explosion",0,-40,1,0.6,enemyCasted)
		events.trigger(gameEvents.PLAY_SFX,"#explosion2")
		local dmg = M.calculate_damage(skills.LIGHTNING_BOLT,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING)

		print(playerModel.ultiCasting)

		if enemyCasted and not playerModel.hasBuff(buffs.SHIELD) and not playerModel.hasBuff(buffs.EVASION) and not playerModel.ultiCasting then
			events.trigger(gameEvents.INTERRUPT_PLAYER_CASTING)
			playerModel.addBuff(buffs.STUN,3)
		end
		if not enemyCasted and not enemyModel.hasBuff(buffs.SHIELD) and not enemyModel.hasBuff(buffs.EVASION) then
			events.trigger(gameEvents.INTERRUPT_ENEMY_CASTING)
			enemyModel.addBuff(buffs.STUN,3)
		end
	end)
end

function M.rocket_big(go_url, enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"rocket2",-65,25,90,0.4,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.rocket_big_impact(enemyCasted)
	local dmg = {dmg = 120, crit = true}
	events.trigger(gameEvents.getEffectEvent(enemyCasted),"explosion_big",0,0,0,1,enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#explosion_long")
	events.trigger(gameEvents.SHAKE_EFFECT,0.4,30)	
	events.trigger(gameEvents.FLASH_EFFECT, vmath.vector4(1,1,1,0))
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING,hitType.SFX.NONE)
end

function M.rocket(go_url, enemyCasted)
	--M.payResourceCost(skills.FIRE_BOLT, enemyCasted)
	--M.addCd(skills.FIRE_BOLT,enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"rocket",-65,25,90,0.35,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.rocket_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.FIRE_BOLT,enemyCasted)
	events.trigger(gameEvents.getEffectEvent(enemyCasted),"explosion",0,0,0,0.8,enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#explosion1")
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING,hitType.SFX.BASIC)
	if enemyCasted and not playerModel.hasBuff(buffs.SHIELD) and not playerModel.hasBuff(buffs.EVASION) then
		events.trigger(gameEvents.INTERRUPT_PLAYER_CASTING)
		playerModel.addBuff(buffs.STUN,2.5)
	elseif not enemyCasted then
		events.trigger(gameEvents.INTERRUPT_ENEMY_CASTING)
		enemyModel.addBuff(buffs.STUN,2.5)
	end
end

function M.shot(go_url, enemyCasted)
	--M.payResourceCost(skills.FIRE_BOLT, enemyCasted)
	--M.addCd(skills.FIRE_BOLT,enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	events.trigger(gameEvents.getEffectEvent(not enemyCasted),"shotBase",10,40,90,0.5,false,0.15)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"shot",0,40,90,0.5,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.shot_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.SHOT,enemyCasted)
	--events.trigger(gameEvents.getEffectEvent(enemyCasted),"explosion",0,0,0,0.8,enemyCasted)
	--events.trigger(gameEvents.PLAY_SFX,"#explosion1")
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.BASIC,hitType.SFX.BASIC)
end

function M.fire_bolt(go_url, enemyCasted)
	M.payResourceCost(skills.FIRE_BOLT, enemyCasted)
	M.addCd(skills.FIRE_BOLT,enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

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
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE,hitType.SFX.CRITONLY)
end

function M.arcane_bolt(go_url,enemyCasted)
	M.addCd(skills.ARCANE_BOLT,enemyCasted)
	M.payResourceCost(skills.ARCANE_BOLT, enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"arcane_bolt",0,0,1,0.3,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.arcane_bolt_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.ARCANE_BOLT,enemyCasted)
	events.trigger(gameEvents.getEffectEvent(enemyCasted),"hit3",0,0,0,0.8,enemyCasted)
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE,hitType.SFX.BASIC)
end

function M.frost_explosion(go_url,enemyCasted)
	M.addCd(skills.FROST_EXPLOSION,enemyCasted)
	M.payResourceCost(skills.FROST_EXPLOSION, enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.PLAY_SFX,"#wind")
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"wind",10,0,0,1,false,1.4,1.4)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)

	timer.delay(0.6, false, function() 
		local dmg = M.calculate_damage(skills.FROST_EXPLOSION,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE,hitType.SFX.BASIC)
	end)
	timer.delay(1, false, function() 
		local dmg = M.calculate_damage(skills.FROST_EXPLOSION,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE,hitType.SFX.BASIC)
	end)

	timer.delay(1.4, false, function() 
		local dmg = M.calculate_damage(skills.FROST_EXPLOSION,enemyCasted)
		events.trigger(gameEvents.getParticleEvent(enemyCasted),"#frost_bolt")
		events.trigger(gameEvents.PLAY_SFX,"#explosion2")
		if enemyCasted and not playerModel.hasBuff(buffs.SHIELD) and not playerModel.hasBuff(buffs.EVASION) then
			playerModel.addBuff(buffs.FROST,7)
			playerModel.addBuff(buffs.STUN,3)
		elseif not enemyCasted then
			enemyModel.addBuff(buffs.FROST,7)
			enemyModel.addBuff(buffs.STUN,3)
		end
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE,hitType.SFX.BASIC)
	end)
end

function M.frost_bolt(go_url,enemyCasted)
	M.addCd(skills.FROST_BOLT,enemyCasted)
	M.payResourceCost(skills.FROST_BOLT, enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.1, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#laser3")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"frost_bolt",0,0,1,0.8,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.1, 0)
	end)
end

function M.frost_bolt_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.FROST_BOLT,enemyCasted)
	events.trigger(gameEvents.getParticleEvent(enemyCasted),"#frost_bolt")
	events.trigger(gameEvents.PLAY_SFX,"#explosion2")
	if enemyCasted and not playerModel.hasBuff(buffs.SHIELD) and not playerModel.hasBuff(buffs.EVASION) then
		playerModel.addBuff(buffs.FROST,7)
	elseif not enemyCasted  then
		enemyModel.addBuff(buffs.FROST,7)
	end
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE,hitType.SFX.BASIC)
end

function M.wind_slash(go_url,enemyCasted)
	M.payResourceCost(skills.WIND_SLASH, enemyCasted)
	M.addCd(skills.WIND_SLASH,enemyCasted)
	local original_pos = go.get_position(go_url)
	local targetX = 600
	if enemyCasted then 
		targetX = 680
	end
	local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

	local realSpeed = M.getRealSpeed(enemyCasted)
	local duration = realSpeed > 3 and 0.1 or 0.2

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, duration, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#swoosh")
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"wind_slash",0,0,0,1,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, duration)
	end)

	timer.delay(duration+duration/2, false, function() 
		local dmg = M.calculate_damage(skills.WIND_SLASH,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING,hitType.SFX.BASIC)
		if not enemyCasted then
			events.trigger(gameEvents.ADD_CP,1)
		end
	end)
end

function M.double_cut(go_url,enemyCasted)
	M.payResourceCost(skills.DOUBLE_CUT, enemyCasted)
	M.addCd(skills.DOUBLE_CUT,enemyCasted)
	local original_pos = go.get_position(go_url)
	local targetX = 600
	if enemyCasted then 
		targetX = 680
	end
	local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

	local realSpeed = M.getRealSpeed(enemyCasted)
	local duration = realSpeed > 3 and 0.1 or 0.2

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, duration, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#doubleswoosh")
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"double_cut",0,0,0,1,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, duration)
	end)

	timer.delay(duration*0.75, false, function() 
		local dmg = M.calculate_damage(skills.DOUBLE_CUT,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING,hitType.SFX.BASIC)
	end)
	timer.delay(duration*1.5, false, function() 
		local dmg = M.calculate_damage(skills.DOUBLE_CUT,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING,hitType.SFX.BASIC)
	end)
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

	local realSpeed = M.getRealSpeed(enemyCasted)
	local duration = realSpeed > 3 and 0.1 or 0.2

	timer.delay(duration/2, false, function() 
		events.trigger(gameEvents.getEffectEvent(not enemyCasted),"lionstrike",enemyCasted and -120 or 120,0,0,1,enemyCasted)
		events.trigger(gameEvents.PLAY_SFX,"#swoosh3")
	end)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, duration, 0, function()
		--events.trigger(gameEvents.getEffectEvent(enemyCasted),"lionstrike",0,0,1,1,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, duration)
	end)

	timer.delay(duration, false, function() 
		local dmg = M.calculate_damage(skills.LION_STRIKE,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING, hitType.SFX.BASIC)
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

	local realSpeed = M.getRealSpeed(enemyCasted)
	local duration = realSpeed > 3 and 0.08 or 0.2
	
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos1.x, go.EASING_LINEAR, duration, 0)
	go.animate(go_url, "position.y", go.PLAYBACK_ONCE_FORWARD, target_pos1.y, go.EASING_LINEAR, duration, 0)
	go.animate(go_url, "position.y", go.PLAYBACK_ONCE_FORWARD, original_pos.y, go.EASING_LINEAR, duration/2, duration+duration/4,function()
		events.trigger(gameEvents.getEffectEvent(enemyCasted),"smoke",-10,-50,0,1.2)
		events.trigger(gameEvents.SHAKE_EFFECT,0.2,20)	
		events.trigger(gameEvents.PLAY_SFX,"#explosion1")
		local dmg = M.calculate_damage(skills.METEOR_SMASH,enemyCasted)
		events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE, hitType.SFX.CRITONLY)
		if enemyCasted and not playerModel.hasBuff(buffs.SHIELD) and not playerModel.hasBuff(buffs.EVASION) then
			events.trigger(gameEvents.INTERRUPT_PLAYER_CASTING)
			playerModel.addBuff(buffs.STUN,3)
		end
		if not enemyCasted and not enemyModel.hasBuff(buffs.SHIELD) and not enemyModel.hasBuff(buffs.EVASION) then
			events.trigger(gameEvents.INTERRUPT_ENEMY_CASTING)
			enemyModel.addBuff(buffs.STUN,3)
		end
	end)
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, duration, duration+duration*0.75)
end

function M.berserk(go_url,enemyCasted)
	M.payResourceCost(skills.BERSERK, enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#explosion_long2")
	events.trigger(gameEvents.SHAKE_EFFECT,0.2,20)	
	M.addCd(skills.BERSERK,enemyCasted)
	if enemyCasted then
		enemyModel.addBuff(buffs.BERSERK,6)
	else
		events.trigger(gameEvents.PLAY_SFX,"#sahur_ulti")
		playerModel.addBuff(buffs.BERSERK,6)
	end
end

function M.dark_patapim(sprite_url,enemyCasted)
	M.payResourceCost(skills.DARK_PATAPIM, enemyCasted)
	
	events.trigger(gameEvents.SHAKE_EFFECT,0.1,15)	
	events.trigger(gameEvents.PLAY_SFX,"#explosion_long")
	events.trigger(gameEvents.FLASH_EFFECT, vmath.vector4(0.2,0,0.2,0))
	sprite.play_flipbook(sprite_url, "darkpatapim")
	events.trigger(gameEvents.PLAY_PARTICLE_ON_PLAYER,"#dark")

	local healAmount = math.floor(playerModel.maxHp/2)
	events.trigger(gameEvents.PLAYER_HEAL,healAmount)
	
	playerModel.resetCDS()
	M.addCd(skills.DARK_PATAPIM,enemyCasted)
	playerModel.addBuff(buffs.DARK_PATAPIM,12)
end

function M.boneca_transform(sprite_url)
	events.trigger(gameEvents.PLAY_EFFECT_ON_ENEMY,"smoke",15,30,0,1.2)
	events.trigger(gameEvents.PLAY_SFX,"#poof")
	timer.delay(0.2, false, function()
		sprite.play_flipbook(sprite_url, "kerek")
	end)
end

function M.boneca_transform_back(sprite_url)
	events.trigger(gameEvents.PLAY_EFFECT_ON_ENEMY,"smoke",15,30,0,1.2)
	events.trigger(gameEvents.PLAY_SFX,"#poof")
	timer.delay(0.2, false, function()
		sprite.play_flipbook(sprite_url, "boneca")
	end)
end

function M.boneca_ulti(go_url,enemyCasted)
	if enemyCasted then 
		local original_pos = go.get_position(go_url)
		local targetX = -100
		local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

		events.trigger(gameEvents.PLAY_SFX,"#whoosh3")

		timer.delay(0.125, false, function() 
			local dmg = {dmg = 15, crit = false}
			events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.BASIC, hitType.SFX.CRITONLY)
		end)

		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.25, 0, function()
			local rightSideTransPos = vmath.vector3(1380,original_pos.y,original_pos.z)
			go.set_position(rightSideTransPos,go_url)
			go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_OUTSINE, 0.5, 0)
		end)
	end
end

function M.giga_punch(go_url)
	local original_pos = go.get_position(go_url)
	local targetX = 680
	local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		local dmg = M.calculate_damage(skills.GIGA_PUNCH,true)
		events.trigger(gameEvents.PLAYER_HURT,dmg,hitType.VFX.BASIC, hitType.SFX.BASIC)
		events.trigger(gameEvents.PLAY_SFX,"#explosion1")
		events.trigger(gameEvents.SHAKE_EFFECT,0.4,30)	
		if not playerModel.hasBuff(buffs.SHIELD) and not playerModel.hasBuff(buffs.EVASION) then
			playerModel.addBuff(buffs.STUN,1)
		end
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)
end

function M.fire_punch(go_url, enemyCasted)
	local original_pos = go.get_position(go_url)
	local targetX = -100
	local target_pos = vmath.vector3(targetX, original_pos.y, original_pos.z)

	events.trigger(gameEvents.PLAY_SFX,"#whoosh3")

	timer.delay(0.125, false, function() 
		
		events.trigger(gameEvents.getHurtEvent(enemyCasted),M.calculate_damage(skills.FIRE_PUNCH,enemyCasted),hitType.VFX.FLASHING, hitType.SFX.NONE)
		events.trigger(gameEvents.PLAY_SFX,"#explosion1")
		events.trigger(gameEvents.SHAKE_EFFECT,0.4,30)	
	end)

	events.trigger(gameEvents.PLAY_EFFECT_ON_ENEMY,"fire_punch",0,0,0,1.3, false, 0.28)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.25, 0, function()
		local rightSideTransPos = vmath.vector3(1380,original_pos.y,original_pos.z)
		go.set_position(rightSideTransPos,go_url)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_OUTSINE, 0.5, 0)
	end)
end

function M.kame_hame(go_url,enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#laser4")
	events.trigger(gameEvents.PLAY_EFFECT_ON_ENEMY,"kame_hame",-220,30,90,1.4, false, 0.5, 0, 0.7)
	events.trigger(gameEvents.FLASH_EFFECT,vmath.vector4(0.4,0.4,1,0))
	events.trigger(gameEvents.PLAY_SFX,"#explosion2")
	events.trigger(gameEvents.getHurtEvent(enemyCasted),M.calculate_damage(skills.KAME_HAME, enemyCasted),hitType.VFX.FLASHING, hitType.SFX.CRITONLY)
end

function M.poison_dagger(go_url, enemyCasted)
	M.payResourceCost(skills.POISON_DAGGER, enemyCasted)
	M.addCd(skills.POISON_DAGGER,enemyCasted)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(M.getShootTargetX(original_pos.x,enemyCasted), original_pos.y, original_pos.z)

	local realSpeed = M.getRealSpeed(enemyCasted)
	local duration = realSpeed > 3 and 0.1 or 0.05
	
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, duration, 0, function()
		events.trigger(gameEvents.PLAY_SFX,"#swoosh")
		events.trigger(gameEvents.getProjectileEvent(enemyCasted),"dagger",0,0,1,0.5,enemyCasted)
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, duration, 0)
	end)
end

function M.poison_dagger_impact(enemyCasted)
	local dmg = M.calculate_damage(skills.POISON_DAGGER,enemyCasted)
	events.trigger(gameEvents.getEffectEvent(enemyCasted),"poison_cloud",0,0,0,0.8,enemyCasted)
	events.trigger(gameEvents.PLAY_SFX,"#explosion3")
	events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.NONE,hitType.SFX.CRITONLY)
	if not enemyCasted then
		enemyModel.addBuff(buffs.POISON,5)
	else
		playerModel.addBuff(buffs.POISON,5)
	end
end

function M.blade_dance(sprite_url, enemyCasted)
	M.payResourceCost(skills.BLADE_DANCE, enemyCasted)
	M.addCd(skills.BLADE_DANCE,enemyCasted)
	go.animate(sprite_url, "tint.w", go.PLAYBACK_ONCE_FORWARD, 0, go.EASING_LINEAR, 0.5, 0)
	events.trigger(gameEvents.PLAY_SFX, "#poof")

	events.trigger(gameEvents.getEffectEvent(not enemyCasted),"smoke",0,0,0,1)
	events.trigger(gameEvents.getStartUltiCastingEvent(enemyCasted))

	local angles = {0,90,45,-90,0,-45,110,180,0,90,45,-90,0,}

	timer.delay(0.5, false, function () 
		events.trigger(gameEvents.PLAY_SFX, "#cappuccino_ulti")
		for i = 1, 13 do
			timer.delay(0.15*i, false, function() 
				events.trigger(gameEvents.PLAY_SFX,"#swoosh")
				events.trigger(gameEvents.getEffectEvent(enemyCasted),"wind_slash",0,0,angles[i],1,enemyCasted)
				local dmg = M.calculate_damage(skills.BLADE_DANCE,enemyCasted)
				events.trigger(gameEvents.getHurtEvent(enemyCasted),dmg,hitType.VFX.FLASHING,hitType.SFX.BASIC)
			end)
		end
	end)

	timer.delay(1 + 0.15*13, false, function()
		go.animate(sprite_url, "tint.w", go.PLAYBACK_ONCE_FORWARD, 1, go.EASING_LINEAR, 0.5, 0)
		events.trigger(gameEvents.PLAY_SFX, "#poof")
		events.trigger(gameEvents.getEffectEvent(not enemyCasted),"smoke",0,0,0,1)
		events.trigger(gameEvents.getEndUltiCastingEvent(enemyCasted))
	end)
	
end


return M