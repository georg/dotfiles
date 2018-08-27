set nocompatible " choose no compatibility with legacy vi
runtime macros/matchit.vim
runtime ftplugin/man.vim

filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

call plug#begin()
Plug 'Shougo/denite.nvim'
Plug 'flazz/vim-colorschemes'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'bingaman/vim-sparkup'
Plug 'sickill/vim-pasta'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/rainbow_parentheses.vim'
Plug 'jpalardy/vim-slime'
call plug#end()

syntax enable
set encoding=utf-8
set modelines=0

set background=dark
let g:solarized_termcolors=256
colorscheme c64

set number
set ruler       " show the cursor position all the time
set cursorline
set showcmd     " display incomplete commands
set undofile
set wildmenu
set wildmode=full
set foldlevelstart=99

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮

let ruby_fold=1
let ruby_space_errors = 1
let c_space_errors = 1

let mapleader=","

"" Searching
set hlsearch     " highlight matches
set incsearch    " incremental searching
set showmatch    " show matches
set ignorecase   " searches are case insensitive...
set smartcase    " ... unless they contain at least one capital letter
nnoremap <leader><space> :noh<cr> " clear search

nnoremap <leader>ft Vatzf
nnoremap <leader>v V`]
inoremap jj <ESC> " Quick escape

if has("autocmd")
  au BufNewFile,BufRead *.json set ft=javascript " treat JSON like JavaScript

  " Remember last location in file, but not for commit messages
  " see :help last-position-jump
  au BufReadPost * if &filetype != '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

" provide some context when editing
set scrolloff=3

" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <leader><leader> <c-^>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

set noswapfile
set backupdir=~/.vim/backup
set undodir=~/.vim/backup
set directory=~/.vim/backup

" yankstack
nmap <ESC>p <Plug>yankstack_substitute_older_paste
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <ESC>n <Plug>yankstack_substitute_newer_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Rainbox Parentheses {{{
nnoremap <leader>R :RainbowParenthesesToggle<cr>
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
" }}}

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line
  set statusline=%t%(\ [%n%m]%)%(\ %H%R%W%)\ 

  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " Finish the statusline
  set statusline+=%(%c-%v,\ %l\ of\ %L,\ (%o)\ %P\ 0x%B\ (%b)%)
endif

" Syntax changes Ruby 1.8 -> 1.9 {{{
command! -range Ruby19ify <line1>,<line2>s/:\([^ ]\+\) \+=> \+/\1: /g | :noh
" }}}

" R plugin {{{
let g:r_indent_align_args = 0
let g:vimrplugin_assign = 0
let g:r_syntax_folding = 1
" }}}

" Denite {{{

if executable('rg')
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
endif

nnoremap [denite] <Nop>
nmap     <C-f> [denite]

nnoremap <silent> <C-p>     :<C-u>Denite
      \ -buffer-name=buffer file/rec<CR>
nnoremap <silent> [denite]g  :<C-u>Denite
      \ grep<CR>
nnoremap <silent> [denite]r  :<C-u>Denite
      \ -buffer-name=register register<CR>
nnoremap <silent> [denite]o  :<C-u>Denite
      \ outline<CR>
nnoremap <silent> [denite]w  :<C-u>DeniteCursorWord
      \ tag file/rec<CR>

" }}}
