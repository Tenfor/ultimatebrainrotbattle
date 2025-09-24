local skills = require("main/battle/skills")
local buffs = require("main/battle/buffs")
local attackType = require("main/battle/attackType")
local resourceType = require("main/battle/resourceType")

local M = {
	critPercent = 1,
	critDmg = 1.5,
	spd = 1,
	str = 1,
	mag = 1,
	hp = 100,
	maxHp = 100,
	rage = 0, 
	maxRage = 100,
	mana = 100,
	maxMana = 100,
	combopoints = 0,
	maxCombopoints = 5,
	skills = {
		{skillName = skills.LION_STRIKE, cd = 0, maxCd = 0},
		{skillName = skills.METEOR_SMASH, cd = 0, maxCd = 0},
		{skillName = skills.BERSERK, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
	},
	globalCd = 0,
	buffs = {
		BERSERK = 0,
		FROST = 0,
		SHIELD = 0,
		STUN = 0,
		DARK_PATAPIM = 0
	},
	attackType = attackType.MELEE,
	resourceType = resourceType.RAGE
}

function M.setRage(val) 
	M.rage = val 
	if(M.rage < 0) then
		M.rage = 0
	end
	if(M.rage > M.maxRage) then 
		M.rage = M.maxRage
	end
end

function M.setMana(val) 
	M.mana = val 
	if(M.mana < 0) then
		M.mana = 0
	end
	if(M.mana > M.maxMana) then 
		M.mana = M.maxMana
	end
end

function M.setCp(val) 
	M.combopoints = val 
	if(M.combopoints < 0) then
		M.combopoints = 0
	end
	if(M.combopoints > M.maxCombopoints) then 
		M.combopoints = M.maxCombopoints
	end
end

function M.setResource(val)
	if M.resourceType == resourceType.RAGE then
		M.setRage(val)
	elseif M.resourceType == resourceType.MANA then
		M.setMana(val)
	elseif M.resourceType == resourceType.COMBOPOINT then
		M.setCp(val)
	end
end

function M.getResource()
	if M.resourceType == resourceType.RAGE then
		return M.rage
	elseif M.resourceType == resourceType.MANA then
		return M.mana
	elseif M.resourceType == resourceType.COMBOPOINT then
		return M.combopoints
	end
end

function M.getMaxResource()
	if M.resourceType == resourceType.RAGE then
		return M.maxRage
	elseif M.resourceType == resourceType.MANA then
		return M.maxMana
	elseif M.resourceType == resourceType.COMBOPOINT then
		return M.maxCombopoints
	end
end

function M.setSpd(val)
	M.spd = val
end

function M.setStr(val)
	M.str = val
end

function M.setHp(val)
	M.hp = val
end

function M.loadSahurStats()
	M.critPercent = 3
	M.critDmg = 1.5
	M.spd = 1
	M.str = 3
	M.mag = 1
	M.hp = 100
	M.maxHp = 100
	M.attackType = attackType.MELEE
	M.skills = {
		{skillName = skills.LION_STRIKE, cd = 0, maxCd = 0},
		{skillName = skills.METEOR_SMASH, cd = 0, maxCd = 0},
		{skillName = skills.ENRAGE, cd = 0, maxCd = 0},
		{skillName = skills.SHIELD, cd = 0, maxCd = 0},
		{skillName = skills.BERSERK, cd = 0, maxCd = 0},
	}
	M.globalCd = 0
	M.buffs = {
		BERSERK = 0,
		FROST = 0,
		SHIELD = 0,
		STUN = 0,
		DARK_PATAPIM = 0
	}
	M.resourceType = resourceType.RAGE
	M.rage = 0
	M.maxRage = 100
	M.mana = 0
	M.maxMana = 0
	M.combopoints = 0
	M.maxCombopoints = 0
end

function M.loadCappucinoStats()
	M.critPercent = 3
	M.critDmg = 2
	M.spd = 3
	M.str = 1
	M.mag = 1
	M.hp = 80
	M.maxHp = 80
	M.attackType = attackType.MELEE
	M.skills = {
		{skillName = skills.WIND_SLASH, cd = 0, maxCd = 0},
		{skillName = skills.DOUBLE_CUT, cd = 0, maxCd = 0},
		{skillName = skills.BERSERK, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
	}
	M.globalCd = 0
	M.buffs = {
		BERSERK = 0,
		FROST = 0,
		SHIELD = 0,
		STUN = 0,
		DARK_PATAPIM = 0
	}
	M.rage = 0
	M.maxRage = 0
	M.mana = 0
	M.maxMana = 0
	M.combopoints = 0
	M.maxCombopoints = 5
	M.resourceType = resourceType.COMBOPOINT
end

function M.loadPatapimStats()
	M.critPercent = 3
	M.critDmg = 1.5
	M.spd = 1
	M.str = 1
	M.mag = 3
	M.hp = 75
	M.maxHp = 75
	M.attackType = attackType.MAGIC
	M.skills = {
		{skillName = skills.ARCANE_BOLT, cd = 0, maxCd = 0},
		{skillName = skills.FIRE_BOLT, cd = 0, maxCd = 0},
		{skillName = skills.FROST_BOLT, cd = 0, maxCd = 0},
		{skillName = skills.LIGHTNING_BOLT, cd = 0, maxCd = 0},
		{skillName = skills.DARK_PATAPIM, cd = 0, maxCd = 0},
	}
	M.globalCd = 0
	M.buffs = {
		BERSERK = 0,
		FROST = 0,
		SHIELD = 0,
		STUN = 0,
		DARK_PATAPIM = 0
	}
	M.resourceType = resourceType.MANA
	M.rage = 0
	M.maxRage = 0
	M.mana = 100
	M.maxMana = 100
	M.combopoints = 0
	M.maxCombopoints = 0
end

function M.updateCDS(dt)
	local modifiedDt = M.hasBuff(buffs.DARK_PATAPIM) and dt*2 or dt
	for i = 1, #M.skills do
		if(M.skills[i].cd > 0) then 
			M.skills[i].cd = M.skills[i].cd - modifiedDt
		end
	end
	if M.globalCd > 0 then
		M.globalCd = M.globalCd - modifiedDt
	end
end

function M.resetCDS()
	for i = 1, #M.skills do
		if(M.skills[i].cd > 0) then 
			M.skills[i].cd = 0
		end
	end
	M.globalCd = 0
end

function M.updateBuffs(dt)
	for name, duration in pairs(M.buffs) do
		if M.buffs[name] > 0 then 
			local updatedDuration = duration - dt
			M.buffs[name] = updatedDuration
		end
	end
end

function M.addBuff(buff,duration)
	if M.buffs[buff] ~= nil then 
		M.buffs[buff] = duration
	end
end

function M.hasBuff(buff)
	return  M.buffs[buff] ~= nil and M.buffs[buff] > 0
end

function M.removeBuff(buff)
	if M.buffs[buff] ~= nil then 
		M.buffs[buff] = 0
	end
end

return M