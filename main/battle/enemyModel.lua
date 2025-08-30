local buffs = require("main/battle/buffs")
local skills = require("main/battle/skills")

local M = {
	spd = 1,
	str = 1,
	mag = 1,
	hp = 100,
	maxHp = 100,	
	buffs = {
		BERSERK = 0,
		FROST = 0
	},
	pattern = {
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.LION_STRIKE,
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.METEOR_SMASH,
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.BERSERK,
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY
	},
	mod = 1
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

function M.loadEnemyModel(stats)
	M.spd = stats.spd or 1
	M.str = stats.str or 1
	M.mag = stats.mag or 1
	M.maxHp = stats.maxHp or 100
	M.hp = M.maxHp
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