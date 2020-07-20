"""""""""""""""""""
""""""plugins""""""
"""""""""""""""""""

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
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Plug 'junegunn/rainbow_parentheses.vim'

call plug#end()

let g:coc_global_extensions = ["coc-python",
            \ "coc-json"]


"""""""""""""""""""
""""""general""""""
"""""""""""""""""""

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
set number relativenumber
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set tw=120
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set colorcolumn=120

set showcmd
set ruler

"from How to do 90% of what plugins do
"https://www.youtube.com/watch?v=XA2WjJbmmoM

"file finding
" set path+=**
" disabled after reading https://github.com/neovim/neovim/issues/3209
set wildmenu
set wildignore+=**/node_modules/**

let mapleader = " "

nnoremap <leader>q :q<CR>

"""""""""""""""""""
"""""""netrw"""""""
"""""""""""""""""""

"file tree
"let g:netrw_banner=0       " disable annoying banner
"let g:netrw_browse_split=4 " open in current window
"let g:netrw_altv=1         " open splits to the right
"let g:netrw_liststyle=3    " tree view

"let g:netrw_browse_split = 2
"let g:netrw_winsize = 25

"show line numbers in netrw
"let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

"end

highlight ColorColumn ctermbg=0 guibg=lightgrey
autocmd! GUIEnter * set vb t_vb=

"""""""""""""""""""
""""""nerdtree"""""
"""""""""""""""""""

" enable line numbers in nerdtree
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
" make sure relative line numbers are used

let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$']
autocmd FileType nerdtree setlocal relativenumber

"""""""""""""""""""
"""color scheme""""
"""""""""""""""""""

"color scheme
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'medium'

colorscheme gruvbox
set background=dark

"from https://www.youtube.com/watch?v=q7gr6s8skt0
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

"custom commands
:command Light set background=light
:command Dark set background=dark

"""""""""""""""""""
""""""windows""""""
"""""""""""""""""""

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
"nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>pv :NERDTreeToggle %<CR>

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


"""""""""""""""""""
""""""""fzf""""""""
"""""""""""""""""""

"for fzf, from https://www.youtube.com/watch?v=-I1b8BINyEw
nnoremap <C-p> :GFiles<CR>

"for FZF files
nnoremap <C-f> :Files<CR>

nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>bs :Lines<CR>
nnoremap <Leader>fh :History<CR>

"repeat same mappings for new tab
nnoremap <Leader><C-p> :tabnew<CR>:GFiles<CR>
nnoremap <Leader><C-f> :tabnew<CR>:Files<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

"""""""""""""""""""
""""""""coc""""""""
"""""""""""""""""""

"for coc, from https://www.youtube.com/watch?v=-I1b8BINyEw
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>dt :call CocAction('jumpDefinition', 'tabe')<CR>

""Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> gy <Plug>(coc-type-definition)

"""""""""""""""""""
"""""fugitive""""""
"""""""""""""""""""

"maps for git fugitive, from https://www.youtube.com/watch?v=PO6DxfGPQvw
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>

"""""""""""""""""""
"""""""tabs"""""""
"""""""""""""""""""

noremap <leader>tt :tabnew<CR>
noremap <leader>te :tabedit<space>
noremap <leader>tc :tabclose<CR>

"don't show tab line
"set showtabline=1

"move to next tab
noremap <leader>m gt
noremap <leader>n gT
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

"""""""""""""""""""
""""""airline""""""
"""""""""""""""""""

"show airline tab line
let g:airline#extensions#tabline#enabled = 1

"don't show buffers in airline tab bar
let g:airline#extensions#tabline#show_splits = 0

"shorter tab names
let g:airline#extensions#tabline#formatter = 'unique_tail'

"don't display tab count on the right side
let g:airline#extensions#tabline#show_tab_count = 0

"show tab number
let g:airline#extensions#tabline#tab_nr_type = 1

"""""""""""""""""""
"""""""folds"""""""
"""""""""""""""""""

"folds on by default
set foldmethod=indent
"prevents { or } from opening up a fold
set foldopen-=block

"leader fi to toggle opening/closing all folds
let $unrol=0
function UnrolMe()
if $unrol==0
    :exe "normal zR"
    " :exe "normal zA"
    let $unrol=1
else
    :exe "normal zM"
" :exe "normal zC"
    let $unrol=0
endif
endfunction

noremap <leader>fi :call UnrolMe()<CR>

"leader op opens fold
noremap <leader>op zA
"leader cl closes folds
noremap <leader>cl zC

"""""""""""""""""""
"""miscellaneous"""
"""""""""""""""""""

set clipboard+=unnamedplus
noremap <leader>fn :echo @%<CR>

"shortcut to edit nvim config
noremap <leader>evm : e ~/.config/nvim/init.vim<CR>

"add a new line below with a breakpoint (python)
nmap <leader>bp obreakpoint()<Esc>k

noremap <leader>sf :source %<CR>

"""""""""""""""""""
"""text movement"""
"""""""""""""""""""

"create empty line(s) below/above
nnoremap <silent> [l  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]l  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

"move line/block down/up, ∆ is opt+j, ˚ is opt+k
nnoremap ∆ :m .+1<CR>
nnoremap ˚ :m .-2<CR>
inoremap ∆ <Esc>:m .+1<CR>gi
inoremap ˚ <Esc>:m .-2<CR>gi
vnoremap ∆ :m '>+1<CR>gv
vnoremap ˚ :m '<-2<CR>gv


"""""""""""""""""""
""goyo & limelight"
"""""""""""""""""""

nnoremap <C-g> :Goyo<CR>
nnoremap <C-l> :Limelight!!<CR>

"goyo and limelight integrated
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!

" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
