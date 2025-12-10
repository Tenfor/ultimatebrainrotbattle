local skills = require("main/battle/skills")

local M = {
	gold = 0,
	sahur = {
		skill1 = {
			title = "Lion Strike",
			sprite = "LION_STRIKE",
			description = "Your next attack will deal extra damage",
			prices = {0},
			lvl = 1
		},
		skill2 = {
			title = "Meteor Smash",
			sprite = "METEOR_SMASH",
			description = "Your next attack will stun the enemy and deal extra damage",
			prices = {28},
			lvl = 0
		},
		skill3 = {
			title = "Enrage",
			sprite = "ENRAGE",
			description = "Generate 30 rage and restores 15 HP",
			prices = {55},
			lvl = 0
		},
		skill4 = {
			title = "Shields Up!",
			sprite = "SHIELD",
			description = "Block all incoming damage for 3 seconds",
			prices = {350},
			lvl = 0 
		},
		skill5 = {
			title = "TUNG TUNG TUNG",
			sprite = "BERSERK",
			description = "Increase attack speed by 300%",
			prices = {1000},
			lvl = 0
		},
		str = {
			title = "Strength",
			description = "",
			prices = {2,12,45,90,320,800,1200},
			values = {{1,3},{3,5},{5,7},{7,10},{11,17},{18,25},{26,35},{35,45}},
			lvl = 0, 
		},
		spd = {
			title = "Attack Speed",
			description = "",
			prices = {10,18,70,300,1500},
			values = {0.8,1.2,1.6,2,2.4,3},
			lvl = 0, 
		},
		hp = {
			title = "Max health",
			description = "",
			prices = {2,5,10,25,80,350,700,900,1500},
			values = {15,20,27,38,60,100,155,240,350,600},
			lvl = 0, 
		},
		crit = {
			title = "Critical Strike",
			description = "",
			prices = {10,150,500},
			values = {{1,1.5},{3,1.5},{6,2},{10,2}},
			lvl = 0, 
		},
		income = {
			title = "Income Bonus",
			description = "",
			prices = {40,400,800},
			values = {1,1.5,2,2.5},
			lvl = 0, 
		},
		rage = {
			title = "Starting Rage",
			description = "",
			prices = {20,100},
			values = {0,10,30},
			lvl = 0, 
		},
		listedStats = {
			"str","hp","spd","crit","income","rage"
		}
	},
}

function M.setGold(val)
	M.gold = val
end

return M