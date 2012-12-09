"=============================================================================
" $Id: ruby_brackets.vim 264 2010-12-01 00:20:46Z luc.hermitte $
" File:         ftplugin/ruby_brackets.vim                        {{{1
" Author:       Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:      1.1.0
" Created:      17th Jun 2010
" Last Update:  $Date: 2010-11-30 19:20:46 -0500 (Tue, 30 Nov 2010) $
"------------------------------------------------------------------------
" Description:
"       �description�
" 
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/ftplugin
"       Requires Vim7+
"       �install details�
" History:      �history�
" TODO:         �missing features�
" }}}1
"=============================================================================

let s:k_version = 110
" Buffer-local Definitions {{{1
" Avoid local reinclusion {{{2
if &cp || (exists("b:loaded_ftplug_ruby_brackets")
      \ && (b:loaded_ftplug_ruby_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_ruby_brackets'))
  finish
endif
let b:loaded_ftplug_ruby_brackets = s:k_version
let s:cpo_save=&cpo
set cpo&vim
" Avoid local reinclusion }}}2

"------------------------------------------------------------------------
" Local mappings {{{2

" Replaces begin-end block by {-}, or the other way around
nnoremap <buffer> <c-x>{ :call <sid>ToggleBeginOrBracket()<cr>

"------------------------------------------------------------------------
" Local commands {{{2


"=============================================================================
" Global Definitions {{{1
" Avoid global reinclusion {{{2
if &cp || (exists("g:loaded_ftplug_ruby_brackets")
      \ && (g:loaded_ftplug_ruby_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_ruby_brackets'))
  let &cpo=s:cpo_save
  finish
endif
let g:loaded_ftplug_ruby_brackets = s:k_version
" Avoid global reinclusion }}}2
"------------------------------------------------------------------------
" Functions {{{2
" Note: most filetype-global functions are best placed into
" autoload/�your-initials�/ruby/�ruby_brackets�.vim
" Keep here only the functions are are required when the ftplugin is
" loaded, like functions that help building a vim-menu for this
" ftplugin.

let s:k_be = [ 'begin', 'end' ]
function! s:ToggleBeginOrBracket()
  let c = lh#position#char_at_mark('.')
  if c =~ '[{}]'
    " don't use matchit for {,}
    exe 'normal! %s'.s:k_be[1-(c=='}')]."\<esc>``s".s:k_be[(c=='}')]."\<esc>"
  else
    let w = expand('<cword>')
    if w == 'begin'
      " use mathit
      normal %
      exe "normal! ciw}\<esc>``ciw{\<esc>"
    elseif w != 'end'
      " use mathit
      normal %
      exe "normal! ciw{\<esc>``ciw}\<esc>"
    else
      throw 'Cannot toggle block: cursor is not on {, }, begin, nor end'
    endif
  endif
endfunction

" Functions }}}2
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker: