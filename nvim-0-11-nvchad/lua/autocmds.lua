require "nvchad.autocmds"

local harpoon = require("harpoon")
harpoon:setup()

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local curbuf = vim.api.nvim_get_current_buf()

        -- Defer to avoid interfering with new plugin-created windows
        vim.defer_fn(function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_is_valid(win) then
                    local config = vim.api.nvim_win_get_config(win)
                    if config.relative ~= "" then
                        local win_buf = vim.api.nvim_win_get_buf(win)
                        -- Only close floats from other buffers that are probably LSP-related
                        local ft = vim.bo[win_buf].filetype
                        if win_buf ~= curbuf and (ft == "markdown" or ft == "plaintext") then
                            pcall(vim.api.nvim_win_close, win, true)
                        end
                    end
                end
            end
        end, 50) -- small delay (50ms) so plugin floats can initialize safely
    end,
})


