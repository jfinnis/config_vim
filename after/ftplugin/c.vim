set formatoptions-=o        " don't put comment leader when using o
set shiftwidth=3            " indent width using '<' and '>'
set softtabstop=3           " 3 space tabs
set tabstop=3

" feature-full folding plugin
"source ~/.vim/after/ftplugin/c-fold.vim
set foldmethod=indent

" surround mappings for f, i, and w
let b:surround_102="for (<++>)\n{\n\t\r\n}"
let b:surround_105="if (<++>)\n{\n\t\r\n}"
let b:surround_119="while (<++>)\n{\n\t\r\n}"

" improve by converting to a function, just not sure how
nmap <silent> <space>c :let @9=@/<cr>$?\/-<cr>zf/^\(\s*\/\)\@!<cr>:let @/=@9<cr>
" insert trailing comments after } braces
nmap <silent> <space>C :SmartBraceCommenter<CR>:SmartPreProcCommenter<CR>

" space+g/G highlights debug statements (with #ifdef XX)
map <silent> <space>g :call AddCommentDefine()<CR>
map <silent> <space>G :call ClearCommentDefine()<CR>
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
nmap <silent> <space>hf :FSHere<cr>
nmap <silent> <space>hl :FSRight<cr>
nmap <silent> <space>hL :FSSplitRight<cr>
nmap <silent> <space>hh :FSLeft<cr>
nmap <silent> <space>hH :FSSplitLeft<cr>
nmap <silent> <space>hk :FSAbove<cr>
nmap <silent> <space>hK :FSSplitAbove<cr>
nmap <silent> <space>hj :FSBelow<cr>
nmap <silent> <space>hJ :FSSplitBelow<cr>
