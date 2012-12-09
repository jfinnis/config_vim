"=============================================================================
" $Id: mk-system_utils.vim 227 2010-05-23 03:19:39Z luc.hermitte $
" File:		mkVba/mk-system_utils.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:	2.1.0
" Created:	06th Nov 2007
" Last Update:	$Date: 2010-05-22 23:19:39 -0400 (Sat, 22 May 2010) $
"------------------------------------------------------------------------
let s:version = '2.1.0'
let s:project = 'system_tools'
cd <sfile>:p:h
try 
  let save_rtp = &rtp
  let &rtp = expand('<sfile>:p:h:h').','.&rtp
  exe '23,$MkVimball! '.s:project.'-'.s:version
  set modifiable
  set buftype=
finally
  let &rtp = save_rtp
endtry
finish
autoload/lh/system.vim
doc/system_utils.txt
plugin/system_utils.vim
