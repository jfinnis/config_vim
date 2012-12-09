"=============================================================================
" $Id: mk-system_utils.vim 511 2012-03-01 20:25:26Z luc.hermitte $
" File:		mkVba/mk-system_utils.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:	2.1.2
" Created:	06th Nov 2007
" Last Update:	$Date: 2012-03-01 15:25:26 -0500 (Thu, 01 Mar 2012) $
"------------------------------------------------------------------------
let s:version = '2.1.2'
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
system-tools-addon-info.txt
system_tools.README
autoload/lh/system.vim
doc/system_utils.txt
plugin/system_utils.vim
