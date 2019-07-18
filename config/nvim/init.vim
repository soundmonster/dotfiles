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
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'elzr/vim-json'
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
Plug 'morhetz/gruvbox'
" Plug 'neomake/neomake'
" Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'rhysd/vim-gfm-syntax'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'slashmili/alchemist.vim'
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
Plug 'vim-syntastic/syntastic'
" coc is a language server client
" Use release branch
" TODO investigate again when more mature
" Plug 'neoclide/coc.nvim', {'branch': 'release'}


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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/local/bin/python3' " always use python3

set hlsearch
set number

set clipboard=unnamed

let g:vim_json_syntax_conceal = 0 " disable concealment for JSON

set list listchars=tab:→\ ,trail:·

"" NERD Commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

"" Python for NeoVim
let g:python_host_prog = '/Users/leonid/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/leonid/.pyenv/versions/neovim3/bin/python'

" Use deoplete.
let g:deoplete#enable_at_startup = 1

set mouse=a

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~20%' }

"" Format Elixir on save
autocmd BufWrite *.exs,*.ex :Autoformat

