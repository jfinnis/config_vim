" OPTIONS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" tab and formatting guidelines ---------------------------------------- {{{2
set formatoptions=cq
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=0

set expandtab
set nosmartindent
set smarttab 

" auto-open tagbar if closed ------------------------------------------ {{{2
" :TagbarOpen
set tags+=$HOME/.vim/.tags/python.ctags

" setup environment --------------------------------------------------- {{{2
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

python << EOF
import os, sys
import vim
for p in sys.path:
  if os.path.isdir(p): vim.command(r"set path+=%s" % p.replace(" ", r"\ "))
EOF

" COMPLETION """"""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" jedi-vim plugin

" SYNTAX/HIGHLIGHTING """""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" highlight syntax errors ---------------------------------------------- {{{2
let python_highlight_all=1
syn match WhitespaceEOL /\s\+$/
syn match pythonError "^\s*def\s\+\w\+(.*)\s*$" display
syn match pythonError "^\s*class\s\+\w\+(.*)\s*$" display
syn match pythonError "^\s*for\s.*[^:]$" display
syn match pythonError "^\s*except\s*$" display
syn match pythonError "^\s*finally\s*$" display
syn match pythonError "^\s*try\s*$" display
syn match pythonError "^\s*else\s*$" display
syn match pythonError "^\s*else\s*[^:].*$" display
syn match pythonError "^\s*if\s.*[^\:]$" display
syn match pythonError "[;]$" display
syn keyword pythonError do

" highlight autocomplete menu ------------------------------------------ {{{2
highlight Pmenu ctermfg=11 ctermbg=24
highlight PmenuSel ctermfg=11 ctermbg=30
highlight PmenuSbar ctermbg=24
highlight PmenuThumb ctermfg=11

" MAPPINGS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" space-e = evaluate a visually selected block ------------------------- {{{2
python << EOL
import vim
def EvaluateCurrentRange():
  eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
vmap <space>e :py EvaluateCurrentRange()<cr>

" space-j/Jl/Jc, space-l/Ll/Lc ----------------------------------------- {{{2
" run command in below or right window
nmap <silent> <space>j :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("python %")<cr>:echo "Executing file..."<cr>
nmap <silent> <space>l :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("python %")<cr>:echo "Executing file..."<cr>

" run and pipe to column or less
nmap <silent> <space>Jc :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("python % <bar> column")<cr>:echo "Executing file..."<cr>
nmap <silent> <space>Lc :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("python % <bar> column")<cr>:echo "Executing file..."<cr>

nmap <silent> <space>Jl :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("python % <bar> less")<cr>:echo "Executing file..."<cr>
nmap <silent> <space>Ll :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("python % <bar> less")<cr>:echo "Executing file..."<cr>

" space-b/B = add/remove breakpoints ----------------------------------- {{{2
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))
    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)
    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)
    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 0)
        vim.command( 'normal j1')
vim.command('map <space>b :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re
    nCurrentLine = int( vim.eval( 'line(".")'))
    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == 'import pdb' or strLine.lstrip()[:15] == 'pdb.set_trace()':
            nLines.append( nLine)
        nLine += 1
    nLines.reverse()
    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1
    vim.command( 'normal %dG' % nCurrentLine)
vim.command('map <space>B :py RemoveBreakpoints()<cr>')
EOF

"{{{1 vim:fdm=marker:
