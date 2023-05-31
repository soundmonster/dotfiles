local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("stevearc/aerial.nvim")
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end,
    })

    -- LSP
    -- Plug 'williamboman/nvim-lsp-installer'
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use({
        "utilyre/barbecue.nvim",
        disable = true,
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup({ theme = "tokyonight" })
        end,
    })
    use({
        "SmiteshP/nvim-navic",
        disable = true,
        requires = "neovim/nvim-lspconfig",
    })
    use({ "elixir-tools/elixir-tools.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use({
        "simrat39/inlay-hints.nvim",
        config = function()
            require("inlay-hints").setup()
        end,
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                char = "▏",
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    })

    -- LSP status
    use("simrat39/rust-tools.nvim")
    -- LS for all files with handy actions; e.g. git blame
    use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })
    -- Show a lightbulb in the gutter if actions available
    use({
        "kosayoda/nvim-lightbulb",
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true },
            })
        end,
    })

    use({
        "folke/noice.nvim",
        disable = false, -- https://github.com/folke/noice.nvim/issues/298
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
            -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    })

    -- eompletion
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("onsails/lspkind-nvim")
    -- Snippets
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- LSP stuff
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                padding = false,
            })
        end,
    })

    use("folke/neodev.nvim")

    -- Key discovery
    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                show_help = false,
                show_keys = false,
            })
        end,
    })
    -- devicons
    use("kyazdani42/nvim-web-devicons")
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                update_focused_file = { enable = true },
            })
        end,
    })

    use("ryanoasis/vim-devicons")
    -- telescope (fzf replacement)
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("nvim-telescope/telescope-ui-select.nvim")

    -- Search
    use({
        "mileszs/ack.vim",
        config = function()
            vim.cmd([[ 
		if executable('rg')
		  let g:ackprg = 'rg --vimgrep'
		endif
		]])
        end,
    })
    -- Themes
    use({
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                dim_inactive = true,
                lualine_bold = true,
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
                on_highlights = function(hl, c)
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = {
                        bg = c.bg_dark,
                        fg = c.fg_dark,
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopePromptNormal = {
                        bg = prompt,
                    }
                    hl.TelescopePromptBorder = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePromptTitle = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                end,
            })
        end,
    })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup({
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                integrations = {
                    aerial = true,
                    cmp = true,
                    gitsigns = true,
                    hop = true,
                    lsp_trouble = true,
                    mason = true,
                    neotest = true,
                    noice = true,
                    notify = true,
                    nvimtree = true,
                    semantic_tokens = true,
                    telescope = true,
                    treesitter = true,
                    which_key = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                },
            })
        end,
    })
    use({
        "f-person/auto-dark-mode.nvim",
        config = function()
            local auto_dark_mode = require("auto-dark-mode")

            auto_dark_mode.setup({
                -- update_interval = 1000,
                set_dark_mode = function()
                    vim.api.nvim_set_option("background", "dark")
                    vim.cmd("colorscheme tokyonight-storm")
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option("background", "light")
                    vim.cmd("colorscheme tokyonight-day")
                end,
            })
            auto_dark_mode.init()
        end,
    })
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            -- local navic = require("nvim-navic")
            require("lualine").setup({
                theme = "tokyonight",
                sections = {
                    lualine_c = {
                        "filename",
                        -- { navic.get_location, cond = navic.is_available },
                    },
                    lualine_x = {
                        "encoding",
                        "fileformat",
                        "filetype",
                        { "g:lsp_autoformat", on_click = require("my/autoformat").toggle_autoformat },
                    },
                },
            })
        end,
    })
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use("tpope/vim-fugitive")
    -- Sensible set of defaults
    -- use 'tpope/vim-sensible'
    use("tpope/vim-surround")
    use("tpope/vim-repeat")
    -- Automatically adjust whitespace formatting
    use("tpope/vim-sleuth")
    use("tpope/vim-abolish")

    -- Easymotion replacement
    use({
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup()
        end,
    })

    use({
        "nvim-neotest/neotest",
        requires = {
            -- "jfpedroza/neotest-elixir",
            { "soundmonster/neotest-elixir", branch = "extra_block_identifiers" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-elixir")({
                        extra_block_identifiers = { "test_with_mock", "test_with_tracking" },
                        -- TODO figure out how to make interactive tests work; escaping is broken
                        -- mix_task = "test.interactive",
                        -- args = { "--no-watch" },
                        post_process_command = function(cmd)
                            if string.find(vim.fn.getcwd(), "Projects/sbs-") then
                                if vim.loop.fs_stat(vim.fn.getcwd() .. "/.env.local") == nil then
                                    local wrapped_cmd = {}
                                    for index, value in ipairs(cmd) do
                                        wrapped_cmd[index] = "'" .. value .. "'"
                                    end
                                    return {
                                        "make",
                                        "dockerless",
                                        "dockerless=true",
                                        "cmd=MIX_ENV=test DONT_RESET_ECTO=true " .. table.concat(wrapped_cmd, " "),
                                    }
                                else
                                    return vim.tbl_flatten({ { "env", "DONT_RESET_ECTO=true", "MIX_ENV=test" }, cmd })
                                end
                            else
                                return cmd
                            end
                        end,
                    }),
                },
            })
        end,
    })

    use("AndrewRadev/sideways.vim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
