set nocompatible " choose no compatibility with legacy vi
runtime macros/matchit.vim
runtime ftplugin/man.vim

filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

syntax enable
set encoding=utf-8
set modelines=0

set background=dark
let g:solarized_termcolors=256
colorscheme solarized

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
let vimrplugin_screenplugin = 0
let g:r_indent_align_args = 0
" }}}

" Unite {{{

" simulate ctrlp
let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = 'botright'

call unite#filters#matcher_default#use(['matcher_fuzzy'])

let g:unite_source_history_yank_enable = 1

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--noheading --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap [unite] <Nop>
nmap     <C-f> [unite]

nnoremap <silent> <C-p>     :<C-u>Unite
      \ -buffer-name=files buffer file_mru bookmark file_rec/async<CR>
nnoremap <silent> [unite]f  :<C-u>Unite
      \ -buffer-name=files buffer file_mru bookmark file_rec/async<CR>
nnoremap <silent> [unite]g  :<C-u>Unite
      \ grep<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
      \ -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite
      \ outline<CR>
nnoremap <silent> [unite]d  :<C-u>Unite
      \ -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <silent> [unite]w  :<C-u>UniteWithCursorWord
      \ tag file_rec/async<CR>
nnoremap <silent> [unite]y  :<C-u>Unite
      \ history/yank <CR>
nnoremap <silent> [unite]s  :<C-u>Unite
      \ -buffer-name=files -no-split
      \ jump_point file_point buffer_tab
      \ file_rec:! file file/new file_mru<CR>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> jj         <Plug>(unite_insert_leave)

  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)

  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)

  " Disable cursor keys
  inoremap <buffer> <Up>    <NOP>
  inoremap <buffer> <Down>  <NOP>
  inoremap <buffer> <Left>  <NOP>
  inoremap <buffer> <Right> <NOP>
  noremap  <buffer> <Up>    <NOP>
  noremap  <buffer> <Down>  <NOP>
  noremap  <buffer> <Left>  <NOP>
  noremap  <buffer> <Right> <NOP>
endfunction
" }}}
