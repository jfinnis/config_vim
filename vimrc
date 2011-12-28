filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set nocompatible 
syntax on
let mapleader = ";"    
let g:tex_flavor='latex'    " allow recognition of latex files

"set autochdir               " change directory to the file you opened
set mouse=a
set hidden                  " liberal hidden buffers
set history=100
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
set matchtime=3             " tenths of a second to show matching paren
set gdefault                " always do g option for substitute
nnoremap zO zCzO
set pastetoggle=<F9>        " paste in a sane manner
set virtualedit+=block      " allows cursor anywhere in visual block mode 
" convert current word to uppercase and lowercase
nnoremap <leader>U gUiw
nnoremap <leader>u guiw

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

" browse most recently used files
"autocmd VimEnter * if empty(expand('%:p')) | browse oldfiles | endif

" key bindings
""""""""""""""""""""""""""""""""
map <Leader>M :mksession 
map <Leader>S :source ~/.vimrc<CR>
nnoremap S i<cr><esc><right>

" window navigation
map <Leader>h <C-W>h        " ;[hjkl] to navigate split windows
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l
map g+ <C-W>_               " max window
map g= <C-W>=               " same size

" buffer management
map <Leader>n :bnext<CR>              " navigate through buffers
map <Leader>p :bprevious<CR>
map <Leader>q :bd<CR>                 " close current buffer and close window
map <Leader>bo :BufOnly<CR>           " close all buffers and windows except this 
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
 
" easier navigation with tags, Right to view source, Left back to program
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>

" plugin specific bindings
let g:snips_author='Joshua Finnis'    " snippets variable

" nerdtree bindings and settings
map <Leader>d :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$', '\.aux$', '\.blg$', '\.bbl$', '\.log$', '\.dvi$']

" easymotion options and bindings
let EasyMotion_do_mapping=0
let EasyMotion_do_shade=1
nnoremap <silent> <Leader>gf      :call EasyMotionF(0, 0)<CR>
vnoremap <silent> <Leader>gf :<C-U>call EasyMotionF(1, 0)<CR>
nnoremap <silent> <Leader>gF      :call EasyMotionF(0, 1)<CR>
vnoremap <silent> <Leader>gF :<C-U>call EasyMotionF(1, 1)<CR>

" fugitive git wrapping
map <Leader>gs :Gstatus<CR>           
map <Leader>ga :Git add %<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gc :Gcommit -a<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gl :Glog
map <Leader>gp :Git push origin master<CR>

" taglist plugin options
map <Leader>tl :TlistToggle<cr>
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Close_On_Select=1
let Tlist_Show_One_File=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Use_Right_Window=1
let Tlist_Compact_Format=1
let Tlist_Enable_Fold_Column=0
let Tlist_Display_Prototype=0

" example tabularize mappings
"nmap <Leader>a= :Tabularize /=<CR>
"vmap <Leader>a= :Tabularize /=<CR>
"nmap <Leader>a: :Tabularize /=\zs<CR>
"vmap <Leader>a: :Tabularize /=\zs<CR>

" trigger :Tabular each time '|' is typed, examines previous/next line for pattern
"inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

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

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
