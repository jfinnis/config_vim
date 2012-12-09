"=============================================================================
" $Id: mk-lh-map-tools.vim 316 2010-12-10 00:22:11Z luc.hermitte $
" File:		mk-lh-map-tools.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"               <URL:http://code.google.com/p/lh-vim/>
" Version:	1.1.1
let s:version = '1.1.1'
" Created:	06th Nov 2007
" Last Update:	$Date: 2010-12-09 19:22:11 -0500 (Thu, 09 Dec 2010) $
"------------------------------------------------------------------------
cd <sfile>:p:h
try 
  let save_rtp = &rtp
  let &rtp = expand('<sfile>:p:h:h').','.&rtp
  exe '22,$MkVimball! lh-map-tools-'.s:version
  set modifiable
  set buftype=
finally
  let &rtp = save_rtp
endtry
finish
after/ftplugin/c/c_brackets.vim
after/ftplugin/html/html_brackets.vim
after/ftplugin/javascript_brackets.vim
after/ftplugin/perl/perl_brackets.vim
after/ftplugin/tex/tex_brackets.vim
after/ftplugin/vim/vim_brackets.vim
autoload/lh/brackets.vim
autoload/lh/cpp/brackets.vim
autoload/lh/html/brackets.vim
autoload/lh/vim/brackets.vim
doc/lh-map-tools.txt
lh-map-tools.Changelog
lh-map-tools.README
mkVba/mk-lh-map-tools.vim
plugin/bracketing.base.vim
plugin/common_brackets.vim
plugin/misc_map.vim
