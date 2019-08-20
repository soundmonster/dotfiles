set termguicolors
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Chiel92/vim-autoformat'
" Plug 'ElmCast/elm-vim'
"" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-lang/vim-elixir'
" Plug 'slashmili/alchemist.vim'

"" Language server foo
Plug 'dense-analysis/ale'
Plug 'GrzegorzKozub/vim-elixirls', { 'do': ':ElixirLsCompileSync' }

Plug 'elzr/vim-json'
" Plug 'OmniSharp/omnisharp-vim' " C#/Unity stuff
"" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
"" Find and replace
Plug 'brooth/far.vim'
" Plug 'fatih/vim-go'
" Plug 'guns/vim-clojure-static'
Plug 'hashivim/vim-terraform'
" Plug 'leafgarland/typescript-vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
" Themes
Plug 'dunstontc/vim-vscode-theme'
Plug 'morhetz/gruvbox'
" Plug 'neomake/neomake'
" Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'rhysd/vim-gfm-syntax'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
" Sensible set of defaults
Plug 'tpope/vim-sensible'
" Automatically adjust whitespace formatting
Plug 'tpope/vim-sleuth'
" Plug 'udalov/kotlin-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
" Plug 'vim-scripts/grep'
" Plug 'vim-syntastic/syntastic'
" coc is a language server client
" Use release branch
" TODO investigate again when more mature
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'


" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on

" Appearance
set background=dark
let g:gruvbox_contrast_dark = 'medium'
colo gruvbox

 
"" vim-airline

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set fillchars+=vert:│

"" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"" Tagbar
nmap <F8> :TagbarToggle<CR>

"" Ack/AG (The Silver Searcher)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"" Avoid applying EditorConfig to Fugitive buffers
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"" Setup ALE for Elixir: https://github.com/GrzegorzKozub/vim-elixirls#how-to-integrate-with-ale
let s:user_dir = stdpath('data')
let g:ale_elixir_elixir_ls_release = s:user_dir . '/plugged/vim-elixirls/elixir-ls/release'
" Uncomment the following line to disable Dialyzer
" let g:ale_elixir_elixir_ls_config = { 'elixirLS': { 'dialyzerEnabled': v:false } }

let g:ale_linters = {}
let g:ale_linters.elixir = [ 'credo', 'elixir-ls' ]
autocmd FileType elixir,eelixir nnoremap <C-]> :ALEGoToDefinition<CR>
autocmd FileType elixir,eelixir nnoremap <C-\> :ALEFindReferences<CR>
autocmd FileType elixir,eelixir nnoremap <s-k> :ALEHover<CR>
" let g:ale_set_baloons=1
let g:ale_sign_error = "\u2717"
let g:ale_sign_warning = "\u26A0"
let g:ale_sign_info = "\u2B95"
let g:ale_sign_style_error = "!"
let g:ale_sign_style_warning = "?"

"" Setup for Elixir: https://bitboxer.de/2016/11/13/vim-for-elixir/
" let g:gutentags_cache_dir = '~/.tags_cache'
" autocmd! BufWritePost * Neomake
" let g:alchemist_tag_disable = 1
" always show status line w/filename
set laststatus=2


"" open NERDTree automatically ...
autocmd StdinReadPre * let s:std_in=1
"" if no files are specified ...
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" or given a dir
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let NERDTreeHijackNetrw=1

"" Syntastic and Rubocop
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_error_symbol = "\u2717"
" let g:syntastic_warning_symbol = "\u26A0"
" let g:syntastic_style_error_symbol = "\u26A1"
" let g:syntastic_style_warning_symbol = "\u2717"
" let g:syntastic_python_python_exec = '/usr/local/bin/python3' " always use python3

set hlsearch
set number
"" When a file has been detected to have been changed outside of Vim and it has not
"" been changed inside of Vim, automatically read it again. When the file has been deleted this is not done.
set autoread

set clipboard=unnamed

let g:vim_json_syntax_conceal = 0 " disable concealment for JSON

set list listchars=tab:→\ ,trail:·

"" NERD Commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

"" Python for NeoVim
let g:python_host_prog = '/Users/leonid/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/leonid/.pyenv/versions/neovim3/bin/python'

"" Setup completion
" Use echodoc for function signatures in command line
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

" Don't show mode in command line since we have it airline
set noshowmode
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Using custom variables to configure values
" - range_above = Search for words N lines above.
" - range_below = Search for words N lines below.
" - mark_above = Mark shown for words N lines above.
" - mark_below = Mark shown for words N lines below.
" - mark_changes = Mark shown for words in the changelist.
call deoplete#custom#var('around', {
\   'range_above': 15,
\   'range_below': 15,
\   'mark_above': '[↑]',
\   'mark_below': '[↓]',
\   'mark_changes': '[*]',
\})
call deoplete#custom#var('member', { 'prefix_patterns': {} } )

set mouse=a

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~20%' }

"" Format Elixir on save
autocmd BufWrite *.exs,*.ex :Autoformat
"" Use jq for formatting JSON
let g:formatdef_my_custom_json = '"jq ."'
let g:formatters_json = ['my_custom_json']

