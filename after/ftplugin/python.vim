" run current script in right or bottom pane
nmap <space>rl :let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:cd %:h<cr>:call RunVimTmuxCommand("python %")<cr>
nmap <space>rj :let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:cd %:h<cr>:call RunVimTmuxCommand("python %")<cr>