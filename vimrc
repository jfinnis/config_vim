filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible
syntax on
let mapleader = ";"    
let g:tex_flavor='latex'    " allow recognition of latex files

set hidden
set history=100
set autochdir
set shortmess=filmnrxtTI
set scrolloff=4             " lines below cursor while scrolling
set wildmenu                " tab menu completion
set wildmode=longest,list   " tab completion settings

" editing settings
set wrap 
set linebreak
set whichwrap+=h,l          " cursor keys wrap lines
set bs=indent,eol,start     " backspace over everything in insert mode

" tab settings
set softtabstop=4           " 4 space tabs
set tabstop=4
set shiftwidth=4
set expandtab

" display settings
set t_Co=256                " number of colors:
set laststatus=2            " always display status line
set number                  " display line numbers
set title                   " show file in titlebar
set ruler                   " show the cursor position always
set statusline=%<\ %2*[%n%H%M%R%W]%*\ %-40f\ %{fugitive#statusline()}%=%l*%y%*%*\ %10((%l/%L)%)\%P

" search settings
set hlsearch                " highlight search terms
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
map <Leader>q :bd<CR>       " close current buffer and close window
 
" paste in a sane manner
set pastetoggle=<F9>

" plugin specific bindings
map <Leader>bo :BufOnly<CR>           " close all buffers and windows except this 
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
