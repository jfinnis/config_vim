setlocal formatoptions=crqj
setlocal softtabstop=2           " 2 space tabs
setlocal shiftwidth=2            " indent width using '<' and '>'
setlocal tabstop=2

set foldmethod=syntax

" vim-javascript settings
setlocal conceallevel=1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"

nnoremap <space>D :TernDoc<cr>
nnoremap <space>b :TernDocBrowse<cr>
nnoremap <space>T :TernType<cr>
nnoremap <space>dd :TernDef<cr>
nnoremap <space>ds :TernDefSplit<cr>
nnoremap <space>dv :TernDefSplitVertical<cr>
nnoremap <space>r :TernRefs<cr>
nnoremap <space>R :TernRename<cr>

nnoremap <buffer> <silent> <space>tj :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("npm run test")<cr>:echo "Running tests..."<cr>
nnoremap <buffer> <silent> <space>tl :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("npm run test")<cr>:echo "Running tests..."<cr>
