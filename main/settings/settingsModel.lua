local M = {
	sound = true,
	music = true,
	hotkeys = "123456",
	lang = "en",
	hideAds = true
}

function M.setHotkeys(val, save)
	if val ~= "123456" and val ~= "QWERTY" and val ~= "AZERTY" then
		return false
	end
	M.hotkeys = val
end

function M.setSound(val)
	M.sound = val
end

function M.setMusic(val)
	M.music = val
end

function M.setLang(val)
	M.lang = val
end
	
return M