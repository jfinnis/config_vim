setlocal formatoptions=crqj
setlocal softtabstop=2           " 2 space tabs
setlocal shiftwidth=2            " indent width using '<' and '>'
setlocal tabstop=2

set foldmethod=syntax

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

nnoremap <buffer> <silent> <space>tj :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("npm run test")<cr>:echo "Running tests..."<cr>
nnoremap <buffer> <silent> <space>tl :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("npm run test")<cr>:echo "Running tests..."<cr>
