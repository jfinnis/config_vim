"=============================================================================
" $Id: mk-SiR.vim 288 2010-12-06 23:44:29Z luc.hermitte $
" File:		mk-SiR.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://hermitte.free.fr/vim/>
" Version:	2.1.9
let s:version = '2.1.9'
" Created:	06th Nov 2007
" Last Update:	$Date: 2010-12-06 18:44:29 -0500 (Mon, 06 Dec 2010) $
"------------------------------------------------------------------------
cd <sfile>:p:h
try 
  let save_rtp = &rtp
  let &rtp = expand('<sfile>:p:h:h').','.&rtp
  exe '22,$MkVimball! searchInRuntime-'.s:version
  set modifiable
  set buftype=
finally
  let &rtp = save_rtp
endtry
finish
doc/searchInRuntime.txt
plugin/searchInRuntime.vim
