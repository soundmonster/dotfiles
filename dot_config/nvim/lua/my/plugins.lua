local preferred_theme = "tokyonight"
local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Ensure you are on the new branch
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- 1. Install parsers
      ts.install({
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "cpp",
        "css",
        "devicetree",
        "dockerfile",
        "eex",
        "elixir",
        "erlang",
        "gleam",
        "go",
        "gomod",
        "hcl",
        "heex",
        "html",
        "http",
        "java",
        "json",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "ruby",
        "rust",
        "scala",
        "scss",
        "surface",
        "toml",
        "typescript",
        "vim",
        "yaml",
        "zig",
      })

      -- 2. Use Neovim's built-in treesitter API for features
      -- (The old .setup({ highlight = { enable = true } }) is deprecated)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  {
    "nvim-treesitter/nvim-treesitter-context", -- Sticky headers for functions
    opts = { max_lines = 3 },
  },
  -- { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  "aaronik/treewalker.nvim",
  {
    "lewis6991/gitsigns.nvim",
    opts = { current_line_blame = true },
  },
  { "mason-org/mason.nvim", opts = { log_level = vim.log.levels.DEBUG } },
  "mason-org/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = { theme = preferred_theme },
  },
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" },
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
  { "simrat39/inlay-hints.nvim", config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = { indent = { char = "▏" } },
  },
  {
    "sphamba/smear-cursor.nvim",
    enabled = false,
    opts = {
      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,
      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = false,
      smear_terminal_mode = false,
    },
  },

  -- LS for all files with handy actions; e.g. git blame
  { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "folke/noice.nvim",
    enabled = true,
    opts = {
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
    },
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
          { section = "keys", gap = 1, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            cwd = true,
            indent = 2,
            padding = 1,
          },
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
      picker = {
        formatters = {
          file = { truncate = "left" },
        },
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
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>ns",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gf",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gl",
        function()
          Snacks.lazygit.log()
        end,
        desc = "Lazygit Log (cwd)",
      },
      {
        "<leader>nh",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
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
          Snacks.toggle
            .new({
              id = "lsp_autoformat",
              name = "LSP Autoformat",
              get = function()
                return vim.api.nvim_get_var("lsp_autoformat")
              end,
              set = function(value)
                vim.api.nvim_set_var("lsp_autoformat", value)
              end,
            }, {})
            :map("<leader>uF")
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
  -- Lua console
  {
    "yarospace/lua-console.nvim",
    lazy = true,
    keys = {
      { "`", desc = "Lua-console - toggle" },
      { "<Leader>`", desc = "Lua-console - attach to buffer" },
    },
    opts = {},
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
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { -- optional completion source for require statements and module annotations
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
    config = true,
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
    opts = {
      -- disable panel and suggestions, this is handled by copilot-cmp
      suggestion = { enabled = false },
      panel = { enabled = false },
      copilot_node_command = "/opt/homebrew/opt/node/bin/node", -- Node.js version must be > 22
    },
  },
  { "zbirenbaum/copilot-cmp", config = true },
  "AndreM222/copilot-lualine",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = { debug = false },
  },
  {
    "copilotlsp-nvim/copilot-lsp",
    enabled = false,
    config = function()
      local nes = require("copilot-lsp.nes")
      nes.setup({
        move_count_threshold = 2, -- Clear after 2 cursor movements
      })
      vim.g.copilot_nes_debounce = 1500
      vim.lsp.enable("copilot_ls")
      vim.keymap.set("n", "<leader><cr>", function()
        -- Try to jump to the start of the suggestion edit.
        -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
        local _ = nes.walk_cursor_start_edit() or (nes.apply_pending_nes() and nes.walk_cursor_end_edit())
      end, { desc = "Accept Copilot NES suggestion", expr = true })
      -- Clear copilot suggestion with Esc if visible, otherwise preserve default Esc behavior
      vim.keymap.set("n", "<leader><esc>", function()
        nes.clear()
      end, { desc = "Clear Copilot suggestion or fallback" })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
    },
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   build = "make",
  --   opts = {
  --     provider = "copilot",
  --     auto_suggestions_provider = "ollama", -- ollama or copilot
  --     providers = {
  --       ollama = {
  --         endpoint = "http://localhost:11434",
  --         model = "llama3.2:3b",
  --       },
  --       copilot = {
  --         -- model = "claude-3.5-sonnet", -- Optional, specify a model to use
  --         disabled_tools = { "python" }
  --       }
  --     },
  --     -- auto_suggestions_provider = "copilot",
  --     behaviour = {
  --       auto_suggestions = false,           -- Experimental stage
  --       enable_cursor_planning_mode = true, -- enable cursor planning mode!
  --     },
  --     -- File selector configuration
  --     --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
  --     file_selector = {
  --       provider = "telescope", -- Avoid native provider issues
  --       provider_opts = {},
  --     },
  --     input = {
  --       provider = "snacks",
  --       provider_opts = {
  --         -- Additional snacks.input options
  --         title = "Avante Input",
  --         icon = " ",
  --       },
  --     }
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- build = "make",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "folke/snacks.nvim", -- for input provider snacks
  --   },
  -- },
  -- Snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  -- Quickfix replacement of sorts
  {
    "folke/trouble.nvim",
    optional = true,
    opts = {
      padding = false,
      modes = { symbols = { win = { size = 50 } } },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end,
    },
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
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        options = {
          multilines = {
            enabled = true,
          },
          show_source = {
            enabled = true,
            if_many = true,
          },
          -- use_icons_from_diagnostic = true,
        },
      })
      -- auto-disable on float
      vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float

      -- setup diagnostic symbols for sign column
      vim.diagnostic.config({
        -- virtual_lines = { current_line = true },
        -- virtual_text = { current_line = false },
        virtual_text = false,
        -- float = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      })
    end,
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
    "ziontee113/icon-picker.nvim",
    opts = { disable_legacy_commands = true },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      update_focused_file = { enable = true },
      renderer = { group_empty = true },
      view = { width = 40 },
    },
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
    "MagicDuck/grug-far.nvim",
    opts = {
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      engine = "astgrep",
    },
  },
  -- Fancy undo
  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    opts = {}, -- your configuration here
  },
  -- Themes
  { "Mofiqul/dracula.nvim" },
  {
    "rose-pine/neovim",
    enabled = true,
    lazy = false,
    priority = 1000,
    name = "rose-pine",
    config = function()
      -- vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = true,
    lazy = false,
    opts = {
      -- flavour = "mocha",
      -- background = {},
      dim_inactive = { enabled = true },
    },
    config = function()
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "uhs-robert/oasis.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("oasis").setup({
        -- dark_style = "lagoon",
        -- light_style = "dawn"
      })
      -- vim.cmd.colorscheme("oasis")
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      light_style = "day",
      day_brightness = 0.2,
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
    },
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    config = function()
      local auto_dark_mode = require("auto-dark-mode")

      auto_dark_mode.setup({
        -- update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          -- use this for color schemes that don't autoupdate, or to switch the theme entirely
          -- vim.cmd("colorscheme tokyonight-moon")
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          -- vim.cmd("colorscheme tokyonight-day")
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
        theme = preferred_theme,
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
            {
              "copilot",
              -- Default values
              symbols = {
                spinners = "dots", -- has some premade spinners
              },
              show_colors = true,
              show_loading = true,
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
  {
    "tpope/vim-fugitive",
    dependencies = {
      "shumphrey/fugitive-gitlab.vim",
    },
  },
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
    },
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
    opts = {
      file_types = { "markdown", "codecompanion", "Avante" },
      win_options = { conceallevel = { rendered = 0 } },
    },
    ft = { "markdown", "codecompanion", "Avante" },
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
  { "towolf/vim-helm", ft = "helm" },
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
