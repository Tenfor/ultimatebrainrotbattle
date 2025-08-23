local skills = require("main/battle/skills")
local buffs = require("main/battle/buffs")
local attackType = require("main/battle/attackType")

local M = {
	spd = 1,
	str = 1,
	mag = 1,
	hp = 100,
	maxHp = 100,
	skills = {
		skills.LION_STRIKE,
		skills.METEOR_SMASH,
		skills.BERSERK,
		skills.EMPTY,
		skills.EMPTY,
	},
	buffs = {
		BERSERK = 0
	},
	attackType = attackType.MELEE
}

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
		skills.LION_STRIKE,
		skills.METEOR_SMASH,
		skills.BERSERK,
		skills.EMPTY,
		skills.EMPTY,
	}
end

function M.loadCappucinoStats()
	M.spd = 3
	M.str = 1
	M.mag = 1
	M.hp = 80
	M.maxHp = 80
	M.attackType = attackType.MELEE
	M.skills = {
		skills.LION_STRIKE,
		skills.METEOR_SMASH,
		skills.BERSERK,
		skills.EMPTY,
		skills.EMPTY,
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
		skills.ARCANE_BOLT,
		skills.FIRE_BOLT,
		skills.FROST_BOLT,
		skills.EMPTY,
		skills.EMPTY,
	}
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