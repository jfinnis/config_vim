"=============================================================================
" $Id: mk-system_utils.vim 335 2011-01-06 02:25:06Z luc.hermitte $
" File:		mkVba/mk-system_utils.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:	2.1.1
" Created:	06th Nov 2007
" Last Update:	$Date: 2011-01-05 21:25:06 -0500 (Wed, 05 Jan 2011) $
"------------------------------------------------------------------------
let s:version = '2.1.1'
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
system_tools.README
autoload/lh/system.vim
doc/system_utils.txt
plugin/system_utils.vim
