"=============================================================================
" $Id: mk-SiR.vim 28 2008-02-15 00:19:33Z luc.hermitte $
" File:		mk-SiR.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://hermitte.free.fr/vim/>
" Version:	2.1.6
" Created:	06th Nov 2007
" Last Update:	$Date: 2008-02-14 19:19:33 -0500 (Thu, 14 Feb 2008) $
"------------------------------------------------------------------------
cd <sfile>:p:h
15,$MkVimball! searchInRuntime
set modifiable
set buftype=
finish
doc/searchInRuntime.txt
plugin/searchInRuntime.vim
