local plugins = {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "aaronik/treewalker.nvim",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
    end,
  },

  "mason-org/mason.nvim",
  "mason-org/mason-lspconfig.nvim",
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
  { "SmiteshP/nvim-navic",             dependencies = "neovim/nvim-lspconfig" },
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
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
                enable = true,
              },
            },
            experimental = {
              completions = {
                enable = true,
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

  -- LS for all files with handy actions; e.g. git blame
  -- { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
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
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = false,      -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
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
  {
    "folke/snacks.nvim",
    enabled = true,
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        width = 90,
        sections = {
          { section = "header" },
          {
            pane = 2,
            padding = 1,
            section = "terminal",
            ttl = 5 * 60,
            indent = 3,
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            icon = " ",
            title = "Open PRs",
            cmd = "gh pr list -L 3",
            key = "p",
            action = function()
              vim.fn.jobstart("gh pr list --web", { detach = true })
            end,
            height = 7,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
        enabled = true,
      },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = {
        enabled = false,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode", },
      { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom", },
      { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer", },
      { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer", },
      { "<leader>ns", function() Snacks.notifier.show_history() end,   desc = "Notification History", },
      { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer", },
      { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File", },
      { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse", },
      { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line", },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History", },
      { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit", },
      { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)", },
      { "<leader>nh", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications", },
      { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal", },
      { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore", },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",               mode = { "n", "t" }, },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",               mode = { "n", "t" }, },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
              .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
              :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },

  -- Completion
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Library items can be absolute paths
        -- "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved as a plugin
        -- "LazyVim",
        -- When relative, you can also provide a path to the library in the plugin dir
        "luvit-meta/library", -- see below
      },
    },
  },
  { "Bilal2453/luvit-meta",   lazy = true }, -- optional `vim.uv` typings
  {                                          -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },
  {
    "petertriho/cmp-git",
    config = function()
      require("cmp_git").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "onsails/lspkind-nvim",
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
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
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    opts = { debug = false },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end
  },
  {
    "Davidyz/VectorCode",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
    -- cmd = "VectorCode", -- if you're lazy-loading VectorCode
  },
  {
    "olimorris/codecompanion.nvim",
    opts = function()
      return {
        extensions = {
          vectorcode = {
            opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
          },
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true, -- Show mcp tool results in chat
              make_vars = true,           -- Convert resources to #variables
              make_slash_commands = true, -- Add prompts as /slash commands
            }
          }
        },
        display = {
          action_palette = {
            -- prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
            provider = "default",                 -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
            opts = {
              show_default_actions = true,        -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            },
          },
          diff = { provider = "mini_diff" },
        },
        strategies = {
          chat = {
            adapter = "copilot",
            model = "claude-3.7-sonnet", -- "gpt-4.1", "gpt-4o", "claude-3.7-sonnet", "o3-mini", "claude-3.5-sonnet", "claude-3.7-sonnet-thought",
          },
          inline = {
            adapter = "copilot",
            model = "claude-3.7-sonnet", -- "gpt-4.1", "gpt-4o", "claude-3.7-sonnet", "o3-mini", "claude-3.5-sonnet", "claude-3.7-sonnet-thought",
            keymaps = {
              accept_change = {
                modes = { n = "<leader>a" },
                description = "Accept the suggested change",
              },
              reject_change = {
                modes = { n = "<leader>r" },
                description = "Reject the suggested change",
              },
            },
          },
          cmd = {
            adapter = "copilot",
            model = "claude-3.7-sonnet", -- "gpt-4.1", "gpt-4o", "claude-3.7-sonnet", "o3-mini", "claude-3.5-sonnet", "claude-3.7-sonnet-thought",
          }
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "j-hui/fidget.nvim"
    },
    init = function()
      require("my.cc_fidget"):init()
    end,
  },
  -- Snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  -- Quickfix replacement of sorts
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        padding = false,
        modes = { symbols = { win = { size = 50 } } },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
      search = {
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },
  -- Key discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = require("my.keys"),
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
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "folke/trouble.nvim",
    },
    lazy = true,
    cmd = "Telescope",
    config = function()
      local trouble = require("trouble.sources.telescope")
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<c-t>"] = trouble.open,
              ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<c-a>"] = actions.add_to_qflist,
              ["<c-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
              ["<c-t>"] = trouble.open,
              ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<c-a>"] = actions.add_to_qflist,
              ["<c-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          undo = {
            use_delta = false,
            use_custom_command = { "bash", "-c", "echo '$DIFF' | delta --no-gitconfig" },
          },
        },
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
    end,
  },

  -- Search and replace
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
        engine = 'astgrep'
      });
    end
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
          floats = "dark",   -- style for floating windows
        },
        sidebars = { "qf", "help" },
        on_highlights = function(hl, c)
          -- local bg_prompt = c.bg_float
          local bg_prompt = c.bg_highlight
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = bg_prompt,
          }
          hl.TelescopePromptBorder = {
            bg = bg_prompt,
            fg = bg_prompt,
          }
          hl.TelescopePromptTitle = {
            bg = bg_prompt,
            fg = c.fg,
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
            {
              require("noice").api.status.message.get_hl,
              cond = require("noice").api.status.message.has,
            },
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
              color = { fg = "#ff9e64" },
            },
            "encoding",
            "fileformat",
            "filetype",
            {
              require("my/autoformat").print_autoformat,
              on_click = require("my/autoformat").toggle_autoformat,
            },
          },
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  "HiPhish/rainbow-delimiters.nvim",
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
  -- begin tpope
  "tpope/vim-abolish",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  -- end tpope
  -- Projectionist replacement
  {
    "rgroli/other.nvim",
    main = "other-nvim",
    opts = {
      mappings = {
        "rails",
        "golang",
        "rust",
        "elixir",
      },
    }
  },
  -- EasyMotion replacement
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jfpedroza/neotest-elixir",
    },
    config = function()
      require("neotest").setup({
        icons = {
          passed = "✔",
          failed = "⨯",
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
                return vim.iter({ { "env", "DONT_RESET_ECTO=true", "MIX_ENV=test" }, cmd }):flatten():totable()
              else
                return cmd
              end
            end,
          }),
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- towolf/vim-helm provides basic syntax highlighting and filetype detection
  -- ft = 'helm' is important to not start yamlls
  { "towolf/vim-helm",             ft = "helm" },
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
