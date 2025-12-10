local buffs = require("main/battle/buffs")
local skills = require("main/battle/skills")

local M = {}

M.list = {
	boneca = {
		name = "boneca",
		displayName = "Boneca Ambalabu",
		sprite = "boneca", 
		critPercent = 3,
		critDmg = 2,
		spd = 1.5,
		minDmg = 2,
		maxDmg = 4,
		hp = 75,
		maxHp = 75,
		pattern = {
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.BONECA_TRANSFORM,
			skills.BONECA_ULTI,
			skills.BONECA_TRANSFORM_BACK,
		},
		mocks = {
			"GG EASY LEMON SQUEZY NOOB!",
			"Let me give you an advice: GIT GUD!",
			"HAHA! Boneca Ambalabu is the best!"
		},
		startPos = {1530,276,0},
		enterPos = {830,276,0},
		scale = 1
	},
	frigo = {
		name = "frigo",
		displayName = "Frigo Camelo",
		sprite = "frigo", 
		critPercent = 3,
		critDmg = 2,
		spd = 1.8,
		minDmg = 6,
		maxDmg = 9,
		hp = 330,
		maxHp = 330,
		pattern = {
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.FROST_EXPLOSION,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.FROST_BOLT_CAST
		},
		mocks = {
			"Am I cool or what?",
			"I've been an ordinary camel until a radioactive fridge bit me.",
			"You better cool down mate! Got it?"
		},
		startPos = {830,276,0},
		enterPos = {830,276,0},
		scale = 1
	},
	lirili = {
		name = "lirili",
		displayName = "Lirili Larila",
		sprite = "lirili", 
		critPercent = 0,
		critDmg = 2,
		spd = 0.35,
		minDmg = 40,
		maxDmg = 45,
		hp = 700,
		maxHp = 700,
		pattern = {
			skills.GIGA_PUNCH,
			skills.GIGA_PUNCH,
			skills.GIGA_PUNCH,
		},
		mocks = {
			"TODO: insert very funny text here",
			"I've been an ordinary elephant until a radioactive cactus bit me.",
			"None can withstand my cactus powers"
		},
		startPos = {1530,340,0},
		enterPos = {930,340,0},
		scale = 1.6
	},
	dindin = {
		name = "dindin",
		displayName = "Udindindindun Madindindindun",
		sprite = "dindin", 
		critPercent = 5,
		critDmg = 2,
		spd = 1.8,
		minDmg = 12,
		maxDmg = 18,
		hp = 450,
		maxHp = 450,
		pattern = {
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.FIRE_PUNCH,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.METEOR_SMASH
		},
		mocks = {
			"My mother always told me: Never skip leg day bro!",
			"I've only used 1% of my power bro.",
			"Train a bit more little bro! It wasn't even my final form."
		},
		startPos = {830,1500,0},
		enterPos = {830,276,0},
		scale = 1
	},
	superDindin = {
		name = "superDindin",
		displayName = "Udindindindun Madindindindun",
		sprite = "dindin", 
		critPercent = 8,
		critDmg = 2,
		spd = 2.7,
		minDmg = 12,
		maxDmg = 18,
		hp = 550,
		maxHp = 550,
		pattern = {
			skills.FIRE_PUNCH,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.METEOR_SMASH,
			skills.KAME_HAME,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
			skills.EMPTY,
		},
		mocks = {
			"My mother always told me: Never skip leg day bro!",
			"I've only used 1% of my power bro.",
			"Train a bit more little bro! It wasn't even my final form."
		},
		startPos = {830,276,0},
		enterPos = {830,306,0},
		scale = 1
	},
	bombardiro = {
		name = "bombardiro",
		displayName = "Bombardiro Crocodilo",
		sprite = "bombardiro", 
		critPercent = 8,
		critDmg = 2,
		spd = 2.7,
		minDmg = 20,
		maxDmg = 25,
		hp = 2500,
		maxHp = 2500,
		pattern = {
			skills.SHOT,
			skills.SHOT,
			skills.SHOT,
			skills.SHOT,
			skills.SHOT,
			skills.ROCKET,
			skills.ROCKET_BIG,
			skills.CALL_PATAPIM,
		},
		mocks = {
			"HAHAHA! Now nothing stands in my way!",
			"Now I shall explode everything you love!",
			"Haha! The whole world will go kaboom!"
		},
		castBarPos = {930,453,0},
		startPos = {1530,340,0},
		enterPos = {930,340,0},
		scale = 1.2
	},
	patapim = {
		name = "patapim",
		displayName = "Brr Brr Patapim",
		sprite = "patapim", 
		critPercent = 5,
		critDmg = 2,
		spd = 2,
		minDmg = 15,
		maxDmg = 20,
		hp = 700,
		maxHp = 700,
		pattern = {
			skills.LIGHTNING_BOLT,
			skills.ARCANE_BOLT,
			skills.ARCANE_BOLT,
			skills.ARCANE_BOLT,
			skills.FROST_BOLT,
			skills.ARCANE_BOLT,
			skills.ARCANE_BOLT,
			skills.ARCANE_BOLT,
			skills.FIRE_BOLT,
		},
		mocks = {
			"I am sorry I must obey.",
			"You must grow stronger to stop him!",
			"You are not prepared to face him yet."
		},
		startPos = {1530,276,0},
		enterPos = {830,276,0},
		scale = 1
	},
	cappuccino = {
		name = "cappuccino",
		displayName = "Cappuccino Assassino",
		sprite = "cappuccino", 
		critPercent = 10,
		critDmg = 2.5,
		spd = 3,
		minDmg = 15,
		maxDmg = 20,
		hp = 700,
		maxHp = 700,
		pattern = {
			skills.EMPTY,
			skills.WIND_SLASH,
			skills.WIND_SLASH,
			skills.DOUBLE_CUT,
			skills.EMPTY,
			skills.EMPTY,
		},
		mocks = {
			"Target eliminated!",
			"very funny text here",
			"Requiescat in pace."
		},
		startPos = {830,276,0},
		enterPos = {830,276,0},
		scale = 1
	},
}

return M