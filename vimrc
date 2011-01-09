filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype plugin indent on

set nocompatible
syntax on
let mapleader = ";"    
let g:tex_flavor='latex'    " allow recognition of latex files

set autochdir               " change directory to the file you opened
set mouse=a
set hidden                  " liberal hidden buffers
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
set nojoinspaces

" tab settings
set softtabstop=2           " 4 space tabs
set tabstop=2
set shiftwidth=2            " indent width using '<' and '>'
set expandtab               " replace tabs with spaces

" display settings
colorscheme ir_black
set cul                     " highlight current line
hi CursorLine term=none cterm=none ctermbg=0    " adjust highlight
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
vnoremap <silent> * :call VisualSearch('f')<CR>   
vnoremap <silent> # :call VisualSearch('b')<CR>

" viewing formatted files
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.pdf,*.rtf,*.odt,*.odp,*.doc set readonly

""""""""""""""""""""""""""""""""
" key bindings
""""""""""""""""""""""""""""""""
map <Leader>M :mksession 
map <Leader>S :source ~/.vimrc<CR>
map <Leader>w :sav 

" window navigation
map <Leader>h <C-W>h        " ;[hjkl] to navigate split windows
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l

" buffer management
map <Leader>n :bnext<CR>              " navigate through buffers
map <Leader>p :bprevious<CR>
map <Leader>bo :BufOnly<CR>           " close all buffers and windows except this 
map <Leader>q :bd<CR>                 " close current buffer and close window
map <Leader>bd :Bclose<CR>            " close current buffer and keep window

" tab management
map <Leader>tb :tab ball<CR>          " open tabs for all buffers
map <Leader>tn :tabnext<cr>
map <Leader>tp :tabprevious<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" global substitute word under cursor
nmap <Leader>z :%s/\<<c-r>=expand("<cword>")<cr>\>/  
vmap <Leader>z :<C-U>%s/\<<c-r>*\>/

" find word under cursor in all files of a directory
map <Leader>f [I
 
" paste in a sane manner
set pastetoggle=<F9>

" easier navigation with tags, Right to view source, Left back to program
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>

" plugin specific bindings
map <Leader>d :NERDTreeToggle<CR>     " access nerd tree directory
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$', '\.aux$', '\.blg$', '\.bbl$', '\.log$', '\.dvi$']
map <Leader>gs :Gstatus<CR>           " fugitive git wrappings
map <Leader>ga :Git add %<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gc :Gcommit -a<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gl :Glog
map <Leader>gp :Git push origin master<CR>
let g:snips_author='Joshua Finnis'    " snippets variable
map <Leader>todo :set ft=todo<cr>     " vimtodo plugin

""""""""""""""""""""""""""""""""
" commands
""""""""""""""""""""""""""""""""
" command to save a file with sudo priveleges
command! -bar -nargs=0 Sudow 	:silent exe "write !sudo tee % >/dev/null"|silent edit

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
