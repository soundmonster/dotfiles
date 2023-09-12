local plugins = {

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "stevearc/aerial.nvim",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end,
    },

    -- Close unused buffers
    {
        "axkirillov/hbac.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    },
    -- LSP
    -- Plug 'williamboman/nvim-lsp-installer'
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "utilyre/barbecue.nvim",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            require("barbecue").setup({ theme = "tokyonight" })
        end,
    },
    { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" },
    { "elixir-tools/elixir-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    {
        "simrat39/inlay-hints.nvim",
        config = function()
            require("inlay-hints").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                char = "▏",
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },

    -- LSP status
    "simrat39/rust-tools.nvim",
    -- LS for all files with handy actions; e.g. git blame
    { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    -- Show a lightbulb in the gutter if actions available
    {
        "kosayoda/nvim-lightbulb",
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true },
            })
        end,
    },

    {
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
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },

    -- eompletion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "onsails/lspkind-nvim",
    -- Snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- LSP stuff
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({
                padding = false,
            })
        end,
    },

    "folke/neodev.nvim",

    -- Key discovery
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                show_help = false,
                show_keys = false,
            })
        end,
    },
    -- devicons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                update_focused_file = { enable = true },
            })
        end,
    },

    "ryanoasis/vim-devicons",
    -- telescope (fzf replacement)
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",

    -- Search
    {
        "mileszs/ack.vim",
        config = function()
            vim.cmd([[ 
		if executable('rg')
		  let g:ackprg = 'rg --vimgrep'
		endif
		]])
        end,
    },
    -- Themes
    {
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
                        fg = c.fg,
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
    },
    {
        "f-person/auto-dark-mode.nvim",
        config = function()
            local auto_dark_mode = require("auto-dark-mode")

            auto_dark_mode.setup({
                -- update_interval = 1000,
                set_dark_mode = function()
                    vim.api.nvim_set_option("background", "dark")
                    vim.cmd("colorscheme tokyonight-moon")
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option("background", "light")
                    vim.cmd("colorscheme tokyonight-day")
                end,
            })
            auto_dark_mode.init()
        end,
    },
    {
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
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    -- Automatically adjust whitespace formatting
    "tpope/vim-sleuth",
    "tpope/vim-abolish",

    -- Easymotion replacement
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    -- {
    --     "phaazon/hop.nvim",
    --     config = function()
    --         require("hop").setup()
    --     end,
    -- },

    {
        "nvim-neotest/neotest",
        dependencies = {
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
    },

    "AndrewRadev/sideways.vim",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}
require("lazy").setup(plugins, opts)
