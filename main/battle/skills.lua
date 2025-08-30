local M = {
	EMPTY = "EMPTY",
	LION_STRIKE = "LION_STRIKE",
	METEOR_SMASH = "METEOR_SMASH",
	BERSERK = "BERSERK",
	FIRE_BOLT = "FIRE_BOLT",
	ARCANE_BOLT = "ARCANE_BOLT",
	FROST_BOLT = "FROST_BOLT",
}

local skillData = {
	[M.LION_STRIKE]  = 	{ cost=15, damage = 2, cooldown = 9, globalCoolDown = 0 },
	[M.METEOR_SMASH] = { cost=30, damage = 2, cooldown = 10, globalCoolDown = 0 },
	[M.BERSERK]      = { cost=80, damage = 2, cooldown = 60, globalCoolDown = 0 },
	[M.ARCANE_BOLT]  = { cost=0, damage = 1, cooldown = 2, globalCoolDown = 0.5 },
	[M.FIRE_BOLT]    = { cost=30, damage = 2.5, cooldown = 5, globalCoolDown = 0.5 },
	[M.FROST_BOLT]   = { cost=40, damage = 2, cooldown = 8, globalCoolDown = 0.5 },
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

return M