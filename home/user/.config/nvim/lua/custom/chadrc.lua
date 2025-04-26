---@type ChadrcConfig

vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr>')
vim.keymap.set({ 'i' }, '<C-z>', '<cmd>undo<cr>')
vim.keymap.set({ 'i' }, '<C-y>', '<cmd>redo<cr>')

vim.api.nvim_set_option("clipboard", "unnamed")

vim.opt.relativenumber = true

vim.o.scrolloff = 7

local M = {}
M.ui = { theme = 'nightfox' }
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")
return M
