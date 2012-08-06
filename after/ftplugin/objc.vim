setlocal noexpandtab             " don't convert tabs to spaces, ugh coding standards
setlocal formatoptions-=o        " don't put comment leader when using o
setlocal shiftwidth=3            " indent width using '<' and '>'
setlocal softtabstop=3           " 3 space tabs
setlocal tabstop=3
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

" fswitch mappings to open corresponding header/source file
nmap <buffer> <silent> <space>hf :FSHere<cr>
nmap <buffer> <silent> <space>hl :FSRight<cr>
nmap <buffer> <silent> <space>hL :FSSplitRight<cr>
nmap <buffer> <silent> <space>hh :FSLeft<cr>
nmap <buffer> <silent> <space>hH :FSSplitLeft<cr>
nmap <buffer> <silent> <space>hk :FSAbove<cr>
nmap <buffer> <silent> <space>hK :FSSplitAbove<cr>
nmap <buffer> <silent> <space>hj :FSBelow<cr>
nmap <buffer> <silent> <space>hJ :FSSplitBelow<cr>

" only set once tagbar is opened
" TODO look into getting tagbar to work with objective c
"highlight cEnumTag ctermfg=11 ctermbg=24

" create objective c makefiles using defined snippet
" uses similar split management scheme as fswitch plugin
nmap <buffer> <space>M :e %:h/GNUmakefile<cr>
nmap <buffer> <space>mF :e %:h/GNUmakefile<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>mh <c-w>h:e %:h/GNUmakefile<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>mH :set nosplitright<cr>:vs %:h/GNUmakefile<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>ml <c-w>l:e %:h/GNUmakefile<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>mL :set splitright<cr>:vs %:h/GNUmakefile<cr>:set nosplitright<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>mk <c-w>k:e %:h/GNUmakefile<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>mK :set nosplitbelow<cr>:sp %:h/GNUmakefile<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>mj <c-w>j:e %:h/GNUmakefile<cr>ggdGiobjc-alternate<tab>
nmap <buffer> <space>mJ :set splitbelow<cr>:sp %:h/GNUmakefile<cr>:set nosplitbelow<cr>ggdGiobjc-alternate<tab>

" make and run command in new tmux pane
nmap <silent> <buffer> <space>R :cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk '/TOOL_NAME/ {print $3}' GNUmakefile)")<cr>:echo "Building GNUmakefile and running command"<cr>
" pipe output to column
nmap <silent> <buffer> <space>rc :cd %:h<cr>::call RunVimTmuxCommand("make && ./obj/$(awk '/TOOL_NAME/ {print $3}' GNUmakefile) <bar> column")<cr>:echo "Building GNUmakefile and running command"<cr>
" pipe output to less
nmap <silent> <buffer> <space>rl :cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk '/TOOL_NAME/ {print $3}' GNUmakefile) <bar> less")<cr>:echo "Building GNUmakefile and running command"<cr>
