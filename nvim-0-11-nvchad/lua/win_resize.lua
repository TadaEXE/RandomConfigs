local M = {}

--- Simple interactive window-resize mode that moves split borders
--- around the current window. Call M.start() to enter the mode.
local state = {
	active = false,
	floats = {},
	buf = nil,
	mapped_keys = {},
	step = 4,
	autocmd_id = nil,
}

local function clamp(v, min, max)
	if v < min then
		return min
	end
	if v > max then
		return max
	end
	return v
end

local function clear_floats()
	for _, win in ipairs(state.floats) do
		if vim.api.nvim_win_is_valid(win) then
			pcall(vim.api.nvim_win_close, win, true)
		end
	end
	state.floats = {}
end

local function get_win_rect(win)
	local pos = vim.fn.win_screenpos(win)
	local top = pos[1] - 1
	local left = pos[2] - 1
	local width = vim.api.nvim_win_get_width(win)
	local height = vim.api.nvim_win_get_height(win)
	return {
		top = top,
		left = left,
		bottom = top + height - 1,
		right = left + width - 1,
		width = width,
		height = height,
	}
end

local function compute_neighbors()
	local cur = vim.api.nvim_get_current_win()
	local cfg_cur = vim.api.nvim_win_get_config(cur)
	if cfg_cur.relative ~= "" then
		return false, false, false, false
	end

	local cur_rect = get_win_rect(cur)

	local has_left = false
	local has_right = false
	local has_up = false
	local has_down = false

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if win ~= cur then
			local cfg = vim.api.nvim_win_get_config(win)
			if cfg.relative == "" then
				local r = get_win_rect(win)

				local vertical_overlap = not (r.bottom < cur_rect.top or r.top > cur_rect.bottom)
				if vertical_overlap then
					if r.right < cur_rect.left then
						has_left = true
					end
					if r.left > cur_rect.right then
						has_right = true
					end
				end

				local horizontal_overlap = not (r.right < cur_rect.left or r.left > cur_rect.right)
				if horizontal_overlap then
					if r.bottom < cur_rect.top then
						has_up = true
					end
					if r.top > cur_rect.bottom then
						has_down = true
					end
				end
			end
		end
	end

	return has_left, has_right, has_up, has_down
end

local function show_floats()
	if not state.active then
		return
	end

	clear_floats()

	local win = vim.api.nvim_get_current_win()
	local rect = get_win_rect(win)
	local lines = vim.o.lines
	local cols = vim.o.columns

	local has_left, has_right, has_up, has_down = compute_neighbors()

	local up_text = "∧"
	local down_text = "v"
	local left_text = "<"
	local right_text = ">"

	local hints = {}

	if has_up or has_down then
		local center_col = rect.left + math.floor((rect.width - 1) / 2)

		if has_up then
			table.insert(hints, {
				text = up_text,
				row = rect.top - 4,
				col = center_col,
			})
			table.insert(hints, {
				text = down_text,
				row = rect.top,
				col = center_col,
			})
		end

		if has_down then
			table.insert(hints, {
				text = up_text,
				row = rect.bottom - 2,
				col = center_col,
			})
			table.insert(hints, {
				text = down_text,
				row = rect.bottom + 2,
				col = center_col,
			})
		end
	end

	if has_left or has_right then
		local center_row = rect.top + math.floor(rect.height / 2)

		if has_left and not has_right then
			local border_col = rect.left - 2
			table.insert(hints, {
				text = left_text,
				row = center_row,
				col = border_col - 2,
			})
			table.insert(hints, {
				text = right_text,
				row = center_row,
				col = border_col + 2,
			})
		elseif has_right and not has_left then
			local border_col = rect.right
			table.insert(hints, {
				text = left_text,
				row = center_row,
				col = border_col - 2,
			})
			table.insert(hints, {
				text = right_text,
				row = center_row,
				col = border_col + 2,
			})
		elseif has_left and has_right then
			local right_col = rect.right
			table.insert(hints, {
				text = left_text,
				row = center_row,
				col = right_col - 2,
			})
			table.insert(hints, {
				text = right_text,
				row = center_row,
				col = right_col + 2,
			})
		end
	end

	for _, h in ipairs(hints) do
		local row = clamp(h.row, 0, lines - 2)
		local col = clamp(h.col, 0, math.max(cols - #h.text - 1, 0))

		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { h.text })

		local winid = vim.api.nvim_open_win(buf, false, {
			relative = "editor",
			row = row,
			col = col,
			width = 1,
			height = 1,
			style = "minimal",
			border = "single",
			focusable = false,
			noautocmd = true,
			zindex = 200,
		})

		table.insert(state.floats, winid)
	end
end

function M.resize_width(direction)
	if not state.active or direction == 0 then
		return
	end

	local has_left, has_right = compute_neighbors()

	if not has_left and not has_right then
		return
	end

	local sign
	if has_left and not has_right then
		if direction < 0 then
			sign = 1
		else
			sign = -1
		end
	elseif has_right and not has_left then
		if direction < 0 then
			sign = -1
		else
			sign = 1
		end
	else
		if direction < 0 then
			sign = -1
		else
			sign = 1
		end
	end

	local delta = sign * state.step
	local cmd
	if delta > 0 then
		cmd = "vertical resize +" .. delta
	else
		cmd = "vertical resize " .. delta
	end

	vim.cmd(cmd)
	show_floats()
end

function M.resize_height(direction)
	if not state.active or direction == 0 then
		return
	end

	local _, _, has_up, has_down = compute_neighbors()

	if not has_up and not has_down then
		return
	end

	local sign
	if has_up and not has_down then
		if direction < 0 then
			sign = 1
		else
			sign = -1
		end
	elseif has_down and not has_up then
		if direction < 0 then
			sign = -1
		else
			sign = 1
		end
	else
		if direction < 0 then
			sign = -1
		else
			sign = 1
		end
	end

	local delta = sign * state.step
	local cmd
	if delta > 0 then
		cmd = "resize +" .. delta
	else
		cmd = "resize " .. delta
	end

	vim.cmd(cmd)
	show_floats()
end

function M.stop()
	if not state.active then
		return
	end

	clear_floats()

	if state.autocmd_id then
		pcall(vim.api.nvim_del_autocmd, state.autocmd_id)
		state.autocmd_id = nil
	end

	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		for _, lhs in ipairs(state.mapped_keys or {}) do
			pcall(vim.keymap.del, "n", lhs, { buffer = state.buf })
		end
	end

	state.mapped_keys = {}
	state.active = false
	state.buf = nil
end

function M.start(step)
	if state.active then
		return
	end

	if step and type(step) == "number" then
		state.step = step
	end

	state.active = true
	state.buf = vim.api.nvim_get_current_buf()

	state.mapped_keys = {}

	local function map(lhs, rhs)
		vim.keymap.set("n", lhs, rhs, {
			buffer = state.buf,
			silent = true,
			nowait = true,
		})
		table.insert(state.mapped_keys, lhs)
	end

	map("h", function()
		M.resize_width(-1)
	end)

	map("l", function()
		M.resize_width(1)
	end)

	map("k", function()
		M.resize_height(-1)
	end)

	map("j", function()
		M.resize_height(1)
	end)

	map("q", M.stop)
	map("<Esc>", M.stop)

	local group = vim.api.nvim_create_augroup("WinResizeHints", { clear = false })

	state.autocmd_id = vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "InsertEnter" }, {
		group = group,
		buffer = state.buf,
		callback = function()
			if state.active then
				M.stop()
			end
		end,
	})

	show_floats()

	if vim.notify then
		vim.notify("Resize mode: h/j/k/l resize, q or <Esc> to exit", vim.log.levels.INFO)
	end
end

return M
