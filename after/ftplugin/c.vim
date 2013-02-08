" OPTIONS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" tab and formatting guidelines ---------------------------------------- {{{2
setlocal formatoptions-=o        " don't put comment leader when using o
setlocal noexpandtab             " coding guidelines
setlocal shiftwidth=3            " indent width using '<' and '>'
setlocal softtabstop=3           " 3 space tabs
setlocal tabstop=3

setlocal iskeyword+=#            " so #if is considered as a keyword, etc
setlocal iskeyword-=-            " so ptr- (in ptr->member) is not

" folding settings ----------------------------------------------------- {{{2
" custom folding plugin
source ~/.vim/after/ftplugin/c-fold.vim

" OmniCppComplete initialization --------------------------------------- {{{2
"call omni#cpp#complete#Init()

" MAPPINGS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" surround mappings for f, i, and w ------------------------------------ {{{2
let b:surround_102="for ()\n{\n\t\r\n}"
let b:surround_105="if (<++>)\n{\n\t\r\n}"
let b:surround_119="while (<++>)\n{\n\t\r\n}"

" collapse reycomment block (can't do with fdm != manual) -------------- {{{2
" improve by converting to a function, just not sure how
nnoremap <buffer> <silent> <space>c :let @9=@/<cr>$?\/-<cr>zf/^\(\s*\/\)\@!<cr>:let @/=@9<cr>

" insert trailing comments after } braces ------------------------------ {{{2
nnoremap <buffer> <silent> <space>C :SmartBraceCommenter<CR>:SmartPreProcCommenter<CR>

" visual select the current function ----------------------------------- {{{2
" closing brace must be in the first column (otherwise it's a one line
" function and you can just hit V)
" TODO- turn into a text object (this has probably been done)
nnoremap <space>v $?^\w\w*\s*.*(.*)\s*\(const\<bar>\)\_s{<cr>V0/^}<cr>
nnoremap <space>V $?^\w\w*\s*.*(.*)\s*\(const\<bar>\)\_s{<cr>V0/^}\_s*\zs$<cr>

" open corresponding header/source file -------------------------------- {{{2
nnoremap <buffer> <silent> <space>hf :FSHere<cr>
nnoremap <buffer> <silent> <space>hl :FSRight<cr>
nnoremap <buffer> <silent> <space>hL :FSSplitRight<cr>
nnoremap <buffer> <silent> <space>hh :FSLeft<cr>
nnoremap <buffer> <silent> <space>hH :FSSplitLeft<cr>
nnoremap <buffer> <silent> <space>hk :FSAbove<cr>
nnoremap <buffer> <silent> <space>hK :FSSplitAbove<cr>
nnoremap <buffer> <silent> <space>hj :FSBelow<cr>
nnoremap <buffer> <silent> <space>hJ :FSSplitBelow<cr>

" SYNTAX/HIGHLIGHTING """""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" highlight enums (needs tagbar) --------------------------------------- {{{2
highlight cEnumTag ctermfg=11 ctermbg=24

" highlight debug statements as comments ------------------------------- {{{2
" debug regions defined in after/syntax/c.vim
hi link cDebugRegion1 Comment
hi link cDebugRegion2 Comment
hi link cDebugWord Comment

" highlight assignments in if/while parentheses ------------------------ {{{2
hi def link cAssignInConditionBad    SpellBad
hi def link cAssignInConditionRare   SpellRare

"{{{1 vim:fdm=marker: 
