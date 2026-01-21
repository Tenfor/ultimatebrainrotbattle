local settingsModel = require("main/settings/settingsModel")
local en = require("main/translator/locale_en")

local M = {

}

function M.getText(textId)
	if settingsModel.lang == "en" then
		if en[textId] then 
			return en[textId]
		else 
			pprint("TRANSLATE ERROR",textId,en[textId])
			return {text="text id not found",args={}}
		end
	elseif settingsModel.lang == "ru" then
		return {text="",args={}}
	end
end

function M.translate(textNodes)
	for i = 1, #textNodes do
		local node = type(textNodes[i]) == "string" and gui.get_node(textNodes[i]) or gui.get_node(textNodes[i].node)
		if node then
			local textId = (type(textNodes[i] == "table") and textNodes[i].textId ~= nil) and textNodes[i].textId or gui.get_text(node)
			local entry = M.getText(textId)

			local text = entry.text
			entry.args = type(textNodes[i] == "table") and textNodes[i].args or entry.args
		
			for key, value in pairs(entry.args) do
				text = text:gsub("%%" .. key, tostring(value))
			end
			
			gui.set_text(node, text)
		end
	end
end

return M