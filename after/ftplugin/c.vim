" OPTIONS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" tab and formatting guidelines ---------------------------------------- {{{2
setlocal formatoptions-=o        " don't put comment leader when using o
setlocal noexpandtab             " coding guidelines
setlocal shiftwidth=3            " indent width using '<' and '>'
setlocal softtabstop=3           " 3 space tabs
setlocal tabstop=3

" folding settings ----------------------------------------------------- {{{2
setlocal foldmethod=indent
" feature-full folding plugin - find better folding plugin
"source ~/.vim/after/ftplugin/c-fold.vim

" MAPPINGS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" surround mappings for f, i, and w ------------------------------------ {{{2
let b:surround_102="for ()\n{\n\t\r\n}"
let b:surround_105="if (<++>)\n{\n\t\r\n}"
let b:surround_119="while (<++>)\n{\n\t\r\n}"

" collapse reycomment block (can't do with fdm != manual) -------------- {{{2
" improve by converting to a function, just not sure how
nmap <buffer> <silent> <space>c :let @9=@/<cr>$?\/-<cr>zf/^\(\s*\/\)\@!<cr>:let @/=@9<cr>

" insert trailing comments after } braces ------------------------------ {{{2
nmap <buffer> <silent> <space>C :SmartBraceCommenter<CR>:SmartPreProcCommenter<CR>

" open corresponding header/source file -------------------------------- {{{2
nmap <buffer> <silent> <space>hf :FSHere<cr>
nmap <buffer> <silent> <space>hl :FSRight<cr>
nmap <buffer> <silent> <space>hL :FSSplitRight<cr>
nmap <buffer> <silent> <space>hh :FSLeft<cr>
nmap <buffer> <silent> <space>hH :FSSplitLeft<cr>
nmap <buffer> <silent> <space>hk :FSAbove<cr>
nmap <buffer> <silent> <space>hK :FSSplitAbove<cr>
nmap <buffer> <silent> <space>hj :FSBelow<cr>
nmap <buffer> <silent> <space>hJ :FSSplitBelow<cr>

" SYNTAX/HIGHLIGHTING """""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" highlight enums (needs tagbar) --------------------------------------- {{{2
highlight cEnumTag ctermfg=11 ctermbg=24

" highlight debug statements as comments ------------------------------- {{{2
" debug regions defined in after/syntax/c.vim
hi link cDebugRegion1 Comment
hi link cDebugRegion2 Comment
hi link cDebugWord Comment

"{{{1 vim:fdm=marker: 
