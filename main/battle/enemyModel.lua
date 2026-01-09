local buffs = require("main/battle/buffs")
local skills = require("main/battle/skills")
local enemy_data = require("main/battle/enemy_data")

local enemies = {
	BONECA = "BONECA",
	LIRILI = "LIRILI",
	DINDIN = "DINDIN",
	TRALLALERO = "TRALLALERO",
}

local M = {
	name = "boneca",
	critPercent = 2,
	critDmg = 2,
	spd = 1.5,
	minDmg = 2,
	maxDmg = 5,
	hp = 80,
	maxHp = 80,	
	buffs = {
		BERSERK = 0,
		FROST = 0,
		SHIELD = 0,
		STUN = 0,
		POISON = 0,
		EVASION = 0,
	},
	pattern = {
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.EMPTY,
		skills.BONECA_TRANSFORM,
		skills.BONECA_ULTI,
		skills.BONECA_TRANSFORM_BACK,
	},
	mod = 1,
	mocks = {
		"GG EZ!",
		"Let me give you an advice: GIT GUD!",
		"HAHA! Boneca Ambalagu is the best!"
	},
	startPos = {1530,276,0},
	enterPos = {830,276,0},
	scale = {1,1,0}
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

function M.loadEnemyModel(enemyName)
	local data = enemy_data.list[enemyName]
	if not data then 
		error("Enemy type not found: " .. tostring(enemyName))
	end
	M.name = data.name
	M.displayName = data.displayName
	M.sprite = data.sprite
	M.critPercent = data.critPercent
	M.critDmg = data.critDmg
	M.spd = data.spd
	M.minDmg = data.minDmg
	M.maxDmg = data.maxDmg
	M.hp = data.hp
	M.maxHp = data.hp
	M.buffs = {
		BERSERK = 0,
		FROST = 0,
		SHIELD = 0,
		STUN = 0,
		POISON = 0,
		EVASION = 0,
	}
	M.mod = 1
	M.pattern = data.pattern
	M.mocks = data.mocks	
	M.startPos = data.startPos
	M.enterPos = data.enterPos
	M.scale = data.scale
	M.castBarPos = data.castBarPos
end

return M