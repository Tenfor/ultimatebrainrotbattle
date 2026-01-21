local M = {
	deaths = 0,
	dindinDefeated = false,
	sahurMaxBoss = 0, 
	patapimMaxBoss = 0,
	cappuccinoMaxBoss = 0
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

function M.setSahurMaxBoss(val)
	M.sahurMaxBoss = M.sahurMaxBoss < val and val or M.sahurMaxBoss
end

function M.setPatapimMaxBoss(val)
	M.patapimMaxBoss = M.patapimMaxBoss < val and val or M.patapimMaxBoss
end

function M.setCappuccinoMaxBoss(val)
	M.cappuccinoMaxBoss = M.cappuccinoMaxBoss < val and val or M.cappuccinoMaxBoss
end

function M.enemyDefeated(currentCharacter, enemyName)
	local maxBossValue = 0
	if enemyName == "boneca" then 
		maxBossValue = 1
	end
	if enemyName == "frigo" then 
		maxBossValue = 2
	end
	if enemyName == "dindin" then 
		maxBossValue = 3
	end
	if enemyName == "superDindin" then 
		maxBossValue = 4
	end		

	if currentCharacter == "sahur" then
		M.setSahurMaxBoss(maxBossValue)
	end

	if currentCharacter == "patapim" then
		M.setPatapimMaxBoss(maxBossValue)
	end

	if currentCharacter == "cappuccino" then
		M.setCappuccinoMaxBoss(maxBossValue)
	end
end


return M