local M = {
	isGameOver = false,
	damageDone = 0,
	damageTaken = 0,
	enemiesDefeated = 0,
}

function M.setIsGameOver(val)
	M.isGameOver = val
end

function M.setDamageDone(val)
	M.damageDone = val
end

function M.setDamageTaken(val)
	M.damageTaken = val
end

function M.setEnemiesDefeated(val)
	M.enemiesDefeated = val
end

function M.reset()
	M.isGameOver = false;
	M.damageDone = 0;
	M.damageTaken = 0;
end

return M