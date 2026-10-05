" Better indenting
vnoremap < <gv
vnoremap > >gv

" Better nav for omnicomplete
" Mapping up and down keys
" since, <c-j> and <c-k> are
" mapped to up and down via
" karabiner
inoremap <expr> <Down> ("\<C-n>")
inoremap <expr> <Up> ("\<C-p>")

"resize splits -> increase/decrease width of left pane
nnoremap <silent> <Leader>> :vertical resize +5<CR>
nnoremap <silent> <Leader>< :vertical resize -5<CR>

nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>xx :bdelete<CR>
nnoremap <silent> <leader>w :silent w<CR>

noremap <leader>fn :echo @%<CR>
noremap <silent> <leader>cf :silent !echo -n % \| pbcopy<CR>

nnoremap <leader>y yyp

" Movement to content of next braces
" from https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
onoremap in( :<c-u>normal! f(vi(<cr>

"terminal mappings
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>z <C-\><C-n><C-w>_

nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

inoremap <c-l> <C-o>a

nnoremap <silent><leader>ct :silent !cat % \| pbcopy<cr>

nnoremap <silent> <leader>dv :call helpers#GetCommitsForDiffOpen()<cr>
nnoremap <leader>dc :call helpers#DiffWithCommit()<cr>

nnoremap <silent> <leader><leader> :noh<CR>

nnoremap <leader>cb :verbose nmap <lt>leader>

" highlight pasted text
" https://vimtricks.com/p/reselect-pasted-text/
nnoremap gp `[v`]

nnoremap v<c-v> <c-w><c-v>
