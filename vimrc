filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" general settings
set nocompatible
syntax on
let mapleader=";"
let g:tex_flavor='latex'    " allow recognition of latex files
set noautochdir               " change directory to the file you opened
set fo=cq
set hidden                  " liberal hidden buffers
set history=100
set mouse=a
set shortmess=filmnrxtTI
set scrolloff=4             " lines below cursor while scrolling
set ttyfast
set wildmenu                " tab menu completion
set wildmode=longest,list   " tab completion settings

" editing settings
set bs=indent,eol,start     " backspace over everything in insert mode
set gdefault                " always do g option for substitute
set linebreak
set matchtime=3             " tenths of a second to show matching paren
set nojoinspaces
set pastetoggle=<F10>       " paste in a sane manner
set noundofile                " store in .un files the previous changes
set virtualedit+=block      " allows cursor anywhere in visual block mode
set whichwrap+=h,l          " cursor keys wrap lines
set wrap

" tab settings
set expandtab               " replace tabs with spaces
set shiftwidth=4            " indent width using '<' and '>'
set softtabstop=4           " 4 space tabs
set tabstop=4

" display settings
colorscheme ir_black
hi CursorLine term=none cterm=none ctermbg=0    " adjust highlight
set laststatus=2            " always display status line
set nocul                   " highlight current line
set number                  " display line numbers
set ruler                   " show the cursor position always
set title                   " show file in titlebar
set t_Co=256                " number of colors:
"set relativenumber          " number lines relative to cursor

" search settings
set hlsearch                " highlight search terms
set ignorecase              " ignore case in searches
set incsearch               " search incrementally
set smartcase               " ... unless capitals are included

" old statusline (before powerline plugin)
"set statusline=%<\ %2*[%n%H%M%R%W]%*\ %-40f\ %{fugitive#statusline()}%=%l*%y%*%*\ %10((%l/%L)%)\%P
let g:Powerline_symbols='fancy'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" AUTOCOMMANDS """""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" viewing formatted files
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.pdf,*.rtf,*.odt,*.odp,*.doc set readonly

" format tmux files
augroup filetypedetect
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
augroup END

" don't quote signatures in mutt files
au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L

" turn on rainbow colored parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""" KEY UNBINDINGS """"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ZQ <nop>
map ZZ <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" KEY BINDINGS """""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>S :source ~/.vimrc<CR>

"""""""""""""""""""""" quick file access """""""""""""""""""""""""
map <space>V :e ~/.vim/vimrc <bar> :cd ~/.vim<cr>
map <space>M :e ~/.mutt/cfg/muttrc <bar> :cd ~/.mutt/cfg<cr>
map <space>T :e ~/.tmux/tmux.conf <bar> :cd ~/.tmux<cr>
map <space>Z :e ~/.zsh/zshrc <bar> :cd ~/.zsh<cr>

"""""""""""""""" EDITING - save some keystrokes """"""""""""""""""
" since ^ is hard to reach and i don't use ,
nnoremap , ^

" format paragraph
map Q gqip

" make Y behave like other capitals
map Y y$

" vreplace mode
nnoremap gr gR

" easier clipboard access
map <leader>y "+y
map <leader>p :set paste<bar>put + <bar>set nopaste<cr>

" indent the just pasted text
nnoremap <Leader>> g'[>']
nnoremap <Leader>< g'[<']

" split line at the current cursor position
nnoremap S i<cr><esc>

" remove all trailing whitespace
nnoremap <Leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" convert current word to uppercase and lowercase
nnoremap <leader>U gUiw
nnoremap <leader>u guiw

" center screen for searches, foldcloses - to top for foldopen
nnoremap n nzz
nnoremap N Nzz
nnoremap zc zczz
nnoremap zo zozt

" ... and folds (thanks to bairui)
:for m in map(map(range(10), 'nr2char(48+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor
:for m in map(map(range(26), 'nr2char(65+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor
:for m in map(map(range(26), 'nr2char(97+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor

" can use zz/t/b in visual mode to center/top/bottom selection
vnoremap <silent> zz :<C-u>call setpos('.',[0,(line("'>")-line("'<"))/2+line("'<"),0,0])<Bar>normal! zzgv<CR>
vnoremap <silent> zt :<C-u>call setpos('.',[0,line("'<"),0,0])<Bar>normal! ztgv<CR>
vnoremap <silent> zb :<C-u>call setpos('.',[0,line("'>"),0,0])<Bar>normal! zbgv<CR>

" scroll up
imap <tab>e	<C-X><C-E>
" scroll down
imap <tab>y	<C-X><C-Y>

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

"""""""""""""""""""""" WORD COMPLETION """""""""""""""""""""""""""
" remap tab
inoremap <tab><tab> <tab>

" complete defined identifiers
imap <tab>d	<C-X><C-D>
" complete file names
imap <tab>f	<C-X><C-F>
" complete identifiers
imap <tab>i	<C-X><C-I>
" complete identifiers from dictionary
imap <tab>k	<C-X><C-K>
" complete whole lines
imap <tab>l	<C-X><C-L>
" next completion
imap <tab>n	<C-X><C-N>
" omni completion
imap <tab>o	<C-X><C-O>
" previous completion
imap <tab>p	<C-X><C-P>
" spelling suggestions
imap <tab>s	<C-X><C-S>
" complete identifiers from thesaurus
imap <tab>t	<C-X><C-T>
" complete with 'completefunc'
imap <tab>u	<C-X><C-U>
" complete like in : command line
imap <tab>v	<C-X><C-V>
" complete tags
imap <tab>]	<C-X><C-]>

"""""""""""""""""" WINDOW/COMMAND MANAGEMENT """""""""""""""""""""
" easier access to diff commands
nnoremap df :diffthis<cr>
nnoremap <silent> dF :diffoff!<cr>
nnoremap du :diffupdate<cr>

" easier mapping ala unimpaired
nnoremap [f :lprevious<cr>
nnoremap ]f :lnext<cr>

" window management
map <Leader>h <C-W>h                  " ;[hjkl] to navigate split windows
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l
map + <C-W>_                         " max window
map - <C-W>=                         " same size

" buffer management
" :q - close window and keep buffer, ]b, [b prev/next buffer, K list
map <Leader>q :bd<CR>                 " close current buffer and close window
map <Leader>Q :Bclose<CR>             " close current buffer and keep window
map <Leader>bo :BufOnly<CR>           " close all buffers and windows except this
nnoremap K :ls<CR>:b<space>

"""""""""""""""""" PLUGIN SPECIFIC BINDINGS """"""""""""""""""""""
" Ack command/shortcut
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nnoremap <leader>a :Ack

" start ctrlp
let g:ctrlp_map='<Leader>N'
let g:ctrlp_by_filename=1
let g:ctrlp_match_window_bottom=0
let g:ctrlp_max_height=15
let g:ctrlp_open_multiple_files='1vr'
let g:ctrlp_custom_ignore = {'dir':'\.git$\|\.hg$\|\.svn$'}

" easymotion options and bindings
let EasyMotion_do_mapping=0
nnoremap <silent> L      :call EasyMotion#F(0, 0)<cr>
vnoremap <silent> L :<C-U>call EasyMotion#F(1, 0)<cr>
nnoremap <silent> H      :call EasyMotion#F(0, 1)<cr>
vnoremap <silent> H :<C-U>call EasyMotion#F(1, 1)<cr>

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

" nerdtree bindings and settings
map <Leader>n :NERDTreeToggle<CR>
let NERDChDirMode=2
let NERDTreeIgnore=['\~$', '\.aux$', '\.blg$', '\.bbl$', '\.log$', '\.dvi$']
let NERDTreeShowBookmarks=1

" replace set to R, allows for R to delete and replace motions
map R <Plug>(operator-replace)

" signature options
map m<del> <Plug>SIG_PurgeMarks
map m<space> :SignatureToggleDisplay<cr>

" snippets variable
let g:snips_author='Joshua Finnis'

" syntastic settings
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons=0
let g:syntastic_loc_list_height=5
let g:syntastic_enable_signs=0
map <F12> :SyntasticToggleMode<CR>

" tabular settings to align at = and after : for blocks of code
nmap <Leader>= :Tabularize /=<CR>
vmap <Leader>= :Tabularize /=<CR>
nmap <Leader>: :Tabularize /:\zs/l0l1<CR>
vmap <Leader>: :Tabularize /:\zs/l0l1<CR>

" tagbar settings
let g:tagbar_width=30
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_autoshowtag=1
map <Leader>tl :TagbarToggle<CR>

" vimux commands
map ! :call PromptVimTmuxCommand()<CR>
map <leader>! :call RunLastVimTmuxCommand()<CR>
let g:VimuxUseNearestPane=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""" COMMANDS """""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" close buffer without closing window
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

" add number text object (e.g., for accessing "afajl123456-aiajf")
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

" command to save a file with sudo priveleges
command! -bar -nargs=0 Sudow 	:silent exe "write !sudo tee % >/dev/null"|silent edit

" in this mode, don't obey wrap rules for moving down and up through lines
function! ToggleSingleLine()
  if !exists("s:imove")
    let s:imove=1 "zero: not enabled
  endif
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
map <F9> :call ToggleSingleLine()<CR>

" functions to set scripts as executable and add a shebang to beginning
function! SetExecutableBit()
	" This function is taken from
	" http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer
	" Thanks Max Ischenko!
	let fname = expand("%:p")
	checktime
	execute "au FileChangedShell " . fname . " :echo"
	silent !chmod a+x %
	checktime
	execute "au! FileChangedShell " . fname
endfunction
function! SetShebang()
python << endpython
import vim
shebang = {
	'python':     '#!/usr/bin/env python',
	'sh':         '#!/bin/bash',
	'zsh':        '#!/bin/zsh',
	'javascript': '#!/usr/local/bin/node',
	'lua':        '#!/usr/bin/env lua',
	'ruby':       '#!/usr/bin/env ruby',
	'perl':       '#!/usr/bin/perl',
	'php':        '#!/usr/bin/php',
}
if not vim.current.buffer[0].startswith('#!'):
	filetype = vim.eval('&filetype')
	if filetype in shebang:
		vim.current.buffer[0:0] = [ shebang[filetype] ]
endpython
endfunction
function! SetExecutable()
    call SetExecutableBit()
    call SetShebang()
endfunction
map X :w<CR>:call SetExecutable()<CR>

" hexdumps the file (as a toggle)
function! ToggleHexdump()
    if !exists("s:xxd")
        let s:xxd=1 "zero: not enabled
    endif
    if s:xxd
        %!xxd
        let s:xxd=0
    else
        %!xxd -r
        let s:xxd=1
    endif
endfunction
map <F8> :call ToggleHexdump()<CR>

" free keys: , _ M Z \ ` F2-7
