"=============================================================================
" $Id: mk-lh-vim-lib.vim 6 2008-02-13 01:56:50Z luc.hermitte $
" File:		mk-lh-lib.vim
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://hermitte.free.fr/vim/>
" Version:	2.0.4
" Created:	06th Nov 2007
" Last Update:	$Date: 2008-02-12 20:56:50 -0500 (Tue, 12 Feb 2008) $
"------------------------------------------------------------------------
cd <sfile>:p:h
13,$MkVimball! lh-vim-lib
finish
autoload/lh/askvim.vim
autoload/lh/buffer.vim
autoload/lh/buffer/dialog.vim
autoload/lh/command.vim
autoload/lh/common.vim
autoload/lh/list.vim
autoload/lh/menu.vim
autoload/lh/option.vim
autoload/lh/path.vim
autoload/lh/position.vim
autoload/lh/syntax.vim
doc/lh-vim-lib.txt
macros/menu-map.vim
plugin/ui-functions.vim
plugin/words_tools.vim
tests/lh/test-Fargs2String.vim
tests/lh/test-askmenu.vim
tests/lh/test-command.vim
tests/lh/test-menu-map.vim
tests/lh/test-toggle-menu.vim
