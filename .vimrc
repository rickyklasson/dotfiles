set autoindent
set noexpandtab
set tabstop=4
set softtabstop=2
set shiftwidth=2
set number
syntax on
set relativenumber
set showcmd
set encoding=utf-8
set textwidth=120
set wrap
set wrapmargin=2
set incsearch
set hlsearch
set cursorline
set smartcase
set scrolloff=10
set mouse=a
set updatetime=500
filetype plugin on

" Vim-plug for handling plugins
call plug#begin('~/.vim/plugged')

" Colortheme
Plug 'cocopon/iceberg.vim'

" Fzf fuzzy finder for localization of code and files.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Statusline coloring
Plug 'itchyny/lightline.vim'

" Allows changes of surrounding (,{,[,",'...
Plug 'tpope/vim-surround'

" Git shortcuts.
Plug 'airblade/vim-gitgutter'

" Hard mode, disables arrow keys and consequtive presses.
Plug 'wikitopian/hardmode'

" Smooth scrolling.
Plug 'psliwka/vim-smoothie'

call plug#end()

" Map space to leader and create convenient mappings.
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <silent><leader>9 :Lines<CR> 
nnoremap <silent><leader>0 :Files<CR>
nnoremap <silent><leader>1 1gt
nnoremap <silent><leader>2 2gt
nnoremap <silent><leader>3 3gt
nnoremap <silent><leader>4 4gt
nnoremap <silent><leader>5 5gt
nnoremap <silent><leader>6 6gt
nnoremap <silent><leader><Up> :GitGutterPrevHunk<CR>
nnoremap <silent><leader><Down> :GitGutterNextHunk<CR>
nnoremap <silent><leader><Left> :vertical res-8<CR>
nnoremap <silent><leader><Right> :vertical res+8<CR>
nnoremap <silent><leader>g :set hls!<CR>
nnoremap <leader><S-Up> :next<CR>
nnoremap <leader><S-Down> :previous<CR>
nnoremap <leader><S-Down> :previous<CR>
" Copy vim buffer to system buffer.
nnoremap <leader>y "+y<CR>

" Add save functionality to ctrl+s in Insert and Normal mode.
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR><Insert><Right>

" Auto-indents code.
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Double brackets
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap ' ''<Left>

" COLORING
set background=dark
colorscheme iceberg


" Colors chars outside col=80.
":match Error /\%>80c/
" Global default
" set colorcolumn=80

" Creates a column at col=80 in active window.
highlight ColorColumn ctermbg=238
" Logic for entering/leaving a pane
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
highlight NonText ctermfg=199
highlight Whitespace ctermfg=199

" No background in vim, uses terminal background
hi Normal guibg=NONE ctermbg=NONE

" Toggle line numbers.
noremap <F2> :set number!<CR>
inoremap <F2> <C-o>:set number!<CR>
cnoremap <F2> <C-c>:set number!<CR>

" Toggle relativenumber
noremap <F3> :set relativenumber!<CR>
inoremap <F3> <C-o>:set relativenumber!<CR>
cnoremap <F3> <C-c>:set relativenumber!<CR>

" Toggle whitespace-highlighting.
noremap <F8> :set list!<CR>
inoremap <F8> <C-o>:set list!<CR>
cnoremap <F8> <C-c>:set list!<CR>

" Toggle tabs between spaces and tabs.
let my_tab=4
execute "set shiftwidth=".my_tab
execute "set softtabstop=".my_tab
set expandtab
" allow toggling between local and default mode
function! TabToggle()
  if &expandtab
    set noexpandtab
    echo "Tabs"
  else
    set expandtab
    echo "Spaces"
  endif
endfunction
nnoremap <F9> :call TabToggle()<CR>

" Add complementary bracket "
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>

" Silence cscope output on vim startup.
set nocscopeverbose
" Cscope maps, assumes symlink '.cscope_maps.vim' points to cscope maps "
if !empty(globpath('~/', ".cscope_maps.vim"))
	source ~/.cscope_maps.vim
endif
