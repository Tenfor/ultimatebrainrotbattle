local M = {
	spd = 1,
	str = 1,
	mag = 1,
	hp = 100,
	maxHp = 100,	
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

return M