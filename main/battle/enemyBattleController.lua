local M = {}

-- Player támadás: objektumot mozgat 400 X-re, majd vissza
function M.enemyAttac(go_url)
	local original_pos = go.get_position(go_url)
	local target_pos = vmath.vector3(640, original_pos.y, original_pos.z)

	-- Animálás 0.2 másodperc alatt 400 X-re
	go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, target_pos.x, go.EASING_LINEAR, 0.2, 0, function()
		-- Visszaugrás eredeti pozícióra
		go.animate(go_url, "position.x", go.PLAYBACK_ONCE_FORWARD, original_pos.x, go.EASING_LINEAR, 0.2)
	end)
end

return M