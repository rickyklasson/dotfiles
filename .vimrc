set autoindent      " New line inherits indentation of previous lines.
set mouse=a         " Enables mouse interaction.
set expandtab       " Converts tabs to spaces.
set shiftwidth=4    " When shifting, indent using 4 spaces.
set softtabstop=4   " Indentation levels are 4 spaces.
set number          " Show line numbers.
set relativenumber  " Show line numbers relative to current line.
set showcmd         " Shows commands in last line of screen.
set encoding=utf-8  " Changes output encoding.
set textwidth=120   " Wraps text after 120 chars.
set incsearch       " Updates search result as chars are typed.
set hlsearch        " Highlight search results.
set cursorline      " Highlight current line.
set ignorecase      " Non case-sensitve searching.
set smartcase       " Only be case-sensitive if search contains upper case.
set scrolloff=10    " Force window to have a row margin to top and bottom.

" Vim-plug for handling plugins
call plug#begin('~/.vim/plugged')

" Colortheme
Plug 'cocopon/iceberg.vim'

" Fzf fuzzy finder for localization of code and files.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" CSV-plugin color plugin.
Plug 'mechatroner/rainbow_csv'

call plug#end()

" Map space to leader and create convenient mappings.
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <silent><leader>9 :Lines<CR>
nnoremap <silent><leader>0 :Files<CR>
nnoremap <silent><leader><Up> :res +8<CR>
nnoremap <silent><leader><Down> :res -8<CR>
nnoremap <silent><leader><Left> :vertical res-8<CR>
nnoremap <silent><leader><Right> :vertical res+8<CR>
nnoremap <silent><leader>g :set hls!<CR>
nnoremap <leader><S-Up> :next<CR>
nnoremap <leader><S-Down> :previous<CR>

" Command for adding empty lines above or below text in normal mode.
nnoremap <leader>o <Nop>
nnoremap <leader>O <Nop>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Disables use of arrow keys.
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Add save functionality to ctrl+s in Insert and Normal mode.
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR><Insert><Right>

" COLORING
set background=dark
colorscheme iceberg

" Toggle colorscheme from light to dark.
nnoremap <F4> :call ColorToggle()<CR>

function! ColorToggle()
  if !exists("g:ColorState")
    let g:ColorState=1
  endif

  if g:ColorState ==# 0
    set background=light
    let g:ColorState = 1
  elseif g:ColorState ==# 1
    set background=dark
    let g:ColorState = 0
  endif
  " Custom colors for whitespace.
  highlight NonText ctermfg=124
  highlight Whitespace ctermfg=124
endfunction

" Logic for entering/leaving a pane, highlights active pane.
function! OnWinEnter()
	if exists('w:initial_cc')
		let &colorcolumn = w:initial_cc
	endif
endfunction
function! OnWinLeave()
	if !exists('w:initial_cc')
		let w:initial_cc=&colorcolumn
	endif
	let &colorcolumn = 0
endfunction
augroup BgHighlight
	autocmd!
	autocmd WinEnter * call OnWinEnter()
	autocmd WinLeave * call OnWinLeave()
augroup END

" Format whitespace.
set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:␣,eol:↲

" Custom colors for whitespace.
highlight NonText ctermfg=226
highlight Whitespace ctermfg=226

" Toggle the way tabs are interpreted.
nnoremap <F9> :call TabToggle()<CR>
inoremap <F9> <C-o>:call TabToggle()<CR>

function! TabToggle()
  if !exists("g:TabState")
    let g:TabState=3
  endif

  if g:TabState ==# 0
    echom "Tabs, spaces:2"
    set noexpandtab
    set shiftwidth=2
    set softtabstop=2
  elseif g:TabState ==# 1
    echom "Tabs, spaces:4"
    set noexpandtab
    set shiftwidth=4
    set softtabstop=4
  elseif g:TabState ==# 2
    echom "Spaces, spaces:2"
    set expandtab
    set shiftwidth=2
    set softtabstop=2
  elseif g:TabState ==# 3
    echom "Spaces, spaces:4"
    set expandtab
    set shiftwidth=4
    set softtabstop=4
  endif

  let g:TabState += 1
  if g:TabState > 3
    let g:TabState = 0
  endif
endfunction

" Toggle whitespace-highlighting.
noremap <F8> :set list!<CR>
inoremap <F8> <C-o>:set list!<CR>
cnoremap <F8> <C-c>:set list!<CR>

" Toggle line numbers.
noremap <F2> :set number!<CR>
inoremap <F2> <C-o>:set number!<CR>
cnoremap <F2> <C-c>:set number!<CR>

" Toggle relativenumber
noremap <F3> :set relativenumber!<CR>
inoremap <F3> <C-o>:set relativenumber!<CR>
cnoremap <F3> <C-c>:set relativenumber!<CR>

set statusline=
set statusline+=%#StatuslineN#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#StatuslineI#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#StatuslineV#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%M                        " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     " colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                          " right align
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\                " percentage
