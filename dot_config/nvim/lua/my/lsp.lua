-- Enable logs for LSP
-- vim.lsp.set_log_level("debug")
-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- Set preferred LSP server for Elixir here
local elixir_lsp = "lexical" -- 'nextls', 'elixirls' or 'lexical'

local deprioritize_copilot = function(entry1, entry2)
  if entry1.source.name == "copilot" and entry2.source.name ~= "copilot" then
    return false
  elseif entry2.copilot == "copilot" and entry1.source.name ~= "copilot" then
    return true
  end
end

local default_cmp_conf = require("cmp.config.default")

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
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
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
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
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    -- { name = 'vsnip' },
    { name = "luasnip" },
    { name = "git" },
    { name = "copilot" },
    -- { name = "nvim_lsp", priority = 4 },
    -- { name = "nvim_lua" },
    -- -- { name = 'vsnip' },
    -- { name = "luasnip",  priority = 2 },
    -- { name = "git" },
    -- { name = "copilot",  priority = 1 },
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
  sorting = {
    comparators = vim.iter({ deprioritize_copilot, default_cmp_conf().sorting.comparators }):flatten():totable(),
  },
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

local lsp_notify = function(client, message_text)
  local Manager = require("noice.message.manager")
  local Message = require("noice.message")
  local Format = require("noice.text.format")
  local Config = require("noice.config")

  local message = Message("lsp", "progress")
  message.opts.progress = {
    message = message_text,
    client_id = client.id,
    client = client.name,
    percentage = 100,
    kind = "end",
  }

  -- message.level = 4 -- debug
  -- message.opts.title = "LSP Message (" .. client.name .. ")"
  -- for level, type in pairs(M.message_type) do
  --   if type == result.type then
  --     message.level = level
  --   end
  -- end
  -- Manag ger.add(message)
  Manager.add(Format.format(message, Config.options.lsp.progress.format_done))
end
-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(client, bufnr)
  require("inlay-hints").on_attach(client, bufnr)
  -- print("Started LSP client for " .. client.name)
  lsp_notify(client, "Started LSP client")
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local wk = require("which-key")
  wk.add({
    { "<leader>w", group = "workspace folders" },
    { "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", desc = "Add workspace folder" },
    { "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", desc = "Remove workspace folder" },
    {
      "<leader>wl",
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
      desc = "List workspace folders",
    },
    { "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "type definition" },
    -- rename is grn by default now?
    -- { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>",                  desc = "rename" },
    { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "code actions" },
    { "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "open float" },
    { "<leader>F", "<cmd>lua vim.lsp.buf.format({ async = false })<cr>", desc = "format file" },
    { "<leader>l", group = "codelenses" },
    { "<leader>ls", "<cmd>lua vim.lsp.codelens.display()<cr>", desc = "show codelenses" },
    { "<leader>lr", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "run codelens on current line" },
    { "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "hover" },
    -- conflicts with Treewalker, keeping it around in case I need it
    -- { "<C-j>",      "<cmd>lua vim.lsp.buf.signature_help()<cr>",          desc = "signature help" },
    { "g", group = "go" },
    { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "go to definition" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "go to declaration" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "go to implementation" },
    -- { "gr",         "<cmd>Telescope lsp_references<cr>",                  desc = "references (popup)" },
    { "gr", "<cmd>lua Snacks.picker.lsp_references()<cr>", desc = "references (popup)" },
    { "gR", "<cmd>Trouble lsp_references<cr>", desc = "references (bottom pane)" },
    { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "previous diagnostic" },
    { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "next diagnostic" },
    {
      "<leader>F",
      "<cmd>lua vim.lsp.buf.format({ async = false })<cr>",
      desc = "format file",
      mode = "v",
    },
  })

  -- format on save / autoformat
  require("my/autoformat").on_attach(client, bufnr)

  -- this doesn't always work reliably, and cause visual noise when logging errors
  if client.server_capabilities.codeLensProvider and elixir_lsp ~= "lexical" then
    vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
  end
end

require("mason").setup()

vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("terraformls", { cmd = { "terraform-ls", "serve", "-log-file /dev/null" } })

vim.lsp.config("elixirls", {
  filetypes = { "elixir", "eelixir", "heex" },
  root_markers = { "mix.lock", ".git" },
  settings = {
    elixirLS = {
      suggestSpecs = false,
      testLenses = false,
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
})
vim.lsp.config("lexical", {
  filetypes = { "elixir", "eelixir", "heex" },
  cmd = { vim.fn.expand("$HOME/Playground/elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh") },
  -- cmd = { vim.fn.expand("$HOME/Playground/elixir/expert/apps/expert/_build/prod/rel/plain/bin/start_expert"), "--stdio" },
  -- cmd = { vim.fn.expand("$HOME/Playground/elixir/expert/apps/expert/burrito_out/expert_darwin_arm64"), "--stdio" },
  root_markers = { "mix.lock", ".git" },
  settings = {},
})

vim.lsp.enable(elixir_lsp)
vim.lsp.enable("gleam")
vim.lsp.enable("rust_analyzer")
require("mason-lspconfig").setup()

local null_ls = require("null-ls")
null_ls.setup({
  on_attach = on_attach,
  sources = {
    -- null_ls.builtins.diagnostics.credo.with({ env = { MIX_ENV = "test" } }),
    -- null_ls.builtins.diagnostics.credo,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shellharden,
  },
})
