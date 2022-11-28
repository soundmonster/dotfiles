vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
-- When a file has been detected to have been changed outside of Vim and it has not
-- been changed inside of Vim, automatically read it again. When the file has been deleted this is not done.
vim.opt.autoread = true
-- Don't show mode in command line since we have it lualine
vim.opt.showmode = false
vim.opt.mouse = 'a'
-- always show signcolumns
vim.opt.signcolumn = 'yes'
-- TODO find out how to escape this properly
-- vim.opt.listchars = "tab:→\ ,trail:·"
-- show just one status line instead of many
vim.opt.laststatus = 3

vim.opt.background = 'dark'
vim.cmd.colorscheme('dracula')
-- CodeLens colors
local comment = vim.api.nvim_get_hl_by_name('Comment', {})
local special_comment = vim.api.nvim_get_hl_by_name('SpecialComment', {})
vim.api.nvim_set_hl(0, 'LspCodeLens', { fg = comment.foreground, italic = true, blend = 80 })
vim.api.nvim_set_hl(0, 'LspCodeLensSeparator', { fg = special_comment.foreground, italic = true, blend = 80 })


vim.cmd [[filetype plugin indent on]]

vim.opt.wrap = false
vim.opt.textwidth = 120
vim.opt.encoding = 'utf8'

-- Avoid applying EditorConfig to Fugitive buffers
vim.cmd [[ let g:EditorConfig_exclude_patterns = ['fugitive://.*'] ]]
