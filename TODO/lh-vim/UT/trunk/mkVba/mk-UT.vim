"=============================================================================
" $Id: mk-UT.vim 505 2012-03-01 18:55:44Z luc.hermitte $
" File:		mk-UT.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:	0.0.4
let s:version = '0.0.4'
" Created:	19th Feb 2009
" Last Update:	$Date: 2012-03-01 13:55:44 -0500 (Thu, 01 Mar 2012) $
"------------------------------------------------------------------------
cd <sfile>:p:h
try 
  let save_rtp = &rtp
  let &rtp = expand('<sfile>:p:h:h').','.&rtp
  exe '22,$MkVimball! UT-'.s:version
  set modifiable
  set buftype=
finally
  let &rtp = save_rtp
endtry
finish
UT-addon-info.txt
UT.README
autoload/lh/UT.vim
autoload/should.vim
autoload/should/be.vim
doc/UT.txt
ftplugin/vim/vim_UT.vim
mkVba/mk-UT.vim
plugin/UT.vim
tests/lh/UT-fixtures.vim
tests/lh/UT.vim
tests/lh/assert.vim