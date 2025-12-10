-- ~/.config/nvim/lua/header_switch.lua
local M = {}

local header_exts = { ".hpp", ".hh", ".hxx", ".h" }
local source_exts = { ".cpp", ".cc", ".cxx", ".c" }

local uv = vim.loop

local function ends_with(path, ext)
  return #path >= #ext and path:sub(-#ext) == ext
end

local function detect_ext(path, exts)
  for _, ext in ipairs(exts) do
    if ends_with(path, ext) then
      return ext
    end
  end
  return nil
end

local function get_alternate_file(file)
  local is_header_ext = detect_ext(file, header_exts)
  local is_source_ext = detect_ext(file, source_exts)

  if not is_header_ext and not is_source_ext then
    return nil
  end

  local root
  local candidates

  if is_header_ext then
    root = file:sub(1, #file - #is_header_ext)
    candidates = source_exts
  else
    root = file:sub(1, #file - #is_source_ext)
    candidates = header_exts
  end

  for _, ext in ipairs(candidates) do
    local alt = root .. ext
    if uv.fs_stat(alt) then
      return alt
    end
  end

  return nil
end

local function open_alternate_in_current()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return
  end

  local alt = get_alternate_file(file)
  if not alt then
    vim.notify("No matching header/source file found for " .. file, vim.log.levels.WARN)
    return
  end

  vim.cmd.edit(vim.fn.fnameescape(alt))
end

local function open_alternate_smart_vsplit()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return
  end

  local alt = get_alternate_file(file)
  if not alt then
    vim.notify("No matching header/source file found for " .. file, vim.log.levels.WARN)
    return
  end

  local escaped = vim.fn.fnameescape(alt)
  local current_win = vim.api.nvim_get_current_win()
  local wins = vim.api.nvim_tabpage_list_wins(0)

  if #wins == 1 then
    vim.cmd("vsplit " .. escaped)
    return
  end

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name == alt then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  for _, win in ipairs(wins) do
    if win ~= current_win then
      vim.api.nvim_set_current_win(win)
      vim.cmd.edit(escaped)
      return
    end
  end

  vim.cmd("vsplit " .. escaped)
end

function M.toggle()
  open_alternate_in_current()
end

function M.vsplit()
  open_alternate_smart_vsplit()
end

return M

