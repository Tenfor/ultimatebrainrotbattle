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
	DARK_PATAPIM = "DARK_PATAPIM",
	BONECA_TRANSFORM = "BONECA_TRANSFORM",
	BONECA_ULTI = "BONECA_ULTI",
	BONECA_TRANSFORM_BACK = "BONECA_TRANSFORM_BACK",
}

local skillData = {
	[M.LION_STRIKE]  = 	{ cost=15, damage = 2, cooldown = 9, globalCoolDown = 0, castTime = 0 },
	[M.METEOR_SMASH] = { cost=30, damage = 2, cooldown = 10, globalCoolDown = 0, castTime = 0 },
	[M.ENRAGE]  = 	{ cost=0, damage = 0, cooldown = 25, globalCoolDown = 0.5, castTime = 0 },
	[M.SHIELD]  = 	{ cost=20, damage = 0, cooldown = 20, globalCoolDown = 0.5, castTime = 0 },
	[M.BERSERK]      = { cost=80, damage = 0, cooldown = 60, globalCoolDown = 0, castTime = 0 },
	[M.ARCANE_BOLT]  = { cost=0, damage = 1, cooldown = 2, globalCoolDown = 0.5, castTime = 0 },
	[M.FIRE_BOLT]    = { cost=30, damage = 2.5, cooldown = 5, globalCoolDown = 0.5, castTime = 0 },
	[M.LIGHTNING_BOLT] = { cost=50, damage = 4, cooldown = 10, globalCoolDown = 0.5, castTime = 3 },
	[M.FROST_BOLT]   = { cost=40, damage = 2, cooldown = 8, globalCoolDown = 0.5, castTime = 0 },
	[M.WIND_SLASH]   = { cost=0, damage = 1.5, cooldown = 5, globalCoolDown = 0.5, castTime = 0 },
	[M.DOUBLE_CUT]   = { cost=2, damage = 1.25, cooldown = 3, globalCoolDown = 0.5, castTime = 0 },
	[M.DARK_PATAPIM]   = { cost=50, damage = 0, cooldown = 60, globalCoolDown = 0.5, castTime = 0 },
	[M.BONECA_TRANSFORM]   = { cost=50, damage = 0, cooldown = 60, globalCoolDown = 0.5, castTime = 0 },
	[M.BONECA_ULTI]   = { cost=50, damage = 3, cooldown = 60, globalCoolDown = 0.5, castTime = 0 },
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