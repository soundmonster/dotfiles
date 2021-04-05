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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Chiel92/vim-autoformat'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'mustache/vim-mustache-handlebars'
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'dhruvasagar/vim-zoom'

" Use CoC release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'elzr/vim-json'
"" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" devicons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
"" telescope (fzf replacement)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"" Find and replace
Plug 'brooth/far.vim'
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
" Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
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
" Let's not have a hard time
" Plug 'takac/vim-hardtime'
Plug 'tpope/vim-abolish'
Plug 'terryma/vim-expand-region'
Plug 'AndrewRadev/sideways.vim'

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
" if hidden is not set, TextEdit might fail.
set hidden

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

" Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup

" Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Set up hardtime
let g:hardtime_default_on = 0
" let g:hardtime_timeout = 1000
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
" let g:hardtime_ignore_quickfix = 1
" let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 3
