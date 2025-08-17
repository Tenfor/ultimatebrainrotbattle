local playerSkills = require("main/battle/playerSkills")
local buffs = require("main/battle/buffs")

local M = {
	spd = 1,
	str = 1,
	mag = 1,
	hp = 100,
	maxHp = 100,
	skills = {
		playerSkills.LION_STRIKE,
		playerSkills.METEOR_SMASH,
		playerSkills.BERSERK,
		playerSkills.EMPTY,
		playerSkills.EMPTY,
	},
	buffs = {
		BERSERK = 0
	}
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
end

function M.loadCappucinoStats()
	M.spd = 3
	M.str = 1
	M.mag = 1
	M.hp = 80
	M.maxHp = 80
end

function M.loadPatapimStats()
	M.spd = 1
	M.str = 1
	M.mag = 3
	M.hp = 75
	M.maxHp = 75
end

function M.updateBuffs(dt)
	for name, duration in pairs(M.buffs) do
		if M.buffs[name] > 0 then 
			local updatedDuration = duration - dt
			M.buffs[name] = updatedDuration
			print(M.buffs[name],updatedDuration)
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