---@type ChadrcConfig 

-- vim.keymap.set('n', '<leader>1', '<cmd>tabn 1<cr>')
-- vim.keymap.set('n', '<leader>2', '<cmd>tabn 2<cr>')
-- vim.keymap.set('n', '<leader>3', '<cmd>tabn 3<cr>')
-- vim.keymap.set('n', '<leader>4', '<cmd>tabn 4<cr>')
-- vim.keymap.set('n', '<leader>5', '<cmd>tabn 5<cr>')
-- vim.keymap.set('n', '<leader>6', '<cmd>tabn 6<cr>')
-- vim.keymap.set('n', '<leader>7', '<cmd>tabn 7<cr>')
-- vim.keymap.set('n', '<leader>8', '<cmd>tabn 8<cr>')
-- vim.keymap.set('n', '<leader>9', '<cmd>tabn 9<cr>')
-- vim.keymap.set('n', '<leader>-', '<cmd>tabnext<cr>')
-- vim.keymap.set('n', '<leader>=', '<cmd>tabprevious<cr>')
-- vim.keymap.set('n', '<leader>`', '<cmd>tabnew<cr>')
-- vim.keymap.set('n', '<leader><BS>', '<cmd>tabclose<cr>')
--
vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<cmd>w<cr>')
vim.keymap.set({'i'}, '<C-z>', '<cmd>undo<cr>')
vim.keymap.set({'i'}, '<C-y>', '<cmd>redo<cr>')

 local M = {}
 M.ui = { theme = 'oxocarbon' }
 M.plugins = "custom.plugins"
 M.mappings = require("custom.mappings")
 return M
