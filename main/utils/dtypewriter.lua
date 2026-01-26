--------------------------------------------------------------------------------
-- LICENSE
--------------------------------------------------------------------------------

-- Copyright (c) 2024 White Box Dev

-- This software is provided 'as-is', without any express or implied warranty.
-- In no event will the authors be held liable for any damages arising from the use of this software.

-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it freely,
-- subject to the following restrictions:

-- 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
--    If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.

-- 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.

-- 3. This notice may not be removed or altered from any source distribution.

--------------------------------------------------------------------------------
-- INFORMATION
--------------------------------------------------------------------------------

-- https://github.com/whiteboxdev/library-defold-typewriter

----------------------------------------------------------------------
-- PROPERTIES
----------------------------------------------------------------------

local dtypewriter = {}

local _container_node

local _font_id
local _font

local _text_area_x
local _text_area_y
local _text_area_width

local _line_count_max
local _line_offset

local _chunks = {}

local _characters = {}
local _character_index
local _paragraph_index

local _waiting = false
local _skip = false

local _colors = {}
local _default_color = vmath.vector4(1, 1, 1, 1)

local _fade_delay = 0

local _default_type_speed = 30

local _messages_url

local _callback_handle


local function utf8_iter(s)
	local i = 1
	local len = #s

	return function()
		if i > len then return nil end

		local c = string.byte(s, i)
		local bytes

		if c < 0x80 then
			bytes = 1
		elseif c < 0xE0 then
			bytes = 2
		elseif c < 0xF0 then
			bytes = 3
		else
			bytes = 4
		end

		local start = i
		local char = string.sub(s, i, i + bytes - 1)
		i = i + bytes

		return start, char
	end
end

----------------------------------------------------------------------
-- CONSTANTS
----------------------------------------------------------------------

dtypewriter.messages =
{
	start = hash("start"),
	restart = hash("restart"),
	type = hash("type"),
	wait = hash("wait"),
	continue = hash("continue"),
	complete = hash("complete"),
	clear = hash("clear")
}

----------------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------

local function strip_spaces(text)
	local remove_consecutive_spaces = string.gsub(text, "%s+", " ")
	local remove_front_spaces = string.gsub(remove_consecutive_spaces, "^%s+", "")
	local remove_back_spaces = string.gsub(remove_front_spaces, "%s+$", "")
	local remove_line_spaces = string.gsub(remove_back_spaces, "%s*<line>%s*", "<line>")
	return remove_line_spaces
end

local function add_chunk(type, data)
	local chunk = { type = type, data = data or {} }
	_chunks[#_chunks + 1] = chunk
end

local function add_character(chunk_index, text, color, speed)
	local character_data = { chunk_index = chunk_index, text = text, color = color, speed = speed }
	_characters[#_characters + 1] = character_data
end

local function set_transparent(color)
	return vmath.vector4(color.x, color.y, color.z, 0)
end

local function set_transparent_back(color)
	return vmath.vector4(color.x, color.y, color.z, 1)
end

local function type_callback()
	msg.post(_messages_url, dtypewriter.messages.type)

	while true do
		local character_data = _characters[_character_index]
		if not character_data then
			msg.post(_messages_url, dtypewriter.messages.complete)
			_callback_handle = nil
			return
		end

		-- megjelenítés
		if _fade_delay > 0 then
			gui.animate(character_data.node, "color.w", 1, gui.EASING_LINEAR, _fade_delay)
		else
			gui.set_color(character_data.node, character_data.color)
		end

		_character_index = _character_index + 1
		local next_character_data = _characters[_character_index]

		-- nincs több karakter
		if not next_character_data then
			msg.post(_messages_url, dtypewriter.messages.complete)
			_callback_handle = nil
			return
		end

		-- új bekezdés → várakozás
		if character_data.paragraph < next_character_data.paragraph then
			msg.post(_messages_url, dtypewriter.messages.wait)
			_waiting = true
			_callback_handle = nil
			return
		end

		-- azonnali karakter → loopolunk tovább
		if next_character_data.speed == 0 or _skip then
			-- continue
		else
			-- időzített következő karakter
			_callback_handle = timer.delay(
			1 / next_character_data.speed,
			false,
			type_callback
		)
		return
	end
end
end


----------------------------------------------------------------------
-- MODULE FUNCTIONS
----------------------------------------------------------------------

function dtypewriter.init(container_node_id, font_id, text_area_x, text_area_y, text_area_width, line_count_max, line_offset, messages_url)
	_container_node = gui.get_node(container_node_id)
	_font_id = font_id
	_font = gui.get_font_resource(font_id)
	_text_area_x = text_area_x
	_text_area_y = text_area_y
	_text_area_width = text_area_width
	_line_count_max = line_count_max
	_line_offset = line_offset
	_messages_url = messages_url
end

function dtypewriter.clear()
	msg.post(_messages_url, dtypewriter.messages.clear)
	_text_raw = nil
	_chunks = {}
	for _, character_data in ipairs(_characters) do
		gui.delete_node(character_data.node)
	end
	_characters = {}
	_character_index = nil
	_paragraph_index = nil
	_waiting = false
	if _callback_handle then
		timer.cancel(_callback_handle)
		_callback_handle = nil
	end
end

function dtypewriter.load(text)
	dtypewriter.clear()
	text = strip_spaces(text)
	local chunk_start_index = 1
	local character_index = 1
	local character_color = _default_color
	local character_speed = _default_type_speed
	for byte_index, character in utf8_iter(text) do
		--local character = utf8.char(codepoint)

		-- SPACE
		if character == " " then
			local chunk_type = "content"
			local chunk_text = string.sub(text, chunk_start_index, byte_index - 1)
			local chunk_data = {
				text = chunk_text,
				metrics = resource.get_text_metrics(_font, chunk_text)
			}
			add_chunk(chunk_type, chunk_data)

			chunk_type = "space"
			chunk_text = " "
			chunk_data = {
				text = chunk_text,
				metrics = resource.get_text_metrics(_font, chunk_text)
			}
			add_chunk(chunk_type, chunk_data)

			add_character(#_chunks, chunk_text, character_color, character_speed)

			chunk_start_index = byte_index + 1

			-- TAG START
		elseif character == "<" then
			-- <color=...>
			if string.sub(text, byte_index, byte_index + 6) == "<color=" then
				local s, e = string.find(text, "%l+", byte_index + 7)
				local color_name = string.sub(text, s, e)

				character_color =
				(color_name == "default" or not _colors[color_name])
				and _default_color
				or _colors[color_name]

				text = string.sub(text, 1, byte_index - 1)
				.. string.sub(text, e + 2)

				chunk_start_index = byte_index

				-- <speed=...>
			elseif string.sub(text, byte_index, byte_index + 6) == "<speed=" then
				local s, e = string.find(text, "%d*%l*", byte_index + 7)
				local speed_text = string.sub(text, s, e)

				if speed_text == "default" then
					character_speed = _default_type_speed
				elseif speed_text == "instant" then
					character_speed = 0
				else
					character_speed = tonumber(speed_text)
				end

				text = string.sub(text, 1, byte_index - 1)
				.. string.sub(text, e + 2)

				chunk_start_index = byte_index

				-- <line>
			elseif string.sub(text, byte_index, byte_index + 5) == "<line>" then
				local chunk_type = "content"
				local chunk_text = string.sub(text, chunk_start_index, byte_index - 1)
				local chunk_data = {
					text = chunk_text,
					metrics = resource.get_text_metrics(_font, chunk_text)
				}
				add_chunk(chunk_type, chunk_data)

				add_chunk("line")

				chunk_start_index = byte_index + 6

				-- <paragraph>
			elseif string.sub(text, byte_index, byte_index + 10) == "<paragraph>" then
				local chunk_type = "content"
				local chunk_text = string.sub(text, chunk_start_index, byte_index - 1)
				local chunk_data = {
					text = chunk_text,
					metrics = resource.get_text_metrics(_font, chunk_text)
				}
				add_chunk(chunk_type, chunk_data)

				add_chunk("paragraph")

				chunk_start_index = byte_index + 11
			end

			-- NORMAL CHARACTER (UTF-8 OK)
		else
			add_character(#_chunks + 1, character, character_color, character_speed)
		end

		character_index = character_index + 1
	end

	-- záró content chunk
	if chunk_start_index <= #text then
		local chunk_text = string.sub(text, chunk_start_index)
		add_chunk("content", {
			text = chunk_text,
			metrics = resource.get_text_metrics(_font, chunk_text)
		})
	end
	local text_metrics = resource.get_text_metrics(_font, text)
	local paragraph = 1
	local line = 1
	local line_width_remaining = _text_area_width
	local character_x = _text_area_x
	local invalid_chunk_indices = {}
	for chunk_index, chunk in ipairs(_chunks) do
		local skip_chunk = false

		if chunk.type == "paragraph" then
			line = 1
			line_width_remaining = _text_area_width
			paragraph = paragraph + 1
			character_x = _text_area_x

		elseif chunk.type == "line"
		or (chunk.data.text and line_width_remaining - chunk.data.metrics.width < 0) then

			line = line + 1
			line_width_remaining = _text_area_width

			if line > _line_count_max then
				line = 1
				paragraph = paragraph + 1
			end

			character_x = _text_area_x

			if chunk.type == "space" then
				invalid_chunk_indices[chunk_index] = true
				skip_chunk = true
			end
		end

		if not skip_chunk and chunk.data.text then
			for _, character_data in ipairs(_characters) do
				if character_data.chunk_index == chunk_index then
					local character_metrics = resource.get_text_metrics(_font, character_data.text)

					local character_position = vmath.vector3(
					character_x,
					-_text_area_y - (line - 1) * text_metrics.height + (line - 1) * _line_offset,
					0
				)

				character_x = character_x + character_metrics.width + 1
				line_width_remaining = line_width_remaining - character_metrics.width - 1

				local character_node = gui.new_text_node(character_position, character_data.text)
				gui.set_parent(character_node, _container_node)
				gui.set_font(character_node, _font_id)
				gui.set_color(character_node, set_transparent(character_data.color))
				gui.set_adjust_mode(character_node, gui.ADJUST_FIT)
				gui.set_pivot(character_node, gui.PIVOT_NW)

				character_data.node = character_node
				character_data.paragraph = paragraph
			end
		end
	end
end

	for character_index = #_characters, 1, -1 do
		if invalid_chunk_indices[_characters[character_index].chunk_index] then
			table.remove(_characters, character_index)
		end
	end
end

function dtypewriter.start()
	if dtypewriter.is_loaded() then
		msg.post(_messages_url, dtypewriter.messages.start)
		_character_index = 1
		_paragraph_index = 1
		_callback_handle = timer.delay(0, false, type_callback)
	end
end

function dtypewriter.restart()
	if dtypewriter.is_typing() or dtypewriter.is_waiting() or dtypewriter.is_complete() then
		msg.post(_messages_url, dtypewriter.messages.restart)
		_character_index = 1
		_paragraph_index = 1
		_waiting = false
		if _callback_handle then
			timer.cancel(_callback_handle)
		end
		for character_index = 1, #_characters do
			local character_data = _characters[character_index]
			gui.set_color(character_data.node, set_transparent(character_data.color))
		end
		_callback_handle = timer.delay(0, false, type_callback)
	end
end

function dtypewriter.continue()
	if _waiting then
		msg.post(_messages_url, dtypewriter.messages.continue)
		_waiting = false
		_paragraph_index = _paragraph_index + 1
		character_index = 1
		while character_index < _character_index do
			local character_data = _characters[character_index]
			gui.set_color(character_data.node, set_transparent(character_data.color))
			character_index = character_index + 1
		end
		_callback_handle = timer.delay(0, false, type_callback)
	end
end

function dtypewriter.skip()
	if dtypewriter.is_typing() then
		if _callback_handle then
			timer.cancel(_callback_handle)
		end
		_skip = true
		type_callback()
		_skip = false
	end
end

function dtypewriter.add_color(name, color)
	_colors[name] = color
end

function dtypewriter.set_default_color(color)
	_default_color = color
end

function dtypewriter.clear_colors()
	_colors = {}
end

function dtypewriter.set_fade_delay(delay)
	_fade_delay = delay
end

function dtypewriter.set_default_type_speed(speed)
	_default_type_speed = speed
end

function dtypewriter.is_clear()
	return not _character_index and #_characters == 0
end

function dtypewriter.is_loaded()
	return not _character_index and #_characters > 0
end

function dtypewriter.is_typing()
	return _character_index and _character_index <= #_characters and not _waiting
end

function dtypewriter.is_waiting()
	return _waiting
end

function dtypewriter.is_complete()
	return _character_index and _character_index == #_characters + 1
end

return dtypewriter