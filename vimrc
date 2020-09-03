"" vim-powerline
"source /Users/leonid/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/plugin/powerline.vim


execute pathogen#infect()

set omnifunc=syntaxcomplete#Complete

"" deoplete code completion
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" use tab for completion
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"" vim-airline

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"" let g:airline_theme = 'base16_ashes'
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
let g:gutentags_cache_dir = '~/.tags_cache'
autocmd! BufWritePost * Neomake
let g:alchemist_tag_disable = 1

" Appearance
set background=dark
let g:gruvbox_contrast_dark = 'medium'
" colo darcula
colo gruvbox
set textwidth=120
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

"" always show status line w/filename
set laststatus=2

if !has('gui_running')
	set t_Co=256
endif

syntax on
filetype plugin indent on

"" open NERDTree automatically ...
autocmd StdinReadPre * let s:std_in=1
"" if no files are specified ...
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" or given a dir
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let NERDTreeHijackNetrw=1

"" use these settings for yaml files in puppet-site
autocmd BufRead ~/Projects/puppet-site/*.yaml set sw=2 ts=2 et

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

set mouse=a         " use mouse everywhere
set ttymouse=xterm2 " Enable window-split drag-to-resize and live visual selection

set clipboard=unnamed

let g:vim_json_syntax_conceal = 0 " disable concealment for JSON

set list listchars=tab:→\ ,trail:·

"" NERD Commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
