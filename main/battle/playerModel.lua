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

function M.loadSahurStats()
	M.spd = 1
	M.str = 2
	M.mag = 1
	M.hp = 100
	M.maxHp = 100
end

function M.loadCappucinoStats()
	M.spd = 2
	M.str = 1
	M.mag = 1
	M.hp = 80
	M.maxHp = 80
end

function M.loadPatapimStats()
	M.spd = 1
	M.str = 1
	M.mag = 2
	M.hp = 75
	M.maxHp = 75
end

return M