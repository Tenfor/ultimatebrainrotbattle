local M = {}

-- Player támadás: objektumot mozgat 400 X-re, majd vissza
function M.player_attack(go_url,soundControllerPath)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(600, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		local rand = math.random(1,2)
		msg.post(soundControllerPath, "playSfx", {url = "#hit_"..tostring(rand)} )
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)
end

function M.enemy_attack(go_url,soundControllerPath)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(680, original_pos.y, original_pos.z)

	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		local rand = math.random(1,2)
		msg.post(soundControllerPath, "playSfx", {url = "#hit_"..tostring(rand)} )
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)
end

return M