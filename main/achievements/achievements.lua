local M = {
	deaths = 0,
	dindinDefeated = false,
}

function M.setDeaths(val)
	M.deaths = val
end

function M.setDindinDefeated(val)
	M.dindinDefeated = val
end

function M.isCapUnlocked()
	return M.dindinDefeated
end

function M.isPatapimUnlocked()
	return M.deaths >= 10
end


return M