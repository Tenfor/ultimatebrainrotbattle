local M = {}

function M.go_window_callback(self, event, data)
	if event == window.WINDOW_EVENT_RESIZED then
		if data.width/data.height <= 16/9 then 
			go.set_scale(1, "#bg")
		elseif data.width/data.height <= 18/9 then 
			go.set_scale(1.125, "#bg")
		elseif data.width/data.height <= 19.5/9 then 
			go.set_scale(1.21875, "#bg")
		elseif data.width/data.height <= 20/9 then 
			go.set_scale(1.25, "#bg")
		else 
			go.set_scale(1.34, "#bg")
		end
	end
end

function M.gui_window_callback(self, event, data)
	local bgNode = gui.get_node("bg")
	if event == window.WINDOW_EVENT_RESIZED then
		if data.width/data.height <= 16/9 then 
			--thats the base, no need to scale 
			local scale = 1
			gui.set_scale(bgNode,vmath.vector4(scale,1,1,1))
		elseif  data.width/data.height <= 18/9 then 
			local scale = 1.125
			gui.set_scale(bgNode,vmath.vector4(scale,1,1,1))
		elseif data.width/data.height <= 19.5/9 then 
			local scale = 1.21875
			gui.set_scale(bgNode,vmath.vector4(scale,1,1,1))
		elseif data.width/data.height <= 20/9 then 
			local scale = 1.25
			gui.set_scale(bgNode,vmath.vector4(scale,1,1,1))
		else
			local scale = 1.34
			gui.set_scale(bgNode,vmath.vector4(scale,1,1,1))
		end
	end
end

return M