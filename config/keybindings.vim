""""""""""""""""""""""""""""""""""""""""
"" Keyboard-command related settings.
"" does not contain plugin-specific
"" settings, just 'global' ones.
""""""""""""""""""""""""""""""""""""""""
let mapleader=";"

" ;w saves a buffer
map <Leader>w :w<CR> 

" ;q closes a vim-window
map <Leader>q :q!<CR>

" navigate among windows using ;[hjkl]
map <Leader>h <C-W>h
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l

" navigate around in buffers...
map <Leader>n :bnext<CR>
map <Leader>p :bprevious<CR>

" close all buffers but this one
map <Leader>bo :BufOnly<CR>

" switch ' and `, because:
" ' jumps to the start of the line where a mark is
" ` jumps to the exact location of a mark
" because jumping to the exact location is more useful,
" I like it to be closer to the home row, so I switch the keys.
noremap ' `
noremap ` '

" toggle line numbers with F2
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
