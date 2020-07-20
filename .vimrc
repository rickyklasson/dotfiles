set autoindent
set noexpandtab
set tabstop=2
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
set scrolloff=20

let g:coc_disable_startup_warning = 1

" Vim-plug for handling plugins
call plug#begin('~/.vim/plugged')

" Colortheme
Plug 'cocopon/iceberg.vim'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Godot syntax highlighting.
Plug 'habamax/vim-ft-gdscript'

" Fzf fuzzy finder for localization of code and files.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Statusline coloring
Plug 'itchyny/lightline.vim'


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
nnoremap <silent><leader><Up> :res +4<CR>
nnoremap <silent><leader><Down> :res -4<CR>
nnoremap <silent><leader><Left> :vertical res-4<CR>
nnoremap <silent><leader><Right> :vertical res+4<CR>
nnoremap <silent><leader>g :set hls!<CR>
nnoremap <leader><S-Up> :next<CR>
nnoremap <leader><S-Down> :previous<CR>

" Indents entire doc. Needs fix to return to current location.
nnoremap <leader>i gg=G

" Add save functionality to ctrl+s.
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR><Insert><Right>


nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" COLORING
set background=dark
colorscheme iceberg

highlight NonText ctermfg=46
highlight Whitespace ctermfg=46


" Colors chars outside col=80.
":match Error /\%>80c/
" Global default
set colorcolumn=80

" Creates a column at col=80 in current window.
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

source $HOME/.config/nvim/plug-config/coc.vim

" ---------------------------------------------------------------------------
" -----------------------COMMANDS FROM MALTES VIMRC---------------------

"Cscope tags, do command ':cscope' or ':cs' to see definitions
"Regen tags: run 'csbuild' in terminal
"Run ':cs add cscope.out' in vim
"Return to previous cached file in vim 'ctrl+t'
if has("cscope")
		" add any cscope database in current directory
		if filereadable("cscope.out")
				cs add cscope.out
		endif
		" show msg when any other cscope db added
		set cscopeverbose
		" Shortcuts in same window
		nmap css :cs find s <C-R>=expand("<cword>")<CR><CR>
		nmap csg :cs find g <C-R>=expand("<cword>")<CR><CR>
		nmap csc :cs find c <C-R>=expand("<cword>")<CR><CR>
		nmap cst :cs find t <C-R>=expand("<cword>")<CR><CR>
		nmap cse :cs find e <C-R>=expand("<cword>")<CR><CR>
		nmap csf :cs find f <C-R>=expand("<cfile>")<CR><CR>
		nmap csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
		nmap csd :cs find d <C-R>=expand("<cword>")<CR><CR>
		" Shortcuts, open new vert window
		nmap dss :vert scs find s <C-R>=expand("<cword>")<CR><CR>
		nmap dsg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
		nmap dsc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
		nmap dst :vert scs find t <C-R>=expand("<cword>")<CR><CR>
		nmap dse :vert scs find e <C-R>=expand("<cword>")<CR><CR>
		nmap dsf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
		nmap dsi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
		nmap dsd :vert scs find d <C-R>=expand("<cword>")<CR><CR>
		" Shortcuts, open new horsizontal window
		nmap ccss scs find s <C-R>=expand("<cword>")<CR><CR>
		nmap ccsg scs find g <C-R>=expand("<cword>")<CR><CR>
		nmap ccsc scs find c <C-R>=expand("<cword>")<CR><CR>
		nmap ccst scs find t <C-R>=expand("<cword>")<CR><CR>
		nmap ccse scs find e <C-R>=expand("<cword>")<CR><CR>
		nmap ccsf scs find f <C-R>=expand("<cfile>")<CR><CR>
		nmap ccsi scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
		nmap ccsd scs find d <C-R>=expand("<cword>")<CR><CR>
endif

set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:␣,eol:↲

noremap <F8> :set list!<CR>
inoremap <F8> <C-o>:set list!<CR>
cnoremap <F8> <C-c>:set list!<CR>

noremap <F2> :set number!<CR>
inoremap <F2> <C-o>:set number!<CR>
cnoremap <F2> <C-c>:set number!<CR>

noremap <F3> :set relativenumber!<CR>
inoremap <F3> <C-o>:set relativenumber!<CR>
cnoremap <F3> <C-c>:set relativenumber!<CR>
