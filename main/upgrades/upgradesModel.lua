local skills = require("main/battle/skills")

local M = {
	--SAHUR
	sahur = {
		gold = 0,
		skill1 = {
			name = "skill1",
			title = "Lion Strike",
			sprite = "LION_STRIKE",
			description = "Your next attack will deal extra damage",
			prices = {0},
			lvl = 1
		},
		skill2 = {
			name = "skill2",
			title = "Meteor Smash",
			sprite = "METEOR_SMASH",
			description = "Your next attack will stun the enemy and deal extra damage",
			prices = {28},
			lvl = 0
		},
		skill3 = {
			name = "skill3",
			title = "Enrage",
			sprite = "ENRAGE",
			description = "Generate 30 rage and restores 15 HP",
			prices = {55},
			lvl = 0
		},
		skill4 = {
			name = "skill4",
			title = "Shields Up!",
			sprite = "SHIELD",
			description = "Block all incoming damage for 3 seconds",
			prices = {350},
			lvl = 0 
		},
		skill5 = {
			name = "skill5",
			title = "TUNG TUNG TUNG",
			sprite = "BERSERK",
			description = "Increase attack speed by 300%",
			prices = {1000},
			lvl = 0
		},
		skill6 = {
			name = "skill5",
			title = "TUNG TUNG TUNG",
			sprite = "BERSERK",
			description = "Increase attack speed by 300%",
			prices = {1000},
			lvl = 0
		},
		str = {
			name = "str",
			title = "Strength",
			description = "Current: {curr} dmg",
			descriptionNext = "Next: {next} dmg",
			prices = {2,12,45,90,320,800,1100,1800},
			values = {{1,3},{3,5},{5,7},{7,10},{11,17},{18,25},{26,35},{35,45},{55,65}},
			lvl = 0, 
		},
		spd = {
			name = "spd",
			title = "Attack Speed",
			description = "Current: {curr}/sec",
			descriptionNext = "Next: {next}/sec",
			prices = {10,18,70,300,1400,2200},
			values = {0.8,1.2,1.6,2,2.4,2.9,3.4},
			lvl = 0, 
		},
		hp = {
			name = "hp",
			title = "Max health",
			description = "Current: {curr}",
			descriptionNext = "Next: {next}",
			prices = {2,5,10,25,80,350,700,900,1300,1800,2200},
			values = {15,20,27,38,60,100,155,240,350,550,800,1200},
			lvl = 0, 
		},
		crit = {
			name = "crit",
			title = "Critical Strike",
			description = "Current: {curr} dmg",
			descriptionNext = "Next: {next} dmg",
			prices = {10,150,500},
			values = {{1,1.5},{3,1.5},{6,2},{10,2}},
			lvl = 0, 
		},
		income = {
			name = "income",
			title = "Income Bonus",
			description = "Current: {curr}X gold",
			descriptionNext = "Next: {next}X gold",
			prices = {20,40,400,800},
			values = {1,1.2,1.5,2,2.5},
			lvl = 0, 
		},
		rage = {
			name = "rage",
			title = "Starting Rage",
			description = "Current: {curr}",
			descriptionNext = "Next: {next}",
			prices = {20,100},
			values = {0,10,30},
			lvl = 0, 
		},
		listedStats = {
			"str","hp","spd","crit","income","rage"
		}
	},
	--PATAPIM
	patapim = {
		gold = 0,
		skill1 = {
			name = "skill1",
			title = "Arcane Blast",
			sprite = "ARCANE_BOLT",
			description = "Shoot an arcane projectile that deals base damage",
			prices = {0},
			lvl = 1
		},
		skill2 = {
			name = "skill2",
			title = "Fire Ball",
			sprite = "FIRE_BOLT",
			description = "Shoot a fire projectile that deals extra damage",
			prices = {0},
			lvl = 1
		},
		skill3 = {
			name = "skill3",
			title = "Frost Bolt",
			sprite = "FROST_BOLT",
			description = "Shoot a frost projectile that deals extra damage and slows the enemy",
			prices = {30},
			lvl = 0
		},
		skill4 = {
			name = "skill4",
			title = "Lightning Strike!",
			sprite = "LIGHTNING_BOLT",
			description = "Has a short cast time. Deals extra damage and a stuns the enemy. Stun will interrupt enemy casting.",
			prices = {100},
			lvl = 0 
		},
		skill5 = {
			name = "skill5",
			title = "Dark Patapim",
			sprite = "DARK_PATAPIM",
			description = "Reduce all cooldown and cast time. Heal 50% of your hp.",
			prices = {800},
			lvl = 0
		},
		skill6 = {
			name = "skill6",
			title = "Comet Rain",
			sprite = "COMET_RAIN",
			description = "Has a long cast time. Deals a massive amount of damage and stuns the enemy. Stun will interrupt enemy casting.",
			prices = {1000},
			lvl = 0
		},
		pow = {
			name = "pow",
			title = "Spell Power",
			description = "Current: {curr} dmg",
			descriptionNext = "Next: {next} dmg",
			prices = {4,12,45,90,300,450,1100,1800},
			values = {{2,4},{4,6},{6,9},{11,13},{14,18},{19,27},{28,38},{39,51},{56,75}},
			lvl = 0, 
		},
		hp = {
			name = "hp",
			title = "Max health",
			description = "Current: {curr}",
			descriptionNext = "Next: {next}",
			prices = {3,10,15,30,80,280,380,900,1300,1800,2200},
			values = {12,18,25,35,55,90,140,230,330,530,780,1100},
			lvl = 0, 
		},
		mana = {
			name = "mana",
			title = "Max Mana",
			description = "Current: {curr}",
			descriptionNext = "Next: {next}",
			prices = {8,25,120,200,310,500},
			values = {10,20,45,85,130,200,400},
			lvl = 0, 
		},
		cdr = {
			name = "cdr",
			title = "CD Reduction",
			description = "Current: {curr}%",
			descriptionNext = "Next: {next}%",
			prices = {4,18,115,300},
			values = {0,10,20,30,50},
			lvl = 0, 
		},
		crit = {
			name = "crit",
			title = "Critical Strike",
			description = "Current: {curr} dmg",
			descriptionNext = "Next: {next} dmg",
			prices = {12,120,450},
			values = {{1,1.5},{5,1.5},{8,2},{15,2}},
			lvl = 0, 
		},
		income = {
			name = "income",
			title = "Income Bonus",
			description = "Current: {curr}X gold",
			descriptionNext = "Next: {next}X gold",
			prices = {20,40,400,800},
			values = {1,1.2,1.5,2,2.5},
			lvl = 0, 
		},
		listedStats = {
			"pow","hp","mana","cdr","crit","income"
		}
	},
	--CAPPUCCINO
	cappuccino = {
		gold = 0,
		skill1 = {
			name = "skill1",
			title = "Wind Slash",
			sprite = "WIND_SLASH",
			description = "1.5X extra dmg and generate a combopoint.",
			prices = {0},
			lvl = 1
		},
		skill2 = {
			name = "skill2",
			title = "Double Cut",
			sprite = "DOUBLE_CUT",
			description = "Consume 1 combopoints. Cut the enemy twice each 1.25x dmg.",
			prices = {15},
			lvl = 0
		},
		skill3 = {
			name = "skill3",
			title = "Evasion",
			sprite = "EVASION",
			description = "Evade every attack for 4 sec, gain 1 combopoint for each evaded attacks.",
			prices = {50},
			lvl = 0
		},
		skill4 = {
			name = "skill4",
			title = "Poison Dagger",
			sprite = "POISON_DAGGER",
			description = "Consume 2 combopoints. Deals 1x dmg immediately then 4x damage over 4 sec.",
			prices = {250},
			lvl = 0
		},
		skill5 = {
			name = "skill5",
			title = "Blade Dance",
			sprite = "BLADE_DANCE",
			description = "Consume 5 combopoints. Has a short cast time. cut the enemy 13 times each 0.25x dmg",
			prices = {1000},
			lvl = 0
		},
		skill6 = {
			name = "skill6",
			title = "Blade Dance",
			sprite = "BLADE_DANCE",
			description = "Reduce all cooldown and cast time. Heal 50% of your hp.",
			prices = {1000},
			lvl = 0
		},

		str = {
			name = "str",
			title = "Strength",
			description = "Current: {curr} dmg",
			descriptionNext = "Next: {next} dmg",
			prices = {4,18,45,90,250,450,1050,1800},
			values = {{1,3},{3,5},{5,7},{7,9},{10,16},{16,24},{24,34},{34,42},{45,62}},
			lvl = 0, 
		},
		spd = {
			name = "spd",
			title = "Attack Speed",
			description = "Current: {curr}/sec",
			descriptionNext = "Next: {next}/sec",
			prices = {2,12,60,180,1100,2200},
			values = {1,1.4,1.8,2.3,2.7,3.3,4},
			lvl = 0, 
		},
		hp = {
			name = "hp",
			title = "Max health",
			description = "Current: {curr}",
			descriptionNext = "Next: {next}",
			prices = {4,10,15,30,80,240,380,950,1200,1800,2200},
			values = {15,20,26,36,55,95,145,235,335,540,790,1150},
			lvl = 0, 
		},
		crit = {
			name = "crit",
			title = "Critical Strike",
			description = "Current: {curr} dmg",
			descriptionNext = "Next: {next} dmg",
			prices = {3,80,300,600,1050},
			values = {{1,1.5},{5,1.5},{8,2},{15,2},{20,2.5},{25,3}},
			lvl = 0, 
		},
		precision = {
			name = "precision",
			title = "Precision",
			description = "Each critical strike will give a combopoint",
			--descriptionNext = "Next: {next} dmg",
			prices = {100},
			values = {0,1},
			lvl = 0, 
		},
		income = {
			name = "income",
			title = "Income Bonus",
			description = "Current: {curr}X gold",
			descriptionNext = "Next: {next}X gold",
			prices = {20,40,400,800},
			values = {1,1.2,1.5,2,2.5},
			lvl = 0, 
		},
		listedStats = {
			"str","hp","spd","crit","precision","income"
		}
	},
}

return M