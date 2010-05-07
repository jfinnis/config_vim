set nocompatible
syntax on
let mapleader = ";"    
filetype plugin on
filetype indent on
let g:tex_flavor='latex'    " allow recognition of latex files

set history=100
set autochdir
set shortmess=filmnrxtTI
set wrap 
set linebreak
set scrolloff=4             " lines below cursor while scrolling
set whichwrap+=h,l          " cursor keys wrap lines
set wildmenu                " tab menu completion
set wildmode=longest,list   " tab completion settings

" tab settings
set softtabstop=4           " 4 space tabs
set tabstop=4
set shiftwidth=4
set expandtab

" display settings
set laststatus=2            " always display status line
set number                  " display line numbers
set title                   " show file in titlebar
set ruler
set statusline=%<\ %2*[%n%H%M%R%W]%*\ %-40f\ %{fugitive#statusline()}%=%l*%y%*%*\ %10((%l/%L)%)\%P

" search settings
set nohlsearch              " do not highlight search terms
set incsearch               " search incrementally
set ignorecase              " ignore case in searches
set smartcase               " ... unless capitals are included

" backup settings
set backupdir=/tmp/         " backup files (~)
set directory=/tmp/         " swap files
set backup                  " enable backups

""""""""""""""""""""""""""""""""
" key bindings
""""""""""""""""""""""""""""""""
map <Leader>h <C-W>h        " ;[hjkl] to navigate split windows
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l

map <Leader>n :bnext<CR>    " navigate through buffers
map <Leader>p :bprevious<CR>
map <Leader>q :bd<CR>       " close current buffer without closing window

" plugin specific bindings
map <Leader>bo :BufOnly<CR>           " close all buffers except this 
map <Leader>d :NERDTreeToggle<CR>     " access nerd tree directory
map <Leader>gs :Gstatus<CR>           " fugitive git wrappings
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Git push origin master<CR>


""""""""""""""""""""""""""""""""
" commands
""""""""""""""""""""""""""""""""
" command to save a file with sudo priveleges
command! -bar -nargs=0 Sudow 	:silent exe "write !sudo tee % >/dev/null"|silent edit


""""""""""""""""""""""""""""""""
runtime! config/**/*
""""""""""""""""""""""""""""""""
