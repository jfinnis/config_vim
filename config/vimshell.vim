""""""""""""""""""""""""""""""""""""""""
"" VimShell settings
""""""""""""""""""""""""""""""""""""""""

" execute file list
let g:VimShell_ExecuteFileList = {}
let g:VimShell_ExecuteFileList['rb'] = 'ruby'
let g:VimShell_ExecuteFileList['pl'] = 'perl'
let g:VimShell_ExecuteFileList['py'] = 'python'

" set the prompt to username.cwd
let g:VimShell_Prompt = $USER.$PWD."% "

" ;T will switch to a vimshell window
map <Leader>T <Plug>(vimshell_switch)

" use ;! to interactively execute a command
nnoremap <Leader>! :<C-u>VimShellInteractive<Space>

" use & to run a command in the background
nnoremap & :<C-u>VimShellExecute<Space>
