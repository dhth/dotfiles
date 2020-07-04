" vim-plug auto setup
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.local/share/nvim/plugged')

" Plugins go here like this:
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'

call plug#end()

let g:coc_global_extensions = ["coc-python",
            \ "coc-json"]


" General Settings
syntax on

"For vimwiki
set nocompatible
filetype plugin on
"

"splits open to right and down
set splitbelow splitright

set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set tw=80
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set colorcolumn=80

set showcmd
set ruler

"from How to do 90% of what plugins do
"https://www.youtube.com/watch?v=XA2WjJbmmoM

"file finding
set path+=**
set wildmenu
set wildignore+=**/node_modules/**

"file tree
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in current window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

"let g:netrw_browse_split = 2
let g:netrw_winsize = 25

"show line numbers in netrw
le g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

"end

highlight ColorColumn ctermbg=0 guibg=lightgrey
autocmd! GUIEnter * set vb t_vb=

colorscheme gruvbox
set background=dark

"From CtrlP's installation instructions
"set runtimepath^=~/.vim/bundle/ctrlp.vim

if executable('rg')
    let g:rg_derive_root='true'
endif

"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let mapleader = " "


"let g:ctrlp_use_caching = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>

"resize splits -> increase/decrease height
nnoremap <silent> <Leader>+ :resize +5<CR>
nnoremap <silent> <Leader>- :resize -5<CR>

"resize splits -> increase/decrease width of left pane
nnoremap <silent> <Leader>> :vertical resize +5<CR>
nnoremap <silent> <Leader>< :vertical resize -5<CR>
"

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap jj <Esc>


"for fzf, from https://www.youtube.com/watch?v=-I1b8BINyEw
nnoremap <C-p> :GFiles<CR>

"for coc, from https://www.youtube.com/watch?v=-I1b8BINyEw
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

