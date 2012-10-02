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
nmap <silent> <buffer> <space>R :w<cr>:cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk '/TOOL_NAME/ {print $3}' GNUmakefile)")<cr>:echo "Building GNUmakefile and running command"<cr>
" get rid of default NSlog info
nmap <silent> <buffer> <space>rr :w<cr>:cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk '/TOOL_NAME/ {print $3}' GNUmakefile) <bar>& cut -d\\\  -f4- ")<cr>:echo "Building GNUmakefile and running command"<cr>
" ... and pipe output to column
nmap <silent> <buffer> <space>rc :w<cr>:cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk '/TOOL_NAME/ {print $3}' GNUmakefile) <bar>& cut -d\\\  -f4- <bar> column")<cr>:echo "Building GNUmakefile and running command"<cr>
" ... and pipe output to less
nmap <silent> <buffer> <space>rl :w<cr>:cd %:h<cr>:call RunVimTmuxCommand("make && ./obj/$(awk '/TOOL_NAME/ {print $3}' GNUmakefile) <bar>& cut -d\\\  -f4- <bar> less")<cr>:echo "Building GNUmakefile and running command"<cr>
