-- require("neodev").setup({})

-- Enable logs for LSP
-- vim.lsp.set_log_level("debug")
-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- setup diagnostic symbols for sign column
-- TODO these signs are off, needs an update
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

cmp.setup({
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- C-space is taken by language switcher and also not sure what this is for; the completion is super aggressive already
        -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 4 },
        { name = "nvim_lua" },
        -- { name = 'vsnip' },
        { name = "luasnip", priority = 2 },
        { name = "git" },
        { name = "copilot", priority = 1 },
    }, {
        {
            name = "buffer",
            option = {
                keyword_length = 4,
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end,
            },
        },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            symbol_map = { Copilot = "" },
            maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            menu = {
                git = "[Git]",
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                copilot = "[Copilot]",
            },
        }),
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(client, bufnr)
    -- require("inlay-hints").on_attach(client, bufnr)
    -- require("notify").notify("Started LSP client for " .. client.name)
    print("Started LSP client for " .. client.name)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    -- TODO remove this
    -- if client.name == "elixirls" then
    --     require("elixir.elixirls").on_attach(client, bufnr)
    -- end

    --Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local wk = require("which-key")
    wk.register({
        ["<leader>"] = {
            w = {
                name = "workspace folders",
                a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add workspace folder" },
                r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove workspace folder" },
                l = {
                    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
                    "List workspace folders",
                },
            },
            D = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "type definition" },
            rn = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
            ca = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code actions" },
            e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "open float" },
            F = { "<cmd>lua vim.lsp.buf.format({ async = false })<cr>", "format file" },
            l = {
                name = "codelenses",
                s = { "<cmd>lua vim.lsp.codelens.display()<cr>", "show codelenses" },
                r = { "<cmd>lua vim.lsp.codelens.run()<cr>", "run codelens on current line" },
            },
        },
        K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },
        ["<C-j>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "hover" },
        g = {
            name = "go",
            d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "go to definition" },
            D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "go to declaration" },
            i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "go to implementation" },
            r = { "<cmd>Telescope lsp_references<cr>", "references (popup)" },
            R = { "<cmd>Trouble lsp_references<cr>", "references (bottom pane)" },
        },
        ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "previous diagnostic" },
        ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "next diagnostic" },
    })

    wk.register({
        ["<leader>"] = {
            F = { "<cmd>lua vim.lsp.buf.format({ async = false })<cr>", "format file" },
        },
    }, { mode = "v" })

    -- format on save / autoformat
    require("my/autoformat").on_attach(client, bufnr)
    -- if client.server_capabilities.documentFormattingProvider then
    -- 	vim.cmd([[augroup Format]])
    -- 	vim.cmd([[autocmd! * <buffer>]])
    -- 	vim.cmd([[autocmd BufWritePre <buffer> lua vim.g.lsp_autoformat and vim.lsp.buf.format({ async = false })]])
    -- 	vim.cmd([[augroup END]])
    -- end
    if client.server_capabilities.codeLensProvider then
        vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
    end
end

local elixir_lsp = "lexical" -- 'nextls', 'elixirls' or 'lexical'
local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
        require("rust-tools").setup({
            -- TODO find out how to set all the keymaps for rust tools
            on_attach = on_attach,
            tools = {
                on_initialized = function()
                    require("inlay-hints").set_all()
                end,
                inlay_hints = {
                    auto = false,
                },
            },
            capabilities = capabilities,
        })
    end,
    ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    workspace = { library = { "${3rd}/luv/library", "${3rd}/luassert/library" } },
                    hint = { enable = true },
                    codelens = { enable = true },
                    format = { enable = false },
                },
            },
        })
    end,
    ["elixirls"] = function()
        if elixir_lsp == "elixirls" then
            lspconfig["elixirls"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = lspconfig.util.root_pattern("mix.lock", ".git"),
                settings = {
                    elixirLS = {
                        suggestSpecs = true,
                        testLenses = true,
                        dialyzerEnabled = true,
                        fetchDeps = true,
                    },
                },
            })
        end
    end,
})

-- Manual set up for language servers
local configs = require("lspconfig.configs")

if not configs.lexical then
    configs.lexical = {
        default_config = {
            filetypes = { "elixir", "eelixir", "heex" },
            cmd = { "/Users/leonid.batyuk/Playground/elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
            root_dir = lspconfig.util.root_pattern("mix.lock", ".git"),
            settings = { dialyzerEnabled = true },
        },
    }
end

local mason_registry = require("mason-registry")

if mason_registry.is_installed("nextls") and not configs.nextls then
    local nextls = mason_registry.get_package("nextls")
    -- this will only ever run on a Mac
    local binary = ""
    if vim.loop.os_uname().machine == "arm64" then
        binary = "next_ls_darwin_arm64"
    else
        binary = "next_ls_darwin_amd64"
    end
    local path_to_binary = nextls:get_install_path() .. "/" .. binary
    print(path_to_binary)
    configs.nextls = {
        default_config = {
            filetypes = { "elixir", "eelixir", "heex" },
            -- cmd = mason_registry.get_install_path("nextls"),
            cmd = { path_to_binary, "--stdio" },
            root_dir = lspconfig.util.root_pattern("mix.lock", ".git"),
            settings = {
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
    }

    if elixir_lsp == "nextls" then
        lspconfig["nextls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

if elixir_lsp == "lexical" then
    -- Manual setup for lexical, an LSP for Elixir
    lspconfig["lexical"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local null_ls = require("null-ls")
null_ls.setup({
    on_attach = on_attach,
    sources = {
        -- null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.diagnostics.codespell.with({
            extra_args = { "-L", "keypair,keypairs,crate" },
        }),
        -- null_ls.builtins.diagnostics.vale,
        -- null_ls.builtins.diagnostics.credo.with({ env = { MIX_ENV = "test" } }),
        -- null_ls.builtins.diagnostics.credo,
        -- null_ls.builtins.diagnostics.write_good,
        -- null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.jsonlint,
        null_ls.builtins.diagnostics.zsh,
        -- null_ls.builtins.formatting.codespell,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.jq,
    },
})
