" OPTIONS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" tab and formatting guidelines ---------------------------------------- {{{2
setlocal formatoptions=cq
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal textwidth=0

setlocal expandtab
setlocal nosmartindent
setlocal smarttab 

" folding -------------------------------------------------------------- {{{2
setlocal foldmethod=expr
setlocal foldexpr=PymodeFoldingExpr(v:lnum)
setlocal foldtext=PymodeFoldingText()

" debugging options ---------------------------------------------------- {{{2
"let g:vdebug_options['timeout']=5
"let g:vdebug_options['on_close']='stop'
"let g:vdebug_options['watch_window_style']='compact'
"let g:vdebug_options['marker_default']='⬦'
"let g:vdebug_options['marker_closed_tree']='▸'
"let g:vdebug_options['marker_open_tree']='▾'

" setup environment ---------------------------------------------------- {{{2
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
" jedi-vim plugin ------------------------------------------------------ {{{2

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
" remapped motions - ]], ]M, ]m, aM, im, etc --------------------------- {{{2
nnoremap <silent> <buffer> ]]  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', '')<CR>
nnoremap <silent> <buffer> [[  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', 'b')<CR>
nnoremap <silent> <buffer> ]M  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', '')<CR>
nnoremap <silent> <buffer> [M  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', 'b')<CR>
nnoremap <silent> <buffer> ]m  :<C-U>call PymodeMotionMove('^\s*def\s', '')<CR>
nnoremap <silent> <buffer> [m  :<C-U>call PymodeMotionMove('^\s*def\s', 'b')<CR>

onoremap <silent> <buffer> ]]  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', '')<CR>
onoremap <silent> <buffer> [[  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', 'b')<CR>
onoremap <silent> <buffer> ]M  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', '')<CR>
onoremap <silent> <buffer> [M  :<C-U>call PymodeMotionMove('^\(class\\|def\)\s', 'b')<CR>
onoremap <silent> <buffer> ]m  :<C-U>call PymodeMotionMove('^\s*def\s', '')<CR>
onoremap <silent> <buffer> [m  :<C-U>call PymodeMotionMove('^\s*def\s', 'b')<CR>

vnoremap <silent> <buffer> ]]  :call PymodeMotionVmove('^\(class\\|def\)\s', '')<CR>
vnoremap <silent> <buffer> [[  :call PymodeMotionVmove('^\(class\\|def\)\s', 'b')<CR>
vnoremap <silent> <buffer> ]m  :call PymodeMotionVmove('^\s*def\s', '')<CR>
vnoremap <silent> <buffer> [m  :call PymodeMotionVmove('^\s*def\s', 'b')<CR>

onoremap <silent> <buffer> M  :<C-U>call PymodeMotionSelect('^\s*class\s', 0)<CR>
onoremap <silent> <buffer> aM :<C-U>call PymodeMotionSelect('^\s*class\s', 0)<CR>
onoremap <silent> <buffer> iM :<C-U>call PymodeMotionSelect('^\s*class\s', 1)<CR>
vnoremap <silent> <buffer> aM :<C-U>call PymodeMotionSelect('^\s*class\s', 0)<CR>
vnoremap <silent> <buffer> iM :<C-U>call PymodeMotionSelect('^\s*class\s', 1)<CR>

onoremap <silent> <buffer> m  :<C-U>call PymodeMotionSelect('^\s*def\s', 0)<CR>
onoremap <silent> <buffer> am :<C-U>call PymodeMotionSelect('^\s*def\s', 0)<CR>
onoremap <silent> <buffer> im :<C-U>call PymodeMotionSelect('^\s*def\s', 1)<CR>
vnoremap <silent> <buffer> am :<C-U>call PymodeMotionSelect('^\s*def\s', 0)<CR>
vnoremap <silent> <buffer> im :<C-U>call PymodeMotionSelect('^\s*def\s', 1)<CR>

" space-j/Jl/Jc, space-l/Ll/Lc ----------------------------------------- {{{2
" run command in below or right window
nnoremap <buffer> <silent> <space>j :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("python %")<cr>:echo "Executing file..."<cr>
nnoremap <buffer> <silent> <space>l :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("python %")<cr>:echo "Executing file..."<cr>

" run and pipe to column or less
nnoremap <buffer> <silent> <space>Jc :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("python % <bar> column")<cr>:echo "Executing file..."<cr>
nnoremap <buffer> <silent> <space>Lc :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("python % <bar> column")<cr>:echo "Executing file..."<cr>

nnoremap <buffer> <silent> <space>Jl :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("python % <bar> less")<cr>:echo "Executing file..."<cr>
nnoremap <buffer> <silent> <space>Ll :w<cr>:cd %:h<cr>:CloseVimTmuxPanes<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="40"<cr>:call RunVimTmuxCommand("python % <bar> less")<cr>:echo "Executing file..."<cr>

" basic debugger commands: d/dc/R/s/So/Si/e/E/C ------------------------ {{{2
nnoremap <buffer> <space>d :python debugger.run()<cr>
nnoremap <buffer> <space>dc :python debugger.close()<cr>

nnoremap <buffer> <space>R :python debugger.run_to_cursor()<cr>
nnoremap <buffer> <space>s :python debugger.step_over()<cr>
nnoremap <buffer> <space>So :python debugger.step_out()<cr>
nnoremap <buffer> <space>Si :python debugger.step_into()<cr>

nnoremap <buffer> <space>e :VdebugEval 
vnoremap <buffer> <space>e :python debugger.handle_visual_eval()<cr>
nnoremap <buffer> <space>E :python debugger.eval_under_cursor()<cr>
nnoremap <buffer> <space>C :python debugger.get_context()<cr>

" start and connect in left/right window - <space>dl/dj ------------------- {{{2
nnoremap <buffer> <space>dl :w<cr>:cd %:h<cr>:let g:VimuxOrientation="h"<cr>:let g:VimuxHeight="30"<cr>:call RunVimTmuxCommand("sleep 1 && python -S ~/.vim/bin/Komodo-pythonremotedebugging/bin/pydbgp -d localhost:9000 %")<cr>:python debugger.run()<cr>
nnoremap <buffer> <space>dj :w<cr>:cd %:h<cr>:let g:VimuxOrientation="v"<cr>:let g:VimuxHeight="10"<cr>:call RunVimTmuxCommand("sleep 1 && python -S ~/.vim/bin/Komodo-pythonremotedebugging/bin/pydbgp -d localhost:9000 %")<cr>:python debugger.run()<cr>

" space-B sets/unsets breakpoints, window/conditional/etc -------------- {{{2
nnoremap <buffer> <space>B :Breakpoint<cr>
nnoremap <buffer> <space>bb :BreakpointWindow<cr>
nnoremap <buffer> <space>bc :Breakpoint conditional 
nnoremap <buffer> <space>be :Breakpoint exception 
nnoremap <buffer> <space>bf :Breakpoint call 
nnoremap <buffer> <space>bF :Breakpoint return 
nnoremap <buffer> <space>br :BreakpointRemove *<cr>

" COMMANDS """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
" Python-mode motions -------------------------------------------------- {{{2
fun! PymodeMotionMove(pattern, flags, ...)
    let cnt = v:count1 - 1
    let [line, column] = searchpos(a:pattern, a:flags . 'sW')
    let indent = indent(line)
    while cnt && line
        let [line, column] = searchpos(a:pattern, a:flags . 'W')
        if indent(line) == indent
            let cnt = cnt - 1
        endif
    endwhile
    return [line, column]
endfunction

fun! PymodeMotionVmove(pattern, flags) range
    call cursor(a:lastline, 0)
    let end = PymodeMotionMove(a:pattern, a:flags)
    call cursor(a:firstline, 0)
    normal! v
    call cursor(end)
endfunction

fun! PymodeMotionPos_le(pos1, pos2)
    return ((a:pos1[0] < a:pos2[0]) || (a:pos1[0] == a:pos2[0] && a:pos1[1] <= a:pos2[1]))
endfunction

fun! PymodeMotionSelect(pattern, inner)
    let cnt = v:count1 - 1
    let orig = getpos('.')[1:2]
    let snum = PymodeBlockStart(orig[0], a:pattern)
    if getline(snum) !~ a:pattern
        return 0
    endif
    let enum = PymodeBlockEnd(snum, indent(snum))
    while cnt
        let lnum = search(a:pattern, 'nW')
        if lnum
            let enum = PymodeBlockEnd(lnum, indent(lnum))
            call cursor(enum, 1)
        endif
        let cnt = cnt - 1
    endwhile
    if PymodeMotionPos_le([snum, 0], orig) && PymodeMotionPos_le(orig, [enum, 1])
        if a:inner
            let snum = snum + 1
            let enum = prevnonblank(enum)
        endif

        call cursor(snum, 1)
        normal! v
        call cursor(enum, len(getline(enum)))
    endif
endfunction

fun! PymodeBlockStart(lnum, ...)
    let pattern = a:0 ? a:1 : '^\s*\(@\|class\s.*:\|def\s\)'
    let lnum = a:lnum + 1
    let indent = 100
    while lnum
        let lnum = prevnonblank(lnum - 1)
        let test = indent(lnum)
        let line = getline(lnum)
        if line =~ '^\s*#' " Skip comments
            continue
        elseif !test " Zero-level regular line
            return lnum
        elseif test >= indent " Skip deeper or equal lines
            continue
        " Indent is strictly less at this point: check for def/class
        elseif line =~ pattern && line !~ '^\s*@'
            return lnum
        endif
        let indent = indent(lnum)
    endwhile
    return 0
endfunction

fun! PymodeBlockEnd(lnum, ...)
    let indent = a:0 ? a:1 : indent(a:lnum)
    let lnum = a:lnum
    while lnum
        let lnum = nextnonblank(lnum + 1)
        if getline(lnum) =~ '^\s*#' | continue
        elseif lnum && indent(lnum) <= indent
            return lnum - 1
        endif
    endwhile
    return line('$')
endfunction

" Python-mode folding functions ---------------------------------------- {{{2
let s:blank_regex = '^\s*$'
let s:def_regex = '^\s*\(class\|def\) \w\+'
fun! PymodeFoldingText()
    let fs = v:foldstart
    while getline(fs) =~ '^\s*@' 
        let fs = nextnonblank(fs + 1)
    endwhile
    let line = getline(fs)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart
    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')
    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction


fun! PymodeFoldingExpr(lnum)
    let line = getline(a:lnum)
    let indent = indent(a:lnum)
    if line =~ s:def_regex
        return ">".(indent / &shiftwidth + 1)
    endif
    if line =~ '^\s*@'
        return -1
    endif
    if line =~ s:blank_regex
        let prev_line = getline(a:lnum - 1)
        if prev_line =~ s:blank_regex
            return -1
        else
            return foldlevel(prevnonblank(a:lnum))
        endif
    endif
    if indent == 0
        return 0
    endif
    return '='
endfunction

"{{{1 vim:fdm=marker:fdl=0
