" Space is leader
" map <space> \
let mapleader=" "

set termguicolors
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Chiel92/vim-autoformat'
Plug 'airblade/vim-gitgutter'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-lang/vim-elixir'
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" Plug 'dhruvasagar/vim-zoom'

" Use CoC release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" LSP
" Plug 'neovim/nvim-lspconfig'
" Completion
" Plug 'hrsh7th/nvim-compe'
" Snippets
" Plug 'norcalli/snippets.nvim'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'

Plug 'elzr/vim-json'
"" fzf
" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'
" devicons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
"" telescope (fzf replacement)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"" Find and replace
" Plug 'brooth/far.vim'
Plug 'hashivim/vim-terraform'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
" Themes
" Plug 'dunstontc/vim-vscode-theme'
Plug 'morhetz/gruvbox'
Plug 'rhysd/vim-gfm-syntax'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-projectionist'
" Plug 'tpope/vim-rails'
" Sensible set of defaults
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Automatically adjust whitespace formatting
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'janko/vim-test'
Plug 'benmills/vimux'
Plug 'tpope/vim-abolish'
" Plug 'terryma/vim-expand-region'
" Plug 'AndrewRadev/sideways.vim'

" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on

" Appearance
set background=dark
let g:gruvbox_contrast_dark = 'medium'
colo gruvbox
set textwidth=120
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
set encoding=utf8

"" vim-airline

let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
set fillchars+=vert:│

"" CtrlP
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" nmap <c-p> :Clap files<CR>
" nnoremap <silent> <space>g  :<C-u>Clap grep<cr>
" nnoremap <silent> <space>*  :<C-u>Clap grep ++query=<cword><cr>
nnoremap <silent> <space>*  :<C-u>Ack <cword><cr>
" nnoremap <silent> <space>b  :<C-u>CtrlPBuffer<cr>
nnoremap <silent> <space>b  :<C-u>Telescope buffers<cr>
nnoremap <silent> <space>ff   :<C-u>Telescope live_grep<cr>
nmap <c-p> :<C-u>Telescope find_files<CR>

"" Copy full file to system clipboard
nnoremap <silent> <space>yy ggVG"*y

"" Tagbar
nmap <F8> :TagbarToggle<CR>

"" ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
endif

"" Avoid applying EditorConfig to Fugitive buffers
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" always show status line w/filename
set laststatus=2

"" open NERDTree automatically ...
" autocmd StdinReadPre * let s:std_in=1
"" if no files are specified ...
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" or given a dir
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let NERDTreeHijackNetrw=1
nmap <F4> :NERDTreeFind<CR>
nmap <F3> :NERDTreeToggle<CR>
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

set hlsearch
set number
set relativenumber
"" When a file has been detected to have been changed outside of Vim and it has not
"" been changed inside of Vim, automatically read it again. When the file has been deleted this is not done.
set autoread

"" Use system clipboard
" set clipboard=unnamed

let g:vim_json_syntax_conceal = 0 " disable concealment for JSON
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'elixir', 'json', 'yaml', 'erlang']


set list listchars=tab:→\ ,trail:·

"" NERD Commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

"" Python for NeoVim
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

"" Setup completion
" Use echodoc for function signatures in command line
let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'echo'
let g:echodoc#type = 'virtual'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

" Don't show mode in command line since we have it airline
set noshowmode
" Use deoplete.
" let g:deoplete#enable_at_startup = 1
" " Using custom variables to configure values
" " - range_above = Search for words N lines above.
" " - range_below = Search for words N lines below.
" " - mark_above = Mark shown for words N lines above.
" " - mark_below = Mark shown for words N lines below.
" " - mark_changes = Mark shown for words in the changelist.
" call deoplete#custom#var('around', {
" \   'range_above': 15,
" \   'range_below': 15,
" \   'mark_above': '[↑]',
" \   'mark_below': '[↓]',
" \   'mark_changes': '[*]',
" \})
" call deoplete#custom#var('member', { 'prefix_patterns': {} } )
" "" close the preview window after completion done
" autocmd CompleteDone * silent! pclose!

set mouse=a

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~20%' }

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
  let command = substitute(a:cmd, "apps/[a-z_]*/", "", "")
  return "DONT_RESET_ECTO=true MIX_ENV=test make dockerless dockerless=true cmd='".command."'"
endfunction

let g:test#custom_transformations = {'sbs_elixir': function('SBSElixirTransform')}
let g:test#transformation = 'sbs_elixir'

"" CoC.nvim
let g:coc_global_extensions = [
      \ 'coc-elixir',
      \ 'coc-css',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-lists',
      \ 'coc-json',
      \ 'coc-rls',
      \ 'coc-sh',
      \ 'coc-syntax',
      \ 'coc-yaml',
      \ 'coc-yank'
      \ ]
      " \ 'coc-github',
      " \ 'coc-git',
      " \ 'coc-snippets',
      " \ 'coc-solargraph',
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" END CoC


" Configure NeoVim's LSP client and completion
" https://www.mitchellhanberg.com/how-to-set-up-neovim-for-elixir-development/
"
" always show signcolumns
set signcolumn=yes

" lua << EOF
"   local lspconfig = require("lspconfig")

"   -- Enable logs for LSP
"   -- vim.lsp.set_log_level("debug")
"   -- Neovim doesn't support snippets out of the box, so we need to mutate the
"   -- capabilities we send to the language server to let them know we want snippets.
"   local capabilities = vim.lsp.protocol.make_client_capabilities()
"   capabilities.textDocument.completion.completionItem.snippetSupport = true

"   require'snippets'.use_suggested_mappings()

"   -- Set up autocompletion.
"   vim.o.completeopt = "menuone,noselect"
"   require "compe".setup {
"     enabled = true,
"     autocomplete = true,
"     debug = false,
"     min_length = 1,
"     preselect = "disabled",
"     throttle_time = 80,
"     source_timeout = 200,
"     incomplete_delay = 400,
"     max_abbr_width = 100,
"     max_kind_width = 100,
"     max_menu_width = 100,
"     documentation = true,
"     source = {
"       path = true,
"       buffer = true,
"       calc = true,
"       vsnip = true,
"       nvim_lsp = true,
"       nvim_lua = true,
"       spell = true,
"       tags = true,
"       treesitter = true
"     }
"   }
"   -- A callback that will get called when a buffer connects to the language server.
"   -- Here we create any key maps that we want to have on that buffer.
"   local on_attach = function(_, bufnr)
"     local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
"     local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

"     --Enable completion triggered by <c-x><c-o>
"     buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

"     -- Mappings.
"     local opts = { noremap=true, silent=true }

"     -- See `:help vim.lsp.*` for documentation on any of the below functions
"     buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"     buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
"     buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
"     buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"     buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"     buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
"     buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
"     buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
"     buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"     buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"     buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
"     buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"     buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
"     buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
"     buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
"     buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
"     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

"     vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
"     vim.cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
"     vim.cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
"     vim.cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
"     vim.cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]
"   end

"   -- Finally, let's initialize the Elixir language server

"   -- Replace the following with the path to your installation
"   local path_to_elixirls = vim.fn.expand("~/dotfiles/elixir-ls/release/language_server.sh")
"   -- local util = require 'lspconfig/util'

"   lspconfig.elixirls.setup({
"     cmd = { path_to_elixirls },
"     capabilities = capabilities,
"     root_dir = require'lspconfig/util'.root_pattern("mix.lock", ".git"),
"     on_attach = on_attach,
"     settings = {
"       elixirLS = {
"         -- I choose to disable dialyzer for personal reasons, but
"         -- I would suggest you also disable it unless you are well
"         -- aquainted with dialzyer and know how to use it.
"         dialyzerEnabled = true,
"         -- I also choose to turn off the auto dep fetching feature.
"         -- It often get's into a weird state that requires deleting
"         -- the .elixir_ls directory and restarting your editor.
"         fetchDeps = true
"       }
"     }
"   })

"   lspconfig.efm.setup({
"     capabilities = capabilities,
"     on_attach = on_attach,
"     filetypes = {"elixir"}
"   })
" EOF
