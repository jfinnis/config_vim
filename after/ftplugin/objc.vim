" reads in settings and mappings from after/ftplugin/c.vim

" create makefiles and fill in makefiles 
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
nmap <buffer> <space>R :cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk -F= '/TOOL_NAME/ {print $2}' GNUmakefile)")<cr>
" pipe output to column
nmap <buffer> <space>rc :cd %:h<cr>::call RunVimTmuxCommand("make && ./obj/$(awk -F= '/TOOL_NAME/ {print $2}' GNUmakefile) <bar> column")<cr>
" pipe output to less
nmap <buffer> <space>rl :cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk -F= '/TOOL_NAME/ {print $2}' GNUmakefile) <bar> less")<cr>
