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
    {
        "elixir-tools/elixir-tools.nvim",
        enabled = false,
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local elixir = require("elixir")
            -- local elixirls = require("elixir.elixirls")

            elixir.setup({
                nextls = {
                    enable = true,
                    -- cmd = "/Users/leonid.batyuk/Playground/elixir/next-ls/burrito_out/next_ls_darwin_arm64",
                    init_options = {
                        extensions = {
                            credo = {
                                enabled = true,
                            },
                        },
                        experimental = {

                            completions = {
                                enabled = true,
                            },
                        },
                    },
                },
                credo = { enable = false },
                elixirls = { enable = false },
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "simrat39/inlay-hints.nvim",
        config = function()
            require("inlay-hints").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({ indent = { char = "▏" } })
        end,
    },

    -- LSP status
    "simrat39/rust-tools.nvim",
    -- LS for all files with handy actions; e.g. git blame
    -- { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
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
        enabled = true,
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
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = false, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
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

    -- Completion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    {
        "petertriho/cmp-git",
        config = function()
            require("cmp_git").setup()
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    "onsails/lspkind-nvim",
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                -- disable panel and suggestions, this is handled by copilot-cmp
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    -- "github/copilot.vim",
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

    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup({
                override = function(root_dir, library)
                    if root_dir:find("/dotfiles/config/nvim", 1, true) then
                        library.enabled = true
                        library.plugins = true
                    end
                end,
            })
        end,
    },

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
                view = { width = 40 },
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
    "HiPhish/rainbow-delimiters.nvim",
    -- Git
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    -- Automatically adjust whitespace formatting
    "tpope/vim-sleuth",
    "tpope/vim-abolish",

    -- Easymotion replacement
    {
        "smoka7/hop.nvim",
        version = "*",
        opts = {},
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "jfpedroza/neotest-elixir",
        },
        config = function()
            require("neotest").setup({
                icons = {
                    passed = "",
                    running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                },
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
