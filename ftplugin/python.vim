set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0
set smarttab expandtab
set nosmartindent
set fo=cq

" definition lookup
map <buffer> gd /def <C-R><C-W><CR>

" jpythonfold script http://www.vim.org/scripts/script.php?script_id=2527
source ~/.vim/ftplugin/jpythonfold.vim

" use python ctags
set tags+=$HOME/.vim/tags/python.ctags

" if python support is enabled
set omnifunc=pythoncomplete#Complete

" easier code completion with ctrl+space
inoremap <Nul> <C-X><C-o>

" highlight syntax errors
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

" type :make to compile, :cn, :cp, :clist to navigate errors
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m 

" not in this version?
"" use gf to to go python library file
"python << EOF
"import os, sys
"import vim
"for p in sys.path:
"  if os.path.isdir(p): vim.command(r"set path+=%s" % p.replace(" ", r"\ "))
"EOF

"" ctrl+h to evaluate a visually selected block
"python << EOL
"import vim
"def EvaluateCurrentRange():
"  eval(compile('\n'.join(vim.current.range),'','exec'),globals())
"EOL
"map <C-h> :py EvaluateCurrentRange()<cr>

"" f7 to add a breakpoint, shift+f7 to remove it
"python << EOF
"def SetBreakpoint():
"    import re
"    nLine = int( vim.eval( 'line(".")'))

"    strLine = vim.current.line
"    strWhite = re.search( '^(\s*)', strLine).group(1)

"    vim.current.buffer.append(
"       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
"         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

"    for strLine in vim.current.buffer:
"        if strLine == "import pdb":
"            break
"    else:
"        vim.current.buffer.append( 'import pdb', 0)
"        vim.command( 'normal j1')

"vim.command( 'map <f7> :py SetBreakpoint()<cr>')

"def RemoveBreakpoints():
"    import re

"    nCurrentLine = int( vim.eval( 'line(".")'))

"    nLines = []
"    nLine = 1
"    for strLine in vim.current.buffer:
"        if strLine == 'import pdb' or strLine.lstrip()[:15] == 'pdb.set_trace()':
"            nLines.append( nLine)
"        nLine += 1

"    nLines.reverse()

"    for nLine in nLines:
"        vim.command( 'normal %dG' % nLine)
"        vim.command( 'normal dd')
"        if nLine < nCurrentLine:
"            nCurrentLine -= 1

"    vim.command( 'normal %dG' % nCurrentLine)

"vim.command( 'map <s-f7> :py RemoveBreakpoints()<cr>')
"EOF
