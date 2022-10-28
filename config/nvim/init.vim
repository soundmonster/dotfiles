if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Specify a directory for plugins
"" - For Neovim: ~/.local/share/nvim/plugged
"" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'dstein64/vim-startuptime'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'stevearc/aerial.nvim'
Plug 'Chiel92/vim-autoformat'
Plug 'lewis6991/gitsigns.nvim'

"" LSP
" Plug 'williamboman/nvim-lsp-installer'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" LSP status
Plug 'simrat39/rust-tools.nvim'
" LS for all files with handy actions; e.g. git blame
Plug 'jose-elias-alvarez/null-ls.nvim'
" Show a lightbulb in the gutter if actions available
Plug 'kosayoda/nvim-lightbulb'

"" Fancy UI
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'

"" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
"" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
"" LSP stuff
Plug 'folke/trouble.nvim'

" peek at registers
Plug 'junegunn/vim-peekaboo'
" devicons
Plug 'kyazdani42/nvim-web-devicons'
"" Filesystem sidebar
Plug 'kyazdani42/nvim-tree.lua'

Plug 'ryanoasis/vim-devicons'
"" telescope (fzf replacement)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'

"" Search
Plug 'mileszs/ack.vim'
"" Themes
" Plug 'dunstontc/vim-vscode-theme'
" Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-lualine/lualine.nvim'
" Darken inactive windows
Plug 'levouh/tint.nvim'

Plug 'rhysd/vim-gfm-syntax'

Plug 'numToStr/Comment.nvim'

Plug 'tpope/vim-fugitive'
"" Sensible set of defaults
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"" Automatically adjust whitespace formatting
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-abolish'

"" Easymotion replacement
Plug 'phaazon/hop.nvim'

"" Testing in tmux
Plug 'janko/vim-test'
Plug 'benmills/vimux'

Plug 'AndrewRadev/sideways.vim'
Plug 'szw/vim-maximizer'

" Initialize plugin system
call plug#end()

syntax on
" Space is leader,
" map <space> \
let mapleader=" "

set termguicolors
filetype plugin indent on

set hlsearch
set number
set relativenumber
"" When a file has been detected to have been changed outside of Vim and it has not
"" been changed inside of Vim, automatically read it again. When the file has been deleted this is not done.
set autoread
" Don't show mode in command line since we have it lualine
set noshowmode
set mouse=a

" always show signcolumns
set signcolumn=yes
set list listchars=tab:→\ ,trail:·
" always show status line w/filename
" set laststatus=2
" show just one status line instead of many
set laststatus=3

" Theme
set background=dark
" let g:gruvbox_contrast_dark = 'medium'
" colorscheme gruvbox
colorscheme dracula

" Appearance
set textwidth=120
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
set encoding=utf8
"" Use system clipboard
" set clipboard=unnamed

set fillchars+=vert:│

" nnoremap <silent> <space>*  :<C-u>Ack! <cword><cr>
nnoremap <silent> <space>*  <cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>")})<cr>
nnoremap <silent> <space>b  :<C-u>Telescope buffers<cr>
nnoremap <silent> <space>ff   :<C-u>Telescope live_grep<cr>
nnoremap <silent> <c-p> <cmd>Telescope find_files<CR>

"" maximizer toggle
let g:maximizer_set_default_mapping = 1
let g:maximizer_set_mapping_with_bang = 0
let g:maximizer_default_mapping_key = '<F8>'

"" sideways
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>

"" Reselect pasted text
nnoremap gp `[v`]
"" Copy full file to system clipboard
nnoremap <silent> <space>yy ggVG"*y
vnoremap <silent> <space>yy "*y

"" ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

"" Avoid applying EditorConfig to Fugitive buffers
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


nnoremap <F3> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <F4> :NvimTreeFindFile<CR>
nnoremap <F9> :TroubleToggle<CR>

let g:vim_json_syntax_conceal = 0 " disable concealment for JSON
" this doesn't really work with TreeSitter-driven highlighting
" let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'elixir', 'json', 'yaml', 'erlang']

"" Python for NeoVim
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'


"" Format Elixir on save
" autocmd BufWrite *.exs,*.ex :Autoformat
"" Use jq for formatting JSON
let g:formatdef_my_custom_json = '"jq ."'
let g:formatters_json = ['my_custom_json']

let g:formatdef_my_custom_elixir = '"MIX_ENV=test mix format -"'
let g:formatters_elixir = ['my_custom_elixir']

" Vim Test
" let test#strategy = 'neovim'
nnoremap <space>t  :<C-u>TestNearest<cr>
nnoremap <space>T  :<C-u>TestFile<cr>
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

lua << EOF
require'lualine'.setup()
require'nvim-tree'.setup({})
require'Comment'.setup()
require"notify".setup({
  background_colour = "#282A36",
})
require'noice'.setup()
require'gitsigns'.setup()
require'nvim-lightbulb'.setup({autocmd = {enabled = true}})

local null_ls = require'null-ls'
null_ls.setup({
  sources = {
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.diagnostics.codespell,
    -- null_ls.builtins.diagnostics.vale,
    null_ls.builtins.diagnostics.credo.with{ env = { MIX_ENV = 'test' } },
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.codespell,
    null_ls.builtins.formatting.rustfmt,
  }
})

require'tint'.setup({
  tint = -45,  -- Darken colors, use a positive value to brighten
  saturation = 0.6,  -- Saturation to preserve
})


require'hop'.setup()

vim.api.nvim_set_keymap('n', '<space><space>w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>j', "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('n', '<space><space>k', "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('v', '<space><space>w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('v', '<space><space>b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('v', '<space><space>j', "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('v', '<space><space>k', "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})


local trouble = require'trouble.providers.telescope'
local telescope = require'telescope'
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- This is your opts table
telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    ["ui-select"] = {
      require'telescope.themes'.get_dropdown{}
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('ui-select')
telescope.load_extension('fzf')
telescope.load_extension('aerial')

require'trouble'.setup {
  padding = false,
}

require('nvim-treesitter.configs').setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "bash",
    "c",
    "c_sharp", -- unity
    "cmake",
    "cpp",
    "css",
    "devicetree",
    "dockerfile",
    "eex",
    "elixir",
    "erlang",
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
    "python",
    "regex",
    "ruby",
    "rust",
    "scss",
    "surface",
    "toml",
    "typescript",
    "vim",
    "yaml",
    "zig",
  },
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- disable = { "elixir" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

-- LSP config
local lspconfig = require("lspconfig")

-- Enable logs for LSP
-- vim.lsp.set_log_level("debug")
-- Setup nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- C-space is taken by language switcher and also not sure what this is for; the completion is super aggressive already
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
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
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' },
    { name = 'luasnip' },
  }, {
    {
      name = 'buffer',
      option = {
        keyword_length = 4,
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
      }
    },
  }),
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      with_text = true,
      menu = ({
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        vsnip = "[snip]",
      })
    })
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  require("aerial").on_attach(client, bufnr)

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<F6>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- instead of built in list, use Trouble
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
  buf_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = false })<CR>", opts)

  -- format on save / autoformat
  if client.server_capabilities.documentFormattingProvider then
      vim.cmd [[augroup Format]]
      vim.cmd [[autocmd! * <buffer>]]
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = false }]]
      vim.cmd [[augroup END]]
  end
  vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
end

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
        end,
        -- Next, you can provide targeted overrides for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function ()
            require("rust-tools").setup {
              -- TODO find out how to set all the keymaps for rust tools
              on_attach = on_attach,
              capabilities = capabilities,
            }
        end,
        ["elixirls"] = function ()
            require("lspconfig")["elixirls"].setup {
              on_attach = on_attach,
              capabilities = capabilities,
              root_dir = require("lspconfig/util").root_pattern("mix.lock", ".git"),
              settings = {
                elixirLS = {
                  dialyzerEnabled = true,
                  fetchDeps = true
                }
              }
            }
        end
    }

require'aerial'.setup{
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
    -- Jump up the tree with '[[' or ']]'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
  end
}

EOF
