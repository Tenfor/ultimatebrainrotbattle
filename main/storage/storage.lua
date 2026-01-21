local bridge = require("bridge.bridge")
local settingsModel = require("main/settings/settingsModel")
local achievements = require("main/achievements/achievements")
local tutorial = require("main/tutorial/tutorial")
local upgradesModel = require("main/upgrades/upgradesModel")

local M = {}


function M.saveData()
	bridge.storage.delete(
	{ 
		--SETTINGS
		"sound","music","lang","hotkeys",
		--ACHIEVEMENTS
		"deaths", "dindinDefeated", "sahurMaxBoss", "patapimMaxBoss", "cappuccinoMaxBoss",
		--TUTORIAL
		"tut1","tut2","tut3","tut4","tut5",
		--UPGRADES
		--SAHUR UPGRADES
		"sahurSkill1", "sahurSkill2", "sahurSkill3", "sahurSkill4", "sahurSkill5", 
		"sahurStr", "sahurHp", "sahurSpd", "sahurCrit", "sahurIncome", "sahurRage", "sahurGold",
		--PATAPIM UPGRADES
		"patapimSkill1", "patapimSkill2", "patapimSkill3", "patapimSkill4", "patapimSkill5", "patapimSkill6", 
		"patapimPow", "patapimHp", "patapimMana", "patapimCdr", "patapimCrit", "patapimIncome", "patapimGold",
		--CAPPUCCINO UPGRADES
		"cappuccinoSkill1", "appuccinoSkill2", "cappuccinoSkill3", "appuccinoSkill4", "cappuccinoSkill5",
		"cappuccinoStr", "cappuccinoHp", "cappuccinoSpd", "cappuccinoCrit", "cappuccinoIncome", "cappuccinoPrecision", "cappuccinoGold",
	},
	function ()
		print("saveData",achievements.sahurMaxBoss)
		bridge.storage.set({
			--SETTINGS
			sound = settingsModel.sound and "on" or "off",
			music = settingsModel.music and "on" or "off",
			lang = settingsModel.lang,
			hotkeys = settingsModel.hotkeys,
			--ACHIEVEMENTS
			deaths = achievements.deaths,
			dindinDefeated = achievements.dindinDefeated,
			sahurMaxBoss = achievements.sahurMaxBoss,
			patapimMaxBoss = achievements.patapimMaxBoss,
			cappuccinoMaxBoss = achievements.cappuccinoMaxBoss,
			--TUTORIAL
			tut1 = tutorial.tutorial1.seen,
			tut2 = tutorial.tutorial2.seen,
			tut3 = tutorial.tutorial3.seen,
			tut4 = tutorial.tutorial4.seen,
			tut5 = tutorial.tutorial5.seen,
			--SAHUR SKILLS
			sahurSkill1 = upgradesModel.sahur.skill1.lvl,
			sahurSkill2 = upgradesModel.sahur.skill2.lvl,
			sahurSkill3 = upgradesModel.sahur.skill3.lvl,
			sahurSkill4 = upgradesModel.sahur.skill4.lvl,
			sahurSkill5 = upgradesModel.sahur.skill5.lvl,
			--SAHUR STATS
			sahurStr = upgradesModel.sahur.str.lvl,
			sahurHp = upgradesModel.sahur.hp.lvl,
			sahurSpd = upgradesModel.sahur.spd.lvl,
			sahurCrit = upgradesModel.sahur.crit.lvl,
			sahurIncome = upgradesModel.sahur.income.lvl,
			sahurRage = upgradesModel.sahur.rage.lvl,
			sahurGold = upgradesModel.sahur.gold,
			--PATAPIM SKILLS
			patapimSkill1 = upgradesModel.patapim.skill1.lvl,
			patapimSkill2 = upgradesModel.patapim.skill2.lvl,
			patapimSkill3 = upgradesModel.patapim.skill3.lvl,
			patapimSkill4 = upgradesModel.patapim.skill4.lvl,
			patapimSkill5 = upgradesModel.patapim.skill5.lvl,
			patapimSkill6 = upgradesModel.patapim.skill6.lvl,
			--PATAPIM STATS
			patapimPow = upgradesModel.patapim.pow.lvl,
			patapimHp = upgradesModel.patapim.hp.lvl,
			patapimMana = upgradesModel.patapim.mana.lvl,
			patapimCdr = upgradesModel.patapim.cdr.lvl,
			patapimCrit = upgradesModel.patapim.crit.lvl,
			patapimIncome = upgradesModel.patapim.income.lvl,
			patapimGold = upgradesModel.patapim.gold,
			--CAPPUCCINO SKILLS
			cappuccinoSkill1 = upgradesModel.cappuccino.skill1.lvl,
			cappuccinoSkill2 = upgradesModel.cappuccino.skill2.lvl,
			cappuccinoSkill3 = upgradesModel.cappuccino.skill3.lvl,
			cappuccinoSkill4 = upgradesModel.cappuccino.skill4.lvl,
			cappuccinoSkill5 = upgradesModel.cappuccino.skill5.lvl,
			--CAPPUCCINO STATS
			cappuccinoStr = upgradesModel.cappuccino.str.lvl,
			cappuccinoHp = upgradesModel.cappuccino.hp.lvl,
			cappuccinoSpd = upgradesModel.cappuccino.spd.lvl,
			cappuccinoCrit = upgradesModel.cappuccino.crit.lvl,
			cappuccinoIncome = upgradesModel.cappuccino.income.lvl,
			cappuccinoPrecision = upgradesModel.cappuccino.precision.lvl,
			cappuccinoGold = upgradesModel.cappuccino.gold,
		},
		function() 
			print("SAVEDATA SUCCESS")	
		end,
		function() 
			print("Error: save data failed")
		end
	)
	end,
	function()
		print("Error: save data failed")
	end
)
end

function M.loadData(onComplete)
	bridge.storage.get(
	{
		--settings
		"sound","music","lang","hotkeys", 
		--achi
		"deaths", "dindinDefeated", "sahurMaxBoss", "patapimMaxBoss", "cappuccinoMaxBoss",
		--TUTORIAL
		"tut1", "tut2", "tut3", "tut4", "tut5",
		--SAHUR UPGRADES
		"sahurSkill1", "sahurSkill2", "sahurSkill3", "sahurSkill4", "sahurSkill5", 
		"sahurStr", "sahurHp", "sahurSpd", "sahurCrit", "sahurIncome", "sahurRage", "sahurGold",
		--PATAPIM UPGRADES
		"patapimSkill1", "patapimSkill2", "patapimSkill3", "patapimSkill4", "patapimSkill5", "patapimSkill6", 
		"patapimPow", "patapimHp", "patapimMana", "patapimCdr", "patapimCrit", "patapimIncome", "patapimGold",
		--CAPPUCCINO UPGRADES
		"cappuccinoSkill1", "appuccinoSkill2", "cappuccinoSkill3", "appuccinoSkill4", "cappuccinoSkill5",
		"cappuccinoStr", "cappuccinoHp", "cappuccinoSpd", "cappuccinoCrit", "cappuccinoIncome", "cappuccinoPrecision", "cappuccinoGold",
	},
	function (_, data)		
		if data.sound == "off" then 
			settingsModel.setSound(false)
		end
		if data.music == "off" then 
			settingsModel.setMusic(false)
		end
		settingsModel.setLang(data.lang or "en")
		settingsModel.setHotkeys(data.hotkeys or "123456")

		pprint(data)
		achievements.setDeaths(data.deaths or 0)
		achievements.setDindinDefeated(data.dindinDefeated or false)
		achievements.setSahurMaxBoss(data.sahurMaxBoss or 0)
		achievements.setPatapimMaxBoss(data.patapimMaxBoss or 0)
		achievements.setCappuccinoMaxBoss(data.cappuccinoMaxBoss or 0)

		tutorial.tutorial1.seen = data.tut1 or false
		tutorial.tutorial2.seen = data.tut2 or false
		tutorial.tutorial3.seen = data.tut3 or false
		tutorial.tutorial4.seen = data.tut4 or false
		tutorial.tutorial5.seen = data.tut5 or false

		--sahurskills
		upgradesModel.sahur.skill1.lvl = data.sahurSkill1 or 1
		upgradesModel.sahur.skill2.lvl = data.sahurSkill2 or 0
		upgradesModel.sahur.skill3.lvl = data.sahurSkill3 or 0
		upgradesModel.sahur.skill4.lvl = data.sahurSkill4 or 0
		upgradesModel.sahur.skill5.lvl = data.sahurSkill5 or 0
		--sahurstats
		upgradesModel.sahur.str.lvl = data.sahurStr or 0
		upgradesModel.sahur.hp.lvl = data.sahurHp or 0
		upgradesModel.sahur.spd.lvl = data.sahurSpd or 0
		upgradesModel.sahur.crit.lvl = data.sahurCrit or 0
		upgradesModel.sahur.income.lvl = data.sahurIncome or 0
		upgradesModel.sahur.rage.lvl = data.sahurRage or 0
		upgradesModel.sahur.gold = data.sahurGold or 0
		--patapimskills
		upgradesModel.patapim.skill1.lvl = data.patapimSkill1 or 1
		upgradesModel.patapim.skill2.lvl = data.patapimSkill2 or 1
		upgradesModel.patapim.skill3.lvl = data.patapimSkill3 or 0
		upgradesModel.patapim.skill4.lvl = data.patapimSkill4 or 0
		upgradesModel.patapim.skill5.lvl = data.patapimSkill5 or 0
		upgradesModel.patapim.skill6.lvl = data.patapimSkill6 or 0
		--patapimstats
		upgradesModel.patapim.pow.lvl = data.patapimPow or 0
		upgradesModel.patapim.hp.lvl = data.patapimHp or 0
		upgradesModel.patapim.mana.lvl = data.patapimMana or 0
		upgradesModel.patapim.cdr.lvl = data.patapimCdr or 0
		upgradesModel.patapim.crit.lvl = data.patapimCrit or 0
		upgradesModel.patapim.income.lvl = data.patapimIncome or 0
		upgradesModel.patapim.gold = data.patapimGold or 0
		--cappuccinoskills
		upgradesModel.cappuccino.skill1.lvl = data.cappuccinoSkill1 or 1
		upgradesModel.cappuccino.skill2.lvl = data.cappuccinoSkill2 or 0
		upgradesModel.cappuccino.skill3.lvl = data.cappuccinoSkill3 or 0
		upgradesModel.cappuccino.skill4.lvl = data.cappuccinoSkill4 or 0
		upgradesModel.cappuccino.skill5.lvl = data.cappuccinoSkill5 or 0
		--sahurstats
		upgradesModel.cappuccino.str.lvl = data.cappuccinoStr or 0
		upgradesModel.cappuccino.hp.lvl = data.cappuccinoHp or 0
		upgradesModel.cappuccino.spd.lvl = data.cappuccinoSpd or 0
		upgradesModel.cappuccino.crit.lvl = data.cappuccinoCrit or 0
		upgradesModel.cappuccino.income.lvl = data.cappuccinoIncome or 0
		upgradesModel.cappuccino.precision.lvl = data.cappuccinoPrecision or 0
		upgradesModel.cappuccino.gold = data.cappuccinoGold or 0
		onComplete()
	end,
	function (_,data)
		print("Error: Load data failed")
		pprint(data)
		onComplete()
	end)
end

return M