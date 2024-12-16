---@type ChadrcConfig 

vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<cmd>w<cr>')
vim.keymap.set({'i'}, '<C-z>', '<cmd>undo<cr>')
vim.keymap.set({'i'}, '<C-y>', '<cmd>redo<cr>')

vim.opt.relativenumber = true

 local M = {}
 M.ui = { theme = 'oxocarbon' }
 M.plugins = "custom.plugins"
 M.mappings = require("custom.mappings")
 return M
