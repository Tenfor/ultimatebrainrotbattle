local M = {
	gold = 0,
	sahur = {
		skills = {
			
		},
		str = {
			title = "Strength",
			description = "",
			prices = {10,20,30,50,100},
			values = {{1,2},{3,5},{6,10},{11,17},{18,25}},
			lvl = 1, 
		},
		spd = {
			title = "Attack Speed",
			description = "",
			prices = {20,40,70,100,150},
			lvl = 1, 
		},
		hp = {
			title = "Max health",
			description = "",
			prices = {10,20,30,50,100},
			lvl = 1, 
		},
		crit = {
			title = "Critical Strike",
			description = "",
			prices = {10,20,30,50,100},
			lvl = 1, 
		},
		income = {
			title = "Income Bonus",
			description = "",
			prices = {10,20,30,50,100},
			lvl = 1, 
		},
		rage = {
			title = "Starting Rage",
			description = "",
			prices = {10,20,30,50,100},
			lvl = 1, 
		},
	},
}

function M.setGold(val)
	M.gold = val
end

return M