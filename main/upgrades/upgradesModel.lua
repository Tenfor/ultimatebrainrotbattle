local skills = require("main/battle/skills")

local M = {
	canWatchAd = false,
	--SAHUR
	sahur = {
		gold = 0,
		skill1 = {
			name = "skill1",
			title = "IDS_LION_TITLE",
			sprite = "LION_STRIKE",
			description = "IDS_LION_DESC",
			prices = {0},
			lvl = 1
		},
		skill2 = {
			name = "skill2",
			title = "IDS_METEOR_TITLE",
			sprite = "METEOR_SMASH",
			description = "IDS_METEOR_DESC",
			prices = {28},
			lvl = 0
		},
		skill3 = {
			name = "skill3",
			title = "IDS_ENRAGE_TITLE",
			sprite = "ENRAGE",
			description = "IDS_ENRAGE_DESC",
			prices = {55},
			lvl = 0
		},
		skill4 = {
			name = "skill4",
			title = "IDS_SHIELD_TITLE",
			sprite = "SHIELD",
			description = "IDS_SHIELD_DESC",
			prices = {350},
			lvl = 0 
		},
		skill5 = {
			name = "skill5",
			title = "IDS_BERSERK_TITLE",
			sprite = "BERSERK",
			description = "IDS_BERSERK_DESC",
			prices = {1000},
			lvl = 0
		},
		skill6 = {
			name = "skill5",
			title = "IDS_BERSERK_TITLE",
			sprite = "BERSERK",
			description = "IDS_BERSERK_DESC",
			prices = {1000},
			lvl = 0
		},
		str = {
			name = "str",
			title = "IDS_STR_TITLE",
			description = "IDS_STR_DESC",
			descriptionNext = "Next: {next} dmg",
			prices = {2,12,45,90,320,800,1100,1800},
			values = {{1,3},{3,5},{5,7},{7,10},{11,17},{18,25},{26,35},{35,45},{55,65}},
			lvl = 0, 
		},
		spd = {
			name = "spd",
			title = "IDS_SPD_TITLE",
			description = "IDS_SPD_DESC",
			prices = {10,18,70,300,1400,2200},
			values = {0.8,1.2,1.6,2,2.4,2.9,3.4},
			lvl = 0, 
		},
		hp = {
			name = "hp",
			title = "IDS_HP_TITLE",
			description = "IDS_HP_DESC",
			prices = {2,5,10,25,80,350,700,900,1300,1800,2200},
			values = {15,20,27,38,60,100,155,240,350,550,800,1200},
			lvl = 0, 
		},
		crit = {
			name = "crit",
			title = "IDS_CRIT_TITLE",
			description = "IDS_CRIT_DESC",
			prices = {10,150,500},
			values = {{1,1.5},{3,1.5},{6,2},{10,2}},
			lvl = 0, 
		},
		income = {
			name = "income",
			title = "IDS_INCOME_TITLE",
			description = "IDS_INCOME_DESC",
			prices = {20,40,400,800},
			values = {1,1.2,1.5,2,2.5},
			lvl = 0, 
		},
		rage = {
			name = "rage",
			title = "IDS_RAGE_TITLE",
			description = "IDS_RAGE_DESC",
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
			title = "IDS_ARCANE_TITLE",
			sprite = "ARCANE_BOLT",
			description = "IDS_ARCANE_DESC",
			prices = {0},
			lvl = 1
		},
		skill2 = {
			name = "skill2",
			title = "IDS_FIRE_TITLE",
			sprite = "FIRE_BOLT",
			description = "IDS_FIRE_DESC",
			prices = {0},
			lvl = 1
		},
		skill3 = {
			name = "skill3",
			title = "IDS_FROST_TITLE",
			sprite = "FROST_BOLT",
			description = "IDS_FROST_DESC",
			prices = {30},
			lvl = 0
		},
		skill4 = {
			name = "skill4",
			title = "IDS_LIGHTNING_TITLE",
			sprite = "LIGHTNING_BOLT",
			description = "IDS_LIGHTNING_DESC",
			prices = {100},
			lvl = 0 
		},
		skill5 = {
			name = "skill5",
			title = "IDS_DARK_TITLE",
			sprite = "DARK_PATAPIM",
			description = "IDS_DARK_DESC",
			prices = {800},
			lvl = 0
		},
		skill6 = {
			name = "skill6",
			title = "IDS_COMET_TITLE",
			sprite = "COMET_RAIN",
			description = "IDS_COMET_DESC",
			prices = {1000},
			lvl = 0
		},
		pow = {
			name = "pow",
			title = "IDS_POW_TITLE",
			description = "IDS_POW_DESC",
			prices = {4,12,45,90,300,450,1100,1800},
			values = {{2,4},{4,6},{6,9},{11,13},{14,18},{19,27},{28,38},{39,51},{56,75}},
			lvl = 0, 
		},
		hp = {
			name = "hp",
			title = "IDS_HP_TITLE",
			description = "IDS_HP_DESC",
			prices = {3,10,15,30,80,280,380,900,1300,1800,2200},
			values = {12,18,25,35,55,90,140,230,330,530,780,1100},
			lvl = 0, 
		},
		mana = {
			name = "mana",
			title = "IDS_MANA_TITLE",
			description = "IDS_MANA_DESC",
			prices = {8,25,120,200,310,500},
			values = {10,20,45,85,130,200,450},
			lvl = 0, 
		},
		cdr = {
			name = "cdr",
			title = "IDS_CDR_TITLE",
			description = "IDS_CDR_DESC",
			prices = {4,18,115,300},
			values = {0,10,20,30,50},
			lvl = 0, 
		},
		crit = {
			name = "crit",
			title = "IDS_CRIT_TITLE",
			description = "IDS_CRIT_DESC",
			prices = {12,120,450},
			values = {{1,1.5},{5,1.5},{8,2},{15,2}},
			lvl = 0, 
		},
		income = {
			name = "income",
			title = "IDS_INCOME_TITLE",
			description = "IDS_INCOME_DESC",
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
			title = "IDS_WIND_TITLE",
			sprite = "WIND_SLASH",
			description = "IDS_WIND_DESC",
			prices = {0},
			lvl = 1
		},
		skill2 = {
			name = "skill2",
			title = "IDS_DOUBLE_CUT_TITLE",
			sprite = "DOUBLE_CUT",
			description = "IDS_DOUBLE_CUT_DESC",
			prices = {15},
			lvl = 0
		},
		skill3 = {
			name = "skill3",
			title = "IDS_EVASION_TITLE",
			sprite = "EVASION",
			description = "IDS_EVASION_DESC",
			prices = {50},
			lvl = 0
		},
		skill4 = {
			name = "skill4",
			title = "IDS_POISON_TITLE",
			sprite = "POISON_DAGGER",
			description = "IDS_POISON_DESC",
			prices = {250},
			lvl = 0
		},
		skill5 = {
			name = "skill5",
			title = "IDS_BLADE_TITLE",
			sprite = "BLADE_DANCE",
			description = "IDS_BLADE_DESC",
			prices = {1000},
			lvl = 0
		},
		skill6 = {
			name = "skill6",
			title = "IDS_BLADE_TITLE",
			sprite = "BLADE_DANCE",
			description = "IDS_BLADE_DESC",
			prices = {1000},
			lvl = 0
		},

		str = {
			name = "str",
			title = "IDS_STR_TITLE",
			description = "IDS_STR_DESC",
			prices = {4,18,45,90,250,450,1050,1800},
			values = {{1,3},{3,5},{5,7},{7,9},{10,16},{16,24},{24,34},{34,42},{45,62}},
			lvl = 0, 
		},
		spd = {
			name = "spd",
			title = "IDS_SPD_TITLE",
			description = "IDS_SPD_DESC",
			prices = {2,12,60,180,1100,2200},
			values = {1,1.4,1.8,2.3,2.7,3.3,4},
			lvl = 0, 
		},
		hp = {
			name = "hp",
			title = "IDS_HP_TITLE",
			description = "IDS_HP_DESC",
			prices = {4,10,15,30,80,240,380,950,1200,1800,2200},
			values = {15,20,26,36,55,95,145,235,335,540,790,1150},
			lvl = 0, 
		},
		crit = {
			name = "crit",
			title = "IDS_CRIT_TITLE",
			description = "IDS_CRIT_DESC",
			prices = {3,80,300,600,1050},
			values = {{1,1.5},{5,1.5},{8,2},{15,2},{20,2.5},{25,3}},
			lvl = 0, 
		},
		precision = {
			name = "precision",
			title = "IDS_PRECISION_TITLE",
			description = "IDS_PRECISION_DESC",
			--descriptionNext = "Next: {next} dmg",
			prices = {100},
			values = {0,1},
			lvl = 0, 
		},
		income = {
			name = "income",
			title = "IDS_INCOME_TITLE",
			description = "IDS_INCOME_DESC",
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