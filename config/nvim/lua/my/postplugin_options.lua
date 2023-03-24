-- vim.opt.background = 'dark'
vim.cmd.colorscheme("tokyonight")
-- CodeLens colors
vim.api.nvim_set_hl(0, "LspCodeLens", { link = "DiagnosticVirtualTextHint" })
vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { link = "DiagnosticSignHint" })