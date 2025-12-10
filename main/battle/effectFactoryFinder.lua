local M = {}

local factory2Effects = {"lionstrike","shield","wind_slash","wind"}
local factory3Effects = {"fire_punch","kame_hame","shotBase", "explosion_big"}

local function contains(table, val)
	for i=1,#table do
		if table[i] == val then 
			return true
		end
	end
	return false
end

function M.getFactoryPostFix(effectName)
	if contains(factory2Effects, effectName) then
		return "2"
	elseif contains(factory3Effects, effectName) then
		return "3"
	else
		return ""
	end
end

return M