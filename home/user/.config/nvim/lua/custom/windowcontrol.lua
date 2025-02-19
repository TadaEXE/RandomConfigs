local M = {}
local function is_at_edge(direction)
  local win_info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
  if not win_info then
    return false -- If we can't retrieve window info, assume it's not at the edge
  end

  local wincol = win_info.wincol
  local winwidth = win_info.width
  local winrow = win_info.winrow
  local winheight = win_info.height

  local total_cols = vim.o.columns
  local total_rows = vim.o.lines

  -- print("win_col:" .. wincol .. " win_row:" .. winrow .. " winwidth:" .. winwidth .. " winheight:" .. winheight .. " total cols:" .. total_cols .. " total_rows:" .. total_rows)

  -- Check edge cases based on direction
  if direction == "left" then
    -- print(wincol == 1)
    return wincol == 1
  elseif direction == "right" then
    -- print(wincol + winwidth == total_cols + 1)
    return (wincol + winwidth) == total_cols + 1
  elseif direction == "up" then
    -- print(winrow == 2)
    return winrow == 2
  elseif direction == "down" then
    -- print(winrow + winheight == total_rows + 1)
    return (winrow + winheight) == total_rows - 1
  end
end

local function move_split(direction, ud_inverted, lr_inverted)
  if direction == "left" then
    if lr_inverted then
      vim.cmd("vertical resize -2")
    else
      vim.cmd("vertical resize +2")
    end
  elseif direction == "right" then
    if lr_inverted then
      vim.cmd("vertical resize +2")
    else
      vim.cmd("vertical resize -2")
    end
  elseif direction == "up" then
    if ud_inverted then
      vim.cmd("resize -2")
    else
      vim.cmd("resize +2")
    end
  elseif direction == "down" then
    if ud_inverted then
      vim.cmd("resize +2")
    else
      vim.cmd("resize -2")
    end
  end
end

-- local function move_split_inverted(direction)
--   if direction == "left" then
--     vim.cmd("vertical resize -2")
--   elseif direction == "right" then
--     vim.cmd("vertical resize +2")
--   elseif direction == "up" then
--     vim.cmd("resize -2")
--   elseif direction == "down" then
--     vim.cmd("resize +2")
--   end
-- end

function M.smart_resize(direction)
  local current_win = vim.api.nvim_get_current_win()

  local left = is_at_edge("left")
  local right = is_at_edge("right")
  local up = is_at_edge("up")
  local down = is_at_edge("down")

  -- print("left:" .. tostring(left) .. " right:" .. tostring(right) .. " up:" .. tostring(up) .. " down:" .. tostring(down))
  if left and up and down then
    move_split(direction, false, true)
  elseif right and up and down then
    move_split(direction, false, false)
  elseif left and up and right then
    move_split(direction, true, false)
  elseif left and down and right then
    move_split(direction, false, false)
  elseif left and up then
    move_split(direction, true, true)
  elseif left and down then
    move_split(direction, false, true)
  elseif right and up then
    move_split(direction, true, false)
  elseif right and down then
    move_split(direction, false, false)
  elseif left then
    move_split(direction, true, true)
  elseif right then
    move_split(direction, false, false)
  elseif up then
    move_split(direction, true, true)
  elseif down then
    move_split(direction, false, true)
  else
    move_split(direction, true, true)
  end

  -- Return to the original window (ensures cursor consistency)
  vim.cmd("call win_gotoid(" .. current_win .. ")")
end

return M
