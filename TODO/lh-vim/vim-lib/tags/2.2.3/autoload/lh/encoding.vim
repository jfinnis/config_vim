"=============================================================================
" $Id: encoding.vim 254 2010-12-01 00:03:22Z luc.hermitte $
" File:		autoload/lh/encoding.vim                               {{{1
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://code.google.com/p/lh-vim/>
" Version:	2.2.2
" Created:	21st Feb 2008
" Last Update:	$Date: 2010-11-30 19:03:22 -0500 (Tue, 30 Nov 2010) $
"------------------------------------------------------------------------
" Description:	
" 	Defines functions that help managing various encodings
" 
"------------------------------------------------------------------------
" Installation:	
" 	Drop it into {rtp}/autoload/lh/
" 	Vim 7+ required.
" History:	
" 	v2.2.2:
" 	(*) new mb_strings functions: strlen, strpart, at
" 	v2.0.7:
" 	(*) lh#encoding#Iconv() copied from map-tools
" TODO:		�missing features�
" }}}1
"=============================================================================

let s:cpo_save=&cpo
set cpo&vim
"------------------------------------------------------------------------

" Function: lh#encoding#iconv(expr, from, to)  " {{{3
" Unlike |iconv()|, this wrapper returns {expr} when we know no convertion can
" be acheived.
function! lh#encoding#iconv(expr, from, to)
  " call Dfunc("s:ICONV(".a:expr.','.a:from.','.a:to.')')
  if has('multi_byte') && 
	\ ( has('iconv') || has('iconv/dyn') ||
	\ ((a:from=~'latin1\|utf-8') && (a:to=~'latin1\|utf-8')))
    " call confirm('encoding: '.&enc."\nto:".a:to, "&Ok", 1)
    " call Dret("s:ICONV convert=".iconv(a:expr, a:from, a:to))
    return iconv(a:expr,a:from,a:to)
  else
    " Cannot convert
    " call Dret("s:ICONV  no convert=".a:expr)
    return a:expr
  endif
endfunction


" Function: lh#encoding#at(mb_string, i) " {{{3
" @return i-th character in a mb_string
" @parem mb_string multi-bytes string
" @param i 0-indexed position
function! lh#encoding#at(mb_string, i)
  return matchstr(a:mb_string, '.', 0, a:i+1)
endfunction

" Function: lh#encoding#strpart(mb_string, pos, length) " {{{3
" @return {length} extracted characters from {position} in multi-bytes string.
" @parem mb_string multi-bytes string
" @param p 0-indexed position
" @param l length of the string to extract
function! lh#encoding#strpart(mb_string, p, l)
  return matchstr(a:mb_string, '.\{'.a:l.'}', 0, a:p+1)
endfunction

" Function: lh#encoding#strlen(mb_string) " {{{3
" @return the length of the multi-bytes string.
function! lh#encoding#strlen(mb_string)
  return strlen(substitute(a:mb_string, '.', 'a', 'g'))
endfunction
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
