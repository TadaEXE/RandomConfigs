pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = { "latex", "bibtex", "python", "lua", "luadoc", "printf", "vim", "vimdoc", "c", "cpp", "cmake", "markdown", "javascript", "typescript", "toml", "yaml", "json" },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
