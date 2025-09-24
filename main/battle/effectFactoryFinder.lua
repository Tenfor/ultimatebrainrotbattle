local M = {}

local factory2Effects = {"lionstrike","shield","wind_slash"}

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
	else
		return ""
	end
end

return M