if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Specify a directory for plugins
"" - For Neovim: ~/.local/share/nvim/plugged
"" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Chiel92/vim-autoformat'
Plug 'airblade/vim-gitgutter'
" Plug 'elixir-editors/vim-elixir'

"" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'j-hui/fidget.nvim'
Plug 'simrat39/rust-tools.nvim'
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
"" Search
Plug 'mileszs/ack.vim'
"" Themes
" Plug 'dunstontc/vim-vscode-theme'
" Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-lualine/lualine.nvim'

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

Plug 'easymotion/vim-easymotion'

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

"" status line (lualine)
lua << END
END
set fillchars+=vert:│

nnoremap <silent> <space>*  :<C-u>Ack <cword><cr>
nnoremap <silent> <space>b  :<C-u>Telescope buffers<cr>
nnoremap <silent> <space>ff   :<C-u>Telescope live_grep<cr>
nmap <c-p> :<C-u>Telescope find_files<CR>

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
  let command = substitute(a:cmd, "mix test ", "make test file=", "")
  return "DONT_RESET_ECTO=true ".command
endfunction

let g:test#custom_transformations = {'sbs_elixir': function('SBSElixirTransform')}
let g:test#transformation = 'sbs_elixir'

lua << EOF
require'lualine'.setup()
require'nvim-tree'.setup()
require'Comment'.setup()
require"fidget".setup{}

require('telescope').setup{
  -- Telescope settings
  defaults = {
    -- default sorter
    -- file_sorter =  require'telescope.sorters'.get_fuzzy_file
    -- change the sorter, see if it's better
    -- file_sorter =  require'telescope.sorters'.get_fzy_sorter
    -- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    -- file_previewer = require'telescope.previewers'.cat.new,
    -- grep_previewer = require'telescope.previewers'.cat.new,
    -- grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    -- grep_previewer = require'telescope.previewers'.vimgrep.new,
    -- qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    -- qflist_previewer = require'telescope.previewers'.qflist.new,
  }
}

require("trouble").setup {
  padding = false,
  }

require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "c",
    "dockerfile",
    "elixir",
    "erlang",
    "go",
    "gomod",
    "hcl",
    "html",
    "java",
    "json",
    "lua",
    "python",
    "ruby",
    "rust",
    "yaml",
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
}

-- LSP config
local lspconfig = require("lspconfig")

-- Enable logs for LSP
-- vim.lsp.set_log_level("debug")
-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- C-space is taken by language switcher and also not sure what this is for; the completion is super aggressive already
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
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
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer', keyword_length = 4 },
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
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
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
  -- instead of built in list, use Trouble
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
  buf_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- format on save / autoformat
  if client.resolved_capabilities.document_formatting then
      vim.cmd [[augroup Format]]
      vim.cmd [[autocmd! * <buffer>]]
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
      vim.cmd [[augroup END]]
  end
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = { capabilities = capabilities }

    if server.name == "rust_analyzer" then
        -- Initialize the LSP via rust-tools instead
        require("rust-tools").setup {
            -- The "server" property provided in rust-tools setup function are the
            -- settings rust-tools will provide to lspconfig during init.            -- 
            -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
            -- with the user's own settings (opts).
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
        }
        server:attach_buffers()
    elseif server.name == "elixirls" then
        -- local path_to_elixirls = vim.fn.expand("~/dotfiles/elixir-ls/release/language_server.sh")
        server:setup({
            -- cmd = { path_to_elixirls },
            capabilities = capabilities,
            root_dir = require'lspconfig/util'.root_pattern("mix.lock", ".git"),
            on_attach = on_attach,
            settings = {
              elixirLS = {
                dialyzerEnabled = true,
                fetchDeps = true
              }
            }
        })
    elseif server.name == "efm" then
        -- lspconfig.efm.setup({
        server:setup({
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = {"elixir"}
        })
    else
        server:setup(opts)
    end
end)

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
EOF
