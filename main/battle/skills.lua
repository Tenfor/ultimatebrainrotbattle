local M = {
	EMPTY = "EMPTY",
	LION_STRIKE = "LION_STRIKE",
	METEOR_SMASH = "METEOR_SMASH",
	ENRAGE = "ENRAGE",
	SHIELD = "SHIELD",
	BERSERK = "BERSERK",
	FIRE_BOLT = "FIRE_BOLT",
	LIGHTNING_BOLT = "LIGHTNING_BOLT",
	ARCANE_BOLT = "ARCANE_BOLT",
	FROST_BOLT = "FROST_BOLT",
	WIND_SLASH = "WIND_SLASH",
	DOUBLE_CUT = "DOUBLE_CUT",
	POISON_DAGGER = "POISON_DAGGER",
	EVASION = "EVASION",
	BLADE_DANCE = "BLADE_DANCE",
	DARK_PATAPIM = "DARK_PATAPIM",
	BONECA_TRANSFORM = "BONECA_TRANSFORM",
	BONECA_ULTI = "BONECA_ULTI",
	BONECA_TRANSFORM_BACK = "BONECA_TRANSFORM_BACK",
	GIGA_PUNCH = "GIGA_PUNCH",
	FROST_EXPLOSION = "FROST_EXPLOSION",
	FROST_BOLT_CAST = "FROST_BOLT_CAST",
	FIRE_PUNCH = "FIRE_PUNCH",
	KAME_HAME = "KAME_HAME",
	SHOT = "SHOT",
	ROCKET = "ROCKET",
	ROCKET_BIG = "ROCKET_BIG",
	CALL_PATAPIM = "CALL_PATAPIM",
	CALL_CAPPUCINO = "CALL_CAPPUCINO",
	COMET_RAIN = "COMET_RAIN"
}

local skillData = {
	[M.LION_STRIKE]  = 	{ cost=15, damage = 2, cooldown = 6, globalCoolDown = 0, castTime = 0 },
	[M.METEOR_SMASH] = { cost=30, damage = 2.5, cooldown = 11, globalCoolDown = 0, castTime = 0 },
	[M.ENRAGE]  = 	{ cost=0, damage = 0, cooldown = 50, globalCoolDown = 0.5, castTime = 0 },
	[M.SHIELD]  = 	{ cost=20, damage = 0, cooldown = 20, globalCoolDown = 0.5, castTime = 0 },
	[M.BERSERK]      = { cost=70, damage = 0, cooldown = 45, globalCoolDown = 0, castTime = 0 },
	[M.ARCANE_BOLT]  = { cost=0, damage = 1, cooldown = 4, globalCoolDown = 0.5, castTime = 0 },
	[M.FIRE_BOLT]    = { cost=6, damage = 2.5, cooldown = 14, globalCoolDown = 0.5, castTime = 0 },
	[M.LIGHTNING_BOLT] = { cost=15, damage = 4, cooldown = 25, globalCoolDown = 0.5, castTime = 1.5 },
	[M.FROST_BOLT]   = { cost=10, damage = 2, cooldown = 25, globalCoolDown = 0.5, castTime = 0 },
	[M.FROST_BOLT_CAST]   = { cost=20, damage = 2, cooldown = 8, globalCoolDown = 0.5, castTime = 2.5 },
	[M.WIND_SLASH]   = { cost=0, damage = 1.5, cooldown = 3, globalCoolDown = 0.5, castTime = 0 },
	[M.DOUBLE_CUT]   = { cost=2, damage = 1.5, cooldown = 5, globalCoolDown = 0.5, castTime = 0 },
	[M.POISON_DAGGER]   = { cost=2, damage = 1.5, cooldown = 20, globalCoolDown = 0.5, castTime = 0 },
	[M.EVASION]   = { cost=0, damage = 0, cooldown = 15, globalCoolDown = 0.5, castTime = 0 },
	[M.BLADE_DANCE]   = { cost=5, damage = 1.5, cooldown = 45, globalCoolDown = 0.5, castTime = 2 },
	[M.BONECA_TRANSFORM]   = { cost=40, damage = 0, cooldown = 60, globalCoolDown = 0.5, castTime = 0 },
	[M.BONECA_ULTI]   = { cost=50, damage = 3, cooldown = 60, globalCoolDown = 0.5, castTime = 0 },
	[M.GIGA_PUNCH]   = { cost=50, damage = 1, cooldown = 60, globalCoolDown = 0.5, castTime = 0 },
	[M.FROST_EXPLOSION]   = { cost=40, damage = 1, cooldown = 8, globalCoolDown = 0.5, castTime = 3.5 },
	[M.FIRE_PUNCH]   = { cost=40, damage = 2, cooldown = 8, globalCoolDown = 0.5, castTime = 0 },
	[M.KAME_HAME]   = { cost=40, damage = 4, cooldown = 8, globalCoolDown = 0.5, castTime = 3 },
	[M.SHOT] = {cost = 0, damage = 1, cooldown = 1, globalCoolDown = 0, castTime = 0},
	[M.ROCKET] = {cost = 0, damage = 3, cooldown = 1, globalCoolDown = 0, castTime = 0},
	[M.ROCKET_BIG] = {cost = 0, damage = 4, cooldown = 1, globalCoolDown = 0, castTime = 3},
	[M.COMET_RAIN] = {cost = 60, damage = 1, cooldown = 150, globalCoolDown = 0.5, castTime = 3.5},
	[M.DARK_PATAPIM]  = { cost=30, damage = 0, cooldown = 150, globalCoolDown = 0.5, castTime = 0 },
}

function M.getResourceCost(skillName)
	local skill = skillData[skillName]
	return skill and skill.cost or 0
end

function M.getDamage(skillName)
	local skill = skillData[skillName]
	return skill and skill.damage or 1
end

function M.getCD(skillName)
	local skill = skillData[skillName]
	return skill and skill.cooldown or 0
end

function M.getGlobalCD(skillName)
	local skill = skillData[skillName]
	return skill and skill.globalCoolDown or 0
end

function M.getCastTime(skillName)
	local skill = skillData[skillName]
	return skill and skill.castTime or 0
end

return M