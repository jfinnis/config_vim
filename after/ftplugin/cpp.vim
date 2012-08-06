" reads all settings from after/ftplugin/c.vim

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
