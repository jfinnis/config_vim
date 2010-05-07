set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set wrap

set complete+=k~/.vim/syntax/python.vim isk+=.,(

map <Leader>f <S-f>    " toggle all folds

" Execute file being edited with <Shift> + e:
map <buffer> <Leader>e :W<CR>:!/usr/bin/env python % <CR>

" check syntax of file when saving
command Pyflakes :call Pyflakes()
function! Pyflakes()
    set makeprg=pyflakes make "%" 
    cw
endfunction
autocmd BufWrite *.{py} :call Pyflakes()

" set F7 and Shift F7 to add breakpoint/remove all breakpoints
python << EOF
def SetBreakpoint(): 
    import re 
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line 
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
        "%(space)sfrom ipdb import set_trace;set_trace() %(mark)s Breakpoint %(mark)s" %
        {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints(): 
    import re 
    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = [] 
    nLine = 1 
    for strLine in vim.current.buffer:
        if strLine.lstrip()[:38] == 'from ipdb import set_trace;set_trace()':
            nLines.append( nLine) 
            print nLine 
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( 'normal %dG' % nCurrentLine)

vim.command( 'map <s-f7> :py RemoveBreakpoints()<cr>')
EOF
