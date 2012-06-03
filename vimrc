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
set ttyfast
set wildmenu                " tab menu completion
set wildmode=longest,list   " tab completion settings
set fo=cq

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
set noundofile                " store in .un files the previous changes

" tab settings
set softtabstop=4           " 4 space tabs
set tabstop=4
set shiftwidth=4            " indent width using '<' and '>'
set expandtab               " replace tabs with spaces

" display settings
colorscheme ir_black
set nocul                     " highlight current line
hi CursorLine term=none cterm=none ctermbg=0    " adjust highlight
set t_Co=256                " number of colors:
set laststatus=2            " always display status line
set number                  " display line numbers
"set relativenumber          " number lines relative to cursor
set title                   " show file in titlebar
set ruler                   " show the cursor position always

" display tabs (not working)
"set lcs=tab:?\ ,trail:?,extends:>,precedes:<,nbsp:&
set list lcs=tab:\|-,extends:>,precedes:<,nbsp:&

" old statusline (before powerline plugin)
"set statusline=%<\ %2*[%n%H%M%R%W]%*\ %-40f\ %{fugitive#statusline()}%=%l*%y%*%*\ %10((%l/%L)%)\%P
let g:Powerline_symbols='fancy'

" syntastic settings
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons=0
let g:syntastic_loc_list_height=5
let g:syntastic_enable_signs=0
map <F12> :SyntasticToggleMode<CR>

" tagbar settings
let g:tagbar_width=30
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_autoshowtag=1

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

augroup filetypedetect
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
augroup END

" turn on rainbow colored parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" don't quote signatures in mutt files
au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L

" browse most recently used files on startup
"autocmd VimEnter * if empty(expand('%:p')) | browse oldfiles | endif

" key unbindings
""""""""""""""""""""""""""""""""
map ZQ <nop>
map ZZ <nop>

" key bindings
""""""""""""""""""""""""""""""""
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
" easier vreplace
nnoremap gr gR
" easier copy to clipboard
map <leader>y "+y
nnoremap L :ls<CR>:b<space>
map <leader>p :set paste<bar>put + <bar>set nopaste<cr>
map <F8> :call ToggleSingleLine()<CR>

" center screen for searches, foldcloses - to top for foldopen
nnoremap n nzz
nnoremap N Nzz
nnoremap zc zczz
nnoremap zo zozt

" easier access to diff commands
nnoremap df :diffthis<cr>
nnoremap <silent> dF :diffoff!<cr>
nnoremap du :diffupdate<cr>

" window management
map <Leader>h <C-W>h                  " ;[hjkl] to navigate split windows
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l
map + <C-W>_                         " max window
map - <C-W>=                         " same size

" buffer management 
" :q - close window and keep buffer, ]b, [b prev/next buffer
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

" new mapping ala unimpaired
nnoremap [f :lprevious<cr>
nnoremap ]f :lnext<cr>

" nerdtree bindings and settings
map <Leader>n :NERDTreeToggle<CR>
let NERDChDirMode=2
let NERDTreeIgnore=['\~$', '\.aux$', '\.blg$', '\.bbl$', '\.log$', '\.dvi$']
let NERDTreeShowBookmarks=1

" start ctrlp
let g:ctrlp_map='<Leader>N'
let g:ctrlp_by_filename=1
let g:ctrlp_match_window_bottom=0
let g:ctrlp_max_height=15
let g:ctrlp_open_multiple_files='1vr'
let g:ctrlp_custom_ignore = {'dir':'\.git$\|\.hg$\|\.svn$'}


" easymotion options and bindings
let EasyMotion_do_mapping=0
nnoremap <silent> K      :call EasyMotion#F(0, 0)<cr>
vnoremap <silent> K :<C-U>call EasyMotion#F(1, 0)<cr>
nnoremap <silent> H      :call EasyMotion#F(0, 1)<cr>
vnoremap <silent> H :<C-U>call EasyMotion#F(1, 1)<cr>

" replace set to R, allows for R to delete and replace motions
map R <Plug>(operator-replace)

" supertab settings
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabLongestEnhanced=1

" fugitive git wrapping
map <Leader>gs :Gstatus<CR>           
map <Leader>ga :Git add %<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gw :Gbrowse<CR>
map <Leader>gc :Gcommit -a<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gl :Glog<CR>
map <Leader>gp :Git push origin master<CR>
autocmd BufReadPost fugitive://* set bufhidden=delete

" tabular settings to align at = and after : for blocks of code
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs/l0l1<CR>
vmap <Leader>a: :Tabularize /:\zs/l0l1<CR>

" abolish abbreviations
let g:abolish_save_file='abbreviations'

" taglist plugin options
map <Leader>tl :TagbarToggle<CR>

" vimux commands
map ! :PromptVimTmuxCommand()<CR>
map <leader>! :RunLastVimTmuxCommand<CR>:w
"let g:VimuxUseNearestPane=1

""""""""""""""""""""""""""""""""
" commands
""""""""""""""""""""""""""""""""
" command to save a file with sudo priveleges
command! -bar -nargs=0 Sudow 	:silent exe "write !sudo tee % >/dev/null"|silent edit

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

function! ToggleSingleLine()
  if !exists("s:imove")
    let s:imove=1 "zero: not enabled
  endif"
  if s:imove
    map gj <Down>
    map gk <Up>
    map g0 <Home>
    map g$ <End>
    map j g<Down>
    map k g<Up>
    map 0 g<Home>
    map $ g<End>
    let s:imove=0
    echo "Toggle: single line movements"
  else 
    map j <Down>
    map k <Up>
    map 0 <Home>
    map $ <End>
    map gj g<Down>
    map gk g<Up>
    map g0 g<Home>
    map g$ g<End>
    let s:imove=1
    echo "Toggle: normal vim movements"
  endif
endfunction

" keys to free: s, M, Z, Q
