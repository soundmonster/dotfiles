local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'stevearc/aerial.nvim'
	-- TODO remove
	-- use 'Chiel92/vim-autoformat'
	use { 'lewis6991/gitsigns.nvim', config = function() require 'gitsigns'.setup() end }

	-- LSP
	-- Plug 'williamboman/nvim-lsp-installer'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'

	-- LSP status
	use 'simrat39/rust-tools.nvim'
	-- LS for all files with handy actions; e.g. git blame
	use {
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require 'null-ls'
			null_ls.setup({
				sources = {
					-- null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.completion.luasnip,
					null_ls.builtins.diagnostics.codespell.with({
						extra_args = { "-L", "keypair,keypairs" },
					}),
					-- null_ls.builtins.diagnostics.vale,
					null_ls.builtins.diagnostics.credo.with { env = { MIX_ENV = 'test' } },
					null_ls.builtins.diagnostics.write_good,
					-- null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.zsh,
					-- null_ls.builtins.formatting.codespell,
					null_ls.builtins.formatting.rustfmt,
				}
			})
		end,
		requires = { "nvim-lua/plenary.nvim" },
	}
	-- Show a lightbulb in the gutter if actions available
	use { 'kosayoda/nvim-lightbulb',
		config = function()
			require 'nvim-lightbulb'.setup({
				autocmd = { enabled = true }
			})
		end
	}

	-- Fancy UI
	-- Plug 'rcarriga/nvim-notify'
	use({
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
			})
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		}
	})

	-- Window zoom animations
	use { "anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim"
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require('windows').setup({
				autowidth = { enable = false }
			})
		end
	}

	-- Completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'onsails/lspkind-nvim'
	-- Snippets
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	-- LSP stuff
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				padding = false,
			}
		end
	}
	use 'folke/neodev.nvim'

	-- Key discovery
	use { 'folke/which-key.nvim', config = function() require('which-key').setup {} end }
	-- devicons
	use 'kyazdani42/nvim-web-devicons'
	-- Filesystem sidebar
	use { 'kyazdani42/nvim-tree.lua', config = function() require 'nvim-tree'.setup({}) end }

	use 'ryanoasis/vim-devicons'
	-- telescope (fzf replacement)
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use 'nvim-telescope/telescope-ui-select.nvim'

	-- Search
	use { 'mileszs/ack.vim', config = function()
		vim.cmd [[ 
		if executable('rg')
		  let g:ackprg = 'rg --vimgrep'
		endif
		]]
	end }
	-- Themes
	-- use 'morhetz/gruvbox'
	use { 'dracula/vim', as = 'dracula' }
	use { 'nvim-lualine/lualine.nvim', config = function() require('lualine').setup({}) end }
	-- Darken inactive windows
	use { 'levouh/tint.nvim', config = function()
		require 'tint'.setup({
			tint = -45, -- Darken colors, use a positive value to brighten
			saturation = 0.6, -- Saturation to preserve
			highlight_ignore_patterns = { "WinSeparator", "Status.*", "Telescope*" },
		})
	end }

	use 'rhysd/vim-gfm-syntax'

	use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

	use 'tpope/vim-fugitive'
	-- Sensible set of defaults
	use 'tpope/vim-sensible'
	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	-- Automatically adjust whitespace formatting
	use 'tpope/vim-sleuth'
	use 'tpope/vim-abolish'

	-- Easymotion replacement
	use { 'phaazon/hop.nvim', config = function() require('hop').setup() end }

	-- Testing in tmux
	use { 'janko/vim-test', requires = { 'benmills/vimux' }, config = function()
		vim.cmd [[
		  let test#strategy = 'vimux'

		  function! SBSElixirTransform(cmd) abort
		    " let command = substitute(a:cmd, "apps/[a-z_]*/", "", "")
		    "" devspace
		    " let command = substitute(a:cmd, "mix test ", "make test file=", "")
		    "" dockerless
		    let command = substitute(a:cmd, "mix test ", "make test dockerless=true file=", "")
		    return "DONT_RESET_ECTO=true ".command
		  endfunction

		  let g:test#custom_transformations = {'sbs_elixir': function('SBSElixirTransform')}
		  let g:test#transformation = 'sbs_elixir'
		]]
	end }

	use 'AndrewRadev/sideways.vim'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)