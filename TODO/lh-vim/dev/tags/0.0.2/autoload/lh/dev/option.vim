"=============================================================================
" $Id: option.vim 347 2011-01-06 03:07:55Z luc.hermitte $
" File:		autoload/lh/dev/option.vim                        {{{1
" Author:	Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>
"		<URL:http://hermitte.free.fr/vim/>
" Version:	0.0.1
" Created:	05th Oct 2009
" Last Update:	$Date: 2011-01-05 22:07:55 -0500 (Wed, 05 Jan 2011) $
"------------------------------------------------------------------------
" Description:	«description»
" 
"------------------------------------------------------------------------
" Installation:	«install details»
" History:	«history»
" TODO:		«missing features»
" }}}1
"=============================================================================

let s:cpo_save=&cpo
set cpo&vim
"------------------------------------------------------------------------

" ## Misc Functions     {{{1
" # Version {{{2
let s:k_version = 001
function! lh#dev#option#version()
  return s:k_version
endfunction

" # Debug {{{2
function! lh#dev#option#verbose(level)
  let s:verbose = a:level
endfunction

function! s:Verbose(expr)
  if exists('s:verbose') && s:verbose
    echomsg a:expr
  endif
endfunction

function! lh#dev#option#debug(expr)
  return eval(a:expr)
endfunction

"------------------------------------------------------------------------
" ## Exported functions {{{1

" Function: lh#dev#option#get(name, filetype, default [, scope])  {{{2
" @return b:{name} if it exists, or g:{name} if it exists, or {default}
" otherwise
" The order of the variables checked can be specified through the optional
" argument {scope}
function! lh#dev#option#get(name, ft, default,...)
  let fts = [a:ft] + s:InheritedFiletypes(a:ft)
  call map(fts, 'v:val."_"')
  let fts += [ '']
  let scope = (a:0 == 1) ? a:1 : 'bg'
  let name = a:name
  for ft in fts
    let i = 0
    while i != strlen(scope)
      if exists(scope[i].':'.ft.name)
	return {scope[i]}:{ft}{name}
      endif
      let i += 1
    endwhile 
  endfor
  return a:default
endfunction

" Function: lh#dev#option#call(name, filetype, [, parameters])  {{{2
" @return lh#dev#{ft}#{name}({parameters}) if it exists, or
" lh#dev#{name}({parameters}) otherwise
" If {name} is a |List|, then the function name used is: {name}[0]#{ft}#{name}[1]
function! lh#dev#option#call(name, ft, ...)
  if type(a:name) == type([])
    let prefix = a:name[0]
    let name   = a:name[1]
  elseif type(a:name) == type('string')
    let prefix = 'lh#dev'
    let name   = a:name
  else
    throw "Unexpected type (".type(a:name).") for name parameter"
  endif

  let fts = [a:ft] + s:InheritedFiletypes(a:ft)
  call map(fts, 'v:val."#"')
  let fts += ['']
  for ft in fts
    let fname = prefix.'#'.ft.name
    if !exists('*'.fname)
      let file = substitute(fname, '#', '/', 'g')
      let file = substitute(file, '.*\zs/.*', '.vim', '')
      exe 'runtime autoload/'.file
    endif
    if exists('*'.fname) | break | endif
  endfor

  return call (function(fname), a:000)
endfunction

"------------------------------------------------------------------------
" ## Internal functions {{{1

" # List of inherited properties between languages {{{2
" - todo, this may required to be specific to each property considered
function! s:InheritedFiletypes(fts)
  let res = []
  let lFts = split(a:fts, ',')
  for ft in lFts
    let parents = lh#option#get(ft.'_inherits', '')
    let res += [ft] + s:InheritedFiletypes(parents)
  endfor
  return res
endfunction

LetIfUndef g:cpp_inherits 'c'


let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
