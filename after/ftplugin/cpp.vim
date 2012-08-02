setlocal noexpandtab             " coding guidelines
setlocal formatoptions-=o        " don't put comment leader when using o
setlocal shiftwidth=3            " indent width using '<' and '>'
setlocal softtabstop=3           " 3 space tabs
setlocal tabstop=3

" feature-full folding plugin
"source ~/.vim/after/ftplugin/c-fold.vim
setlocal foldmethod=indent

" surround mappings for f, i, and w
let b:surround_102="for (<++>)\n{\n\t\r\n}"
let b:surround_105="if (<++>)\n{\n\t\r\n}"
let b:surround_119="while (<++>)\n{\n\t\r\n}"

" improve by converting to a function, just not sure how
nmap <buffer> <silent> <space>c :let @9=@/<cr>$?\/-<cr>zf/^\(\s*\/\)\@!<cr>:let @/=@9<cr>
" insert trailing comments after } braces
nmap <buffer> <silent> <space>C :SmartBraceCommenter<CR>:SmartPreProcCommenter<CR>

" space+g/G highlights debug statements (with #ifdef XX)
nmap <buffer> <silent> <space>g :call AddCommentDefine()<CR>
nmap <buffer> <silent> <space>G :call ClearCommentDefine()<CR>
syn region MySkip contained start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*#\s*endif\>" contains=MySkip
let g:CommentDefines = ""
hi link MyCommentOut2 MyCommentOut
hi link MySkip MyCommentOut
hi link MyCommentOut Comment
function! AddCommentDefine()
  let g:CommentDefines = "\\(" . expand("<cword>") . "\\)"
  syn clear MyCommentOut
  syn clear MyCommentOut2
  exe 'syn region MyCommentOut start="^\s*#\s*ifdef\s\+' . g:CommentDefines . '\>" end=".\|$" contains=MyCommentOut2'
  exe 'syn region MyCommentOut2 contained start="' . g:CommentDefines . '" end="^\s*#\s*\(endif\>\|else\>\|elif\>\)" contains=MySkip'
endfunction
function! ClearCommentDefine()
  let g:ClearCommentDefine = ""
  syn clear MyCommentOut
  syn clear MyCommentOut2
endfunction

" mappings to open corresponding header/source file
nmap <buffer> <silent> <space>hf :FSHere<cr>
nmap <buffer> <silent> <space>hl :FSRight<cr>
nmap <buffer> <silent> <space>hL :FSSplitRight<cr>
nmap <buffer> <silent> <space>hh :FSLeft<cr>
nmap <buffer> <silent> <space>hH :FSSplitLeft<cr>
nmap <buffer> <silent> <space>hk :FSAbove<cr>
nmap <buffer> <silent> <space>hK :FSSplitAbove<cr>
nmap <buffer> <silent> <space>hj :FSBelow<cr>
nmap <buffer> <silent> <space>hJ :FSSplitBelow<cr>

" protodef settings - read in prototypes from header file
nmap <buffer> <silent> <space>p :set paste<cr>i<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})<cr><esc>='[:set nopaste<cr>:echo "Updated Skeleton Functions"<cr>
nmap <buffer> <silent> <space>P :set paste<cr>i<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS':0})<cr><esc>='[:set nopaste<cr>:echo "Updated Skeleton Functions (no namespaces)"<cr>
let g:disable_protodef_sorting="true"
let g:disable_protodef_mapping="true"
let g:protodefvaluedefaults = 
            \ {
            \     'int'                  : '(0)',
            \     'unsigned int'         : '(0)',
            \     'const int'            : '(0)',
            \     'const unsigned int'   : '(0)',
            \     'long'                 : '(0)',
            \     'unsigned long'        : '(0)',
            \     'const long'           : '(0)',
            \     'const unsigned long'  : '(0)',
            \     'short'                : '(0)',
            \     'unsigned short'       : '(0)',
            \     'const short'          : '(0)',
            \     'const unsigned short' : '(0)',
            \     'char'                 : "'(a)'",
            \     'unsigned char'        : "'(a)'",
            \     'const char'           : "'(a)'",
            \     'const unsigned char'  : "'(a)'",
            \     'bool'                 : '(true)',
            \     'const bool'           : '(true)'
            \ }

" only set once tagbar is opened
highlight cEnumTag ctermfg=11 ctermbg=24
