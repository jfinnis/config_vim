filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

set nocompatible 
syntax on
let mapleader=";"    
let g:tex_flavor='latex'    " allow recognition of latex files

set autochdir               " change directory to the file you opened
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
set pastetoggle=<F10>       " paste in a sane manner
set virtualedit+=block      " allows cursor anywhere in visual block mode 
set undofile                " store in .un files the previous changes

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
set relativenumber          " number lines relative to cursor
set title                   " show file in titlebar
set ruler                   " show the cursor position always

" old statusline (before powerline plugin)
"set statusline=%<\ %2*[%n%H%M%R%W]%*\ %-40f\ %{fugitive#statusline()}%=%l*%y%*%*\ %10((%l/%L)%)\%P
let g:Powerline_symbols='fancy'

" search settings
set hlsearch                " highlight search terms
set incsearch               " search incrementally
set ignorecase              " ignore case in searches
set smartcase               " ... unless capitals are included
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" shortcut for searching with Ack
nnoremap <leader>a :Ack

" viewing formatted files
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.pdf,*.rtf,*.odt,*.odp,*.doc set readonly

" turn on rainbow colored parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" don't quote signatures in mutt files
au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L

" start ctrlp
let g:ctrlp_map='<Leader>df'
let g:ctrlp_by_filename=1
let g:ctrlp_match_window_bottom=0
let g:ctrlp_max_height=15
let g:ctrlp_open_multiple_files='1vr'
let g:ctrlp_custom_ignore = {'dir':'\.git$\|\.hg$\|\.svn$'}

" browse most recently used files on startup
"autocmd VimEnter * if empty(expand('%:p')) | browse oldfiles | endif

" key unbindings
""""""""""""""""""""""""""""""""
map ZQ <nop>
map ZZ <nop>

" key bindings
""""""""""""""""""""""""""""""""
nnoremap j gj
nnoremap k gk
map <Leader>M :mksession 
map <Leader>S :source ~/.vimrc<CR>
" split line at the current cursor position
nnoremap S i<cr><esc><right>
" remove all trailing whitespace
nnoremap <Leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" make ! read in output of command
map ! :r !
" word count
map <Leader>wc g<C-G>
" easier formatting
map Q gq
" convert current word to uppercase and lowercase
nnoremap <leader>U gUiw
nnoremap <leader>u guiw
" make Y behave like other capitals
map Y y$
" close diff windows
nnoremap <Leader>D :diffoff!<cr>
" easier vreplace
nnoremap gr gR

" window navigation
map <Leader>h <C-W>h                  " ;[hjkl] to navigate split windows
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l
map + <C-W>_                         " max window
map - <C-W>=                         " same size

" buffer management
map <Leader>n :bnext<CR>              " navigate through buffers
map <Leader>p :bprevious<CR>
map <Leader>q :bd<CR>                 " close current buffer and close window
map <Leader>Q :Bclose<CR>             " close current buffer and keep window
map <Leader>bo :BufOnly<CR>           " close all buffers and windows except this 

" tab management
map <Leader>tb :tab ball<CR>          " open tabs for all buffers
map <Leader>tn :tabnext<cr>
map <Leader>tp :tabprevious<cr>
map <Leader>to :tabonly<cr>           " close all other tabs
map <leader>te :tabedit               " edit new tab [file name]
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove               " move tab to last [or specify number]

" tabman plugin settings
let g:tabman_toggle='<Leader>tt'
let g:tabman_focus='<Leader>tf'
let g:tabman_side='right'

" visually select the text that was last edited/pasted
nmap gV `[v`]

" add number object for modification (cin, etc)
onoremap n :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap n :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap an :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap an :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap in :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap in :<c-u>call <SID>NumberTextObject(1)<cr>

" global substitute word under cursor
nmap <Leader>s :%s/\<<c-r>=expand("<cword>")<cr>\>/
vmap <Leader>s :<C-U>%s/\<<c-r>*\>/

" find word under cursor in all files of a directory
map <Leader>f [I
 
" plugin specific bindings
let g:snips_author='Joshua Finnis'    " snippets variable

" nerdtree bindings and settings
map <Leader>dd :NERDTreeToggle<CR>
let NERDChDirMode=2
let NERDTreeIgnore=['\~$', '\.aux$', '\.blg$', '\.bbl$', '\.log$', '\.dvi$']
let NERDTreeShowBookmarks=1

" easymotion options and bindings
let EasyMotion_do_mapping=0
nnoremap <silent> \      :call EasyMotion#F(0, 0)<cr>
vnoremap <silent> \ :<C-U>call EasyMotion#F(1, 0)<cr>
nnoremap <silent> \|      :call EasyMotion#F(0, 1)<cr>
vnoremap <silent> \| :<C-U>call EasyMotion#F(1, 1)<cr>

" space plugin might cause problems with snippets plugin
let g:space_disable_select_mode = 1

" replace set to R, allows for R to delete and replace motions
map R <Plug>(operator-replace)

" fugitive git wrapping
map <Leader>gs :Gstatus<CR>           
map <Leader>ga :Git add %<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gw :Gbrowse<CR>
map <Leader>gc :Gcommit -a<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gl :Glog
map <Leader>gp :Git push origin master<CR>
autocmd BufReadPost fugitive://* set bufhidden=delete

" tabular settings to align at = and after : for blocks of code
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs/l0l1<CR>
vmap <Leader>a: :Tabularize /:\zs/l0l1<CR>

" taglist plugin options
map <Leader>tl :TlistToggle<cr>
let Tlist_Compact_Format=0                   " remove blank lines
let Tlist_Display_Prototype=0
let Tlist_Enable_Fold_Column=0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Inc_Winwidth=0
let Tlist_Sort_Type="name"
let Tlist_Use_Right_Window=1

" show yankring window
nnoremap <silent> <Leader>y :YRShow<CR>
let g:yankring_history_dir='~/.vim'

" turn off pressing " in visual puts quotes around
let g:AutoCloseSelectionWrapPrefix="<Leader><s-F12>"

""""""""""""""""""""""""""""""""
" commands
""""""""""""""""""""""""""""""""
" command to save a file with sudo priveleges
command! -bar -nargs=0 Sudow 	:silent exe "write !sudo tee % >/dev/null"|silent edit

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

function! s:NumberTextObject(whole)
    normal! v
    while getline('.')[col('.')] =~# '\v[0-9]'
        normal! l
    endwhile
    if a:whole
        normal! o
        while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
            normal! h
        endwhile
    endif
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

" assuming the first line has appropriate table format, format following lines '|'
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

function! s:NumberTextObject(whole)
    normal! v
    while getline('.')[col('.')] =~# '\v[0-9]'
        normal! l
    endwhile
    if a:whole
        normal! o
        while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
            normal! h
        endwhile
    endif
endfunction

" show last motion for space movement plugin
function! SlSpace()
    if exists("*GetSpaceMovement")
        return "[" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunc
" disabled for now
" set statusline+=%{SlSpace()}
"
"
" keys to free: s, H, M, L, Z, Q, K
