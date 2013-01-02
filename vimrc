" VIMRC """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" pathogen -------------------------------------------------------------- {{{2
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" general settings ------------------------------------------------------ {{{2
set nocompatible
syntax on
let mapleader=";"
let g:tex_flavor='latex'    " allow recognition of latex files
set noautochdir               " change directory to the file you opened
set formatoptions=cqrl
set hidden                  " liberal hidden buffers
set history=100
set mouse=a
set shortmess=filmnrxtTI
set scrolloff=4             " lines below cursor while scrolling
set timeoutlen=500          " mappings must be completed within # milliseconds
set ttyfast
set wildmenu                " tab menu completion
set wildmode=longest,list   " tab completion settings

" editing settings ------------------------------------------------------ {{{2
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

" tab settings ---------------------------------------------------------- {{{2
set expandtab               " replace tabs with spaces
set shiftwidth=4            " indent width using '<' and '>'
set softtabstop=4           " 4 space tabs
set tabstop=4

" display settings ------------------------------------------------------ {{{2
colorscheme ir_black
hi CursorLine term=none cterm=none ctermbg=0
set laststatus=2            " always display status line
set nocul                   " highlight current line
set number                  " display line numbers
set ruler                   " show the cursor position always
set title                   " show file in titlebar
set t_Co=256                " number of colors:
"set relativenumber          " number lines relative to cursor

" search settings ------------------------------------------------------- {{{2
set hlsearch                " highlight search terms
set ignorecase              " ignore case in searches
set incsearch               " search incrementally
set smartcase               " ... unless capitals are included

" statusline ------------------------------------------------------------ {{{2
let g:Powerline_symbols='fancy'
" trailing whitespace indicator
" insert trailing whitespace notifier - disabled since it is buggy
"call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

" AUTOCOMMANDS """""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" viewing formatted files ----------------------------------------------- {{{2
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.pdf,*.rtf,*.odt,*.odp,*.doc set readonly

" format specific filetypes --------------------------------------------- {{{2
augroup filetypedetect
    autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setfiletype tmux
augroup END

" don't quote signatures in mutt files ---------------------------------- {{{2
au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L

" KEY UNBINDINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" nop dumb bindings ----------------------------------------------------- {{{2
map ZQ <nop>
map ZZ <nop>

" KEY BINDINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" insert mode mappings -------------------------------------------------- {{{2
" display ! marker on any "\TODO:" message
inoremap TODO: TODO:<c-o>:norm m1<cr>

" quick file access ----------------------------------------------------- {{{2
map <Leader>S :source ~/.vimrc<cr>:filetype detect<cr>:echo "Sourced vimrc"<cr>
map <leader>cd :cd %:h<cr>
map <leader>V :e ~/.vim/vimrc <bar> :cd ~/.vim<cr>
map <leader>M :e ~/.mutt/cfg/muttrc <bar> :cd ~/.mutt/cfg<cr>
map <leader>T :e ~/.tmux/tmux.conf <bar> :cd ~/.tmux<cr>
map <leader>Z :e ~/.zsh/zshrc <bar> :cd ~/.zsh<cr>

" formatting mappings --------------------------------------------------- {{{2
" reformat paragraph
map Q gqip

" reindent whole file and return cursor position
nmap g= gg=G<C-O><C-O>

" yanking/pasting improvements ------------------------------------------ {{{2
" make Y behave like other capitals
map Y y$

" easier clipboard access
map <leader>y "+y
map <leader>p :set paste<bar>put + <bar>set nopaste<cr>

" indent the just pasted text
nnoremap <Leader>> g'[>']
nnoremap <Leader>< g'[<']

" vreplace mode --------------------------------------------------------- {{{2
nnoremap gr gR

" split line at the current cursor position ----------------------------- {{{2
nnoremap S i<cr><esc>

" remove all trailing whitespace ---------------------------------------- {{{2
nnoremap <Leader>W :%s/\s\+$//<cr>:let @/=''<CR>:echo "Removed trailing whitespace"<CR>

" global substitute word under cursor ----------------------------------- {{{2
nmap <Leader>s :%s/\<<c-r>=expand("<cword>")<cr>\>/
vmap <Leader>s :<C-U>%s/\<<c-r>*\>/

" next/previous word under cursor in same column  ----------------------- {{{2
" i.e., to navigate amongst same blocks of structure code
nnoremap g* yiw:let c=col('.')<CR>:let @/="^.*\\%".c.'c\zs'.@"<CR>n
nnoremap g# yiw:let c=col('.')<CR>:let @/="^.*\\%".c.'c\zs'.@"<CR>N

" edit selection in new split by itself --------------------------------- {{{2
" <leader>x to return
xnoremap X y:let [f,s,v]=[&ft,&syn,getregtype('@"')]<CR><C-w>nVp:set ft=<c-r>=f<CR> syn=<c-r>=s<CR><CR>:nnoremap <buffer> <Leader>x :let @"=v<C-r>="<"<CR>CR>gg0@"G$d:bw!<C-r>="<"<CR>CR>gvp<CR>

" use M to lookup with man ---------------------------------------------- {{{2
nnoremap M K

" add number object for modification (cin, etc) ------------------------- {{{2
onoremap n :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap n :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap an :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap an :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap in :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap in :<c-u>call <SID>NumberTextObject(1)<cr>

" word completion ------------------------------------------------------- {{{2
" remap tab
inoremap <tab><tab> <tab>
inoremap <tab><space> <tab>
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
" scroll up in insert mode
imap <tab>e	<C-X><C-E>
" scroll down in insert mode
imap <tab>y	<C-X><C-Y>

" filetype management --------------------------------------------------- {{{2
map <leader><leader>c :set ft=c
map <leader><leader>C :set ft=cpp
map <leader><leader>o :set ft=objc
map <leader><leader>p :set ft=python
map <leader><leader>v :set ft=vim
map <leader><leader>z :set ft=zsh

" WINDOW/BUFFER MAPPINGS """""""""""""""""""""""""""""""""""""""""""""""" {{{1
" diff mappings --------------------------------------------------------- {{{2
nnoremap df :diffthis<cr>
nnoremap <silent> dF :diffoff!<cr>
nnoremap du :diffupdate<cr>

" recovery file diffing automated --------------------------------------- {{{2
nnoremap <silent> <Leader>d :sav! %_diff_tmpfile<cr>:vs<cr>:e #<cr>:diffthis<cr>l:diffthis<cr>
nnoremap <silent> <Leader>D :Bclose<cr>o:diffoff!<cr>:!rm %_diff_tmpfile<cr>:echo "Deleted tmpfile..."<cr>

" location list popup --------------------------------------------------- {{{2
map <space>l :llist<CR>

" window management ----------------------------------------------------- {{{2
map <Leader>h <C-W>h                  " ;[hjkl] to navigate split windows
map <Leader>j <C-W>j
map <Leader>k <C-W>k
map <Leader>l <C-W>l
map + <C-W>_                         " max window
map _ <C-W>=                         " same size

" window resizing ------------------------------------------------------- {{{2
nnoremap <silent> <C-W>< <C-W><:let g:LastWindowResize="in-horiz"<CR>
nnoremap <silent> <C-W>> <C-W>>:let g:LastWindowResize="out-horiz"<CR>
nnoremap <silent> <C-W>+ <C-W>+:let g:LastWindowResize="out-vert"<CR>
nnoremap <silent> <C-W>- <C-W>-:let g:LastWindowResize="in-vert"<CR>

" buffer management ----------------------------------------------------- {{{2
" :q - close window and keep buffer, ]b, [b prev/next buffer
map <Leader>, :e #<CR>                " open alternate buffer
map <Leader>q :bd<CR>                 " close current buffer and close window
map <Leader>Q :Bclose<CR>             " close current buffer and keep window
map <Leader>bo :BufOnly<CR>           " close all buffers and windows except this

" automatically centering text ------------------------------------------ {{{2
" can use zz/t/b in visual mode to center/top/bottom selection
xnoremap <silent> zz :<C-u>call setpos('.',[0,(line("'>")-line("'<"))/2+line("'<"),0,0])<Bar>normal! zzgv<CR>
xnoremap <silent> zt :<C-u>call setpos('.',[0,line("'<"),0,0])<Bar>normal! ztgv<CR>
xnoremap <silent> zb :<C-u>call setpos('.',[0,line("'>"),0,0])<Bar>normal! zbgv<CR>

" center screen for searches, foldcloses, {, }, [[, ]]
nnoremap n nzz
nnoremap N Nzz
nnoremap { {zz
nnoremap } }zz
nnoremap [[ [[zz
nnoremap ]] ]]zz
nnoremap zc zczz
nnoremap zo zozz
nnoremap ]c ]czz
nnoremap [c [czz

" ... and marks (thanks to bairui)
:for m in map(map(range(10), 'nr2char(48+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor
:for m in map(map(range(26), 'nr2char(65+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor
:for m in map(map(range(26), 'nr2char(97+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor

" can use zz/t/b in visual mode to center/top/bottom selection
xnoremap <silent> zz :<C-u>call setpos('.',[0,(line("'>")-line("'<"))/2+line("'<"),0,0])<Bar>normal! zzgv<CR>
xnoremap <silent> zt :<C-u>call setpos('.',[0,line("'<"),0,0])<Bar>normal! ztgv<CR>
xnoremap <silent> zb :<C-u>call setpos('.',[0,line("'>"),0,0])<Bar>normal! zbgv<CR>

" PLUGIN SPECIFIC BINDINGS """""""""""""""""""""""""""""""""""""""""""""" {{{1
" Ack command/shortcut -------------------------------------------------- {{{2
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nnoremap <leader>a :Ack 
nnoremap <leader>K :AckHelp 

" start ctrlp ----------------------------------------------------------- {{{2
let g:ctrlp_map='<Leader>N'
let g:ctrlp_by_filename=1
let g:ctrlp_match_window_bottom=0
let g:ctrlp_max_height=15
let g:ctrlp_open_multiple_files='1vr'
let g:ctrlp_custom_ignore = {'dir':'\.git$\|\.hg$\|\.svn$'}
nnoremap <leader>. :CtrlPTag<cr>

" easymotion options and bindings (visual binding screws up snippets) --- {{{2
let EasyMotion_do_mapping=0
nnoremap <silent> L      :call EasyMotion#F(0, 0)<cr>
nnoremap <silent> H      :call EasyMotion#F(0, 1)<cr>
xnoremap <silent> L :<C-U>call EasyMotion#F(1, 0)<cr>
xnoremap <silent> H :<C-U>call EasyMotion#F(1, 1)<cr>

" easytags settings ----------------------------------------------------- {{{2
set tags=./.tags;
let g:easytags_by_filetype='~/.vim/.tags/'
let g:easytags_dynamic_files=1
let g:easytags_file='~/.vim/.easytagsFile'
let g:easytags_python_enabled=1
map <space>u :UpdateTags<CR>

" fugitive git wrapping ------------------------------------------------- {{{2
map <Leader>gs :Gstatus<CR>
map <Leader>ga :Git add %<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gw :Gbrowse<CR>
map <Leader>gc :Gcommit -a<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gl :Glog<CR>
map <Leader>gp :Git push origin master<CR>
autocmd BufReadPost fugitive://* set bufhidden=delete

" jedi python autocomplete ---------------------------------------------- {{{2
let g:jedi#get_definition_command="gd"
let g:jedi#goto_command="<space>g"
let g:jedi#related_names_command=""
let g:jedi#rename_command="<space>r"
let g:jedi#pydoc="<space>d"
let g:jedi#use_tabs_not_buffers=0

" nerdtree bindings and settings ---------------------------------------- {{{2
map <Leader>n :NERDTreeToggle<CR>
let NERDChDirMode=2
let NERDTreeAutoDeleteBuffer=1
let NERDTreeBookmarksFile="NERDTreeBookmarks"
let NERDTreeIgnore=['\~$', '\.aux$', '\.blg$', '\.bbl$', '\.log$', '\.dvi$']
let NERDTreeShowBookmarks=1

" quicktask options and bindings ---------------------------------------- {{{2
let g:quicktask_autosave=1
let g:quicktask_snip_path="/home/josh/.vim/quicktask-snips"
let g:quicktask_snip_win_maximize=1
" autocmds and mappings defined in ftplugin/quicktask

" rainbow colored parentheses ------------------------------------------- {{{2
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" relops extra operators ------------------------------------------------ {{{2
let g:relops_mappings=['R']

" replace set to R, allows for R to delete and replace motions ---------- {{{2
map R <Plug>(operator-replace)

" signature options ----------------------------------------------------- {{{2
highlight SignColumn ctermbg=16
map m<del> <Plug>SIG_PurgeMarks
map m<space> :SignatureToggleDisplay<cr>

" SimpylFold options ---------------------------------------------------- {{{2
let g:SimpylFold_docstring_preview=1

" skybison mappings ----------------------------------------------------- {{{2
nnoremap <space>; :<c-u>call SkyBison("")<cr>
nnoremap K 2:<c-u>call SkyBison("b ")<cr>
cnoremap <c-l> <c-r>=SkyBison("")<cr><cr>

" snippets variable ----------------------------------------------------- {{{2
let g:snips_author='Joshua Finnis'

" switch bindings ------------------------------------------------------- {{{2
nnoremap - :Switch<CR>

" syntastic settings ---------------------------------------------------- {{{2
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons=0
let g:syntastic_loc_list_height=5
let g:syntastic_enable_signs=1
map <F12> :SyntasticToggleMode<CR>

" tabular settings to align at = and after : for blocks of code --------- {{{2
nmap <Leader>= :Tabularize /=<CR>
vmap <Leader>= :Tabularize /=<CR>
nmap <Leader>: :Tabularize /:\zs/l0l1<CR>
vmap <Leader>: :Tabularize /:\zs/l0l1<CR>

" tagbar settings ------------------------------------------------------- {{{2
let g:tagbar_width=30
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_autoshowtag=1
map <Leader>tl :TagbarToggle<CR>
"let g:tagbar_type_objc={'ctagstype':'ObjectiveC', 'kinds':['i:interface', 'I:implementation', 'p:Protocol', 'm:Object_method', 'c:Class_method', 'v:Global_variable', 'F:Object field', 'f:function', 'p:property', 't:type_alias', 's:type_structure', 'e:enumeration', 'M:preprocessor_macro'], 'sro':' ', 'kind2scope':{'i':'interface', 'I':'Implementation', 'p':'Protocol', 's':'type_structure', 'e':'enumeration'}, 'scope2kind':{'interface':'i', 'implementation':'I', 'Protocol':'p', 'type_structure':'s', 'enumeration':'e'}}

" vimux commands -------------------------------------------------------- {{{2
map ! :call PromptVimTmuxCommand()<CR>
map <space>! :call RunLastVimTmuxCommand()<CR>
map <space>@ :CloseVimTmuxPanes<cr>
let g:VimuxUseNearestPane=0

" COMMANDS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" align according to |s ------------------------------------------------- {{{2
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

" close buffer without closing window ----------------------------------- {{{2
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

" add number text object (e.g., for accessing "afajl123456-aiajf") ------ {{{2
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

" command to save a file with sudo priveleges --------------------------- {{{2
command! -bar -nargs=0 Sudow 	:silent exe "write !sudo tee % >/dev/null"|silent edit

" toggle wrap rules for moving down and up through lines ---------------- {{{2
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

" set scripts as executable and add a shebang to beginning -------------- {{{2
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
nmap X :w<CR>:call SetExecutable()<CR>

" hexdumps the file (as a toggle) --------------------------------------- {{{2
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

" resize window according to last resize -------------------------------- {{{2
function! RepeatResize()
    if exists("g:LastWindowResize")
        if match(g:LastWindowResize, "in-horiz") == 0
            normal! <
        elseif match(g:LastWindowResize, "out-horiz") == 0
            normal! >
        elseif match(g:LastWindowResize, "out-vert") == 0
            normal! +
        else
            normal! -
        endif
    endif
endfunction
map <silent> , :call RepeatResize()<CR>

" free keys: Z \ ` F2-7 {{{2
"{{{1 vim:fdm=marker:
