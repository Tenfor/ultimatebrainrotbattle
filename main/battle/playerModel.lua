local skills = require("main/battle/skills")
local buffs = require("main/battle/buffs")
local attackType = require("main/battle/attackType")
local resourceType = require("main/battle/resourceType")

local M = {
	spd = 1,
	str = 1,
	mag = 1,
	hp = 100,
	maxHp = 100,
	rage = 0, 
	maxRage = 100,
	mana = 100,
	maxMana = 100,
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
		FROST = 0
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

function M.setResource(val)
	if M.resourceType == resourceType.RAGE then
		M.setRage(val)
	elseif M.resourceType == resourceType.MANA then
		M.setMana(val)
	end
end

function M.getResource()
	if M.resourceType == resourceType.RAGE then
		return M.rage
	elseif M.resourceType == resourceType.MANA then
		return M.mana
	end
end

function M.getMaxResource()
	if M.resourceType == resourceType.RAGE then
		return M.maxRage
	elseif M.resourceType == resourceType.MANA then
		return M.maxMana
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
	M.spd = 1
	M.str = 3
	M.mag = 1
	M.hp = 100
	M.maxHp = 100
	M.attackType = attackType.MELEE
	M.skills = {
		{skillName = skills.LION_STRIKE, cd = 0, maxCd = 0},
		{skillName = skills.METEOR_SMASH, cd = 0, maxCd = 0},
		{skillName = skills.BERSERK, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
	}
	M.resourceType = resourceType.RAGE
	M.rage = 0
	M.maxRage = 100
	M.mana = 0
	M.maxMana = 0
end

function M.loadCappucinoStats()
	M.spd = 3
	M.str = 1
	M.mag = 1
	M.hp = 80
	M.maxHp = 80
	M.attackType = attackType.MELEE
	M.skills = {
		{skillName = skills.LION_STRIKE, cd = 0, maxCd = 0},
		{skillName = skills.METEOR_SMASH, cd = 0, maxCd = 0},
		{skillName = skills.BERSERK, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
	}
end

function M.loadPatapimStats()
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
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
		{skillName = skills.EMPTY, cd = 0, maxCd = 0},
	}
	M.resourceType = resourceType.MANA
	M.rage = 0
	M.maxRage = 0
	M.mana = 100
	M.maxMana = 100
end

function M.updateCDS(dt)
	for i = 1, #M.skills do
		if(M.skills[i].cd > 0) then 
			M.skills[i].cd = M.skills[i].cd - dt
		end
	end
	if M.globalCd > 0 then
		M.globalCd = M.globalCd - dt
	end
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