"=============================================================================
" $Id: mk-SiR.vim 176 2010-05-17 00:45:43Z luc.hermitte $
" File:		mk-SiR.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://hermitte.free.fr/vim/>
" Version:	2.1.8
let s:version = '2.1.8'
" Created:	06th Nov 2007
" Last Update:	$Date: 2010-05-16 20:45:43 -0400 (Sun, 16 May 2010) $
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
