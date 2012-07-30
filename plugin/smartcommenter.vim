" SmartCommenter:
"   Author:  Ben Schmidt and A. S. Budden <abudden _at_ gmail _dot_ com>
"   Date:    24 July 2008
"   Version: 1
" Copyright: Copyright (C) 2008 Ben Schmidt and A. S. Budden
"            Permission is hereby granted to use and distribute this code,
"            with or without modifications, provided that this copyright
"            notice is copied with it. Like anything else that's free,
"            smartcommenter.vim is provided *as is* and comes with no
"            warranty of any kind, either expressed or implied. By using
"            this plugin, you agree that in no event will the copyright
"            holder be liable for any damages resulting from the use
"            of this software.

" ---------------------------------------------------------------------
if &cp || exists("g:loaded_SmartMatchCommenter")
	finish
endif
let g:loaded_SmartMatchCommenter= "v1"

amenu <silent> &Plugin.&Commenter.Add\ Preprocessor\ Comments :SmartPreProcCommenter<CR>
amenu <silent> &Plugin.&Commenter.Add\ Brace\ Comments :SmartBraceCommenter<CR>

" Comments on preprocessor directives
command! SmartPreProcCommenter call SmartPreProcCommenter()
command! SmartBraceCommenter call SmartBraceCommenter()

" Commenting of #endifs etc
function! SmartPreProcCommenter()
	let saved_view = winsaveview()
	let saved_wrapscan=&wrapscan
	set nowrapscan
	let elsecomment=""
	let endcomment=""
	try
		" Find the last #if in the buffer
		$?^\s*#if
		while 1
			" Build the comments for later use, based on current line
			let content=getline('.')
			let elsecomment=BuildElsePreProcComment(content,elsecomment)
			let endcomment=BuildEndPreProcComment(content,endcomment)
			" Change # into ## so we know we've already processed this one
			" and don't find it again
			s/^\s*\zs#/##
			" Find the next #else, #elif, #endif which must belong to this #if
			/^\s*#\(elif\|else\|endif\)
			let content=getline('.')
			if match(content,'^\s*#elif') != -1
				" For #elif, treat the same as #if, i.e. build new comments
				continue
			elseif match(content,'^\s*#else') != -1
				" For #else, add/replace the comment
				call setline('.',ReplacePreProcComment(content,elsecomment))
				s/^\s*\zs#/##
				" Find the #endif
				/^\s*#endif
			endif
			" We should be at the #endif now; add/replace the comment
			call setline('.',ReplacePreProcComment(getline('.'),endcomment))
			s/^\s*\zs#/##
			" Find the previous #if
			?^\s*#if
		endwhile
	catch /search hit TOP/
		" Once we have an error (pattern not found, i.e. no more left)
		" Change all our ## markers back to #
		silent! %s/^\s*\zs##/#
	endtry
	let &wrapscan=saved_wrapscan
	call winrestview(saved_view)
endfunc

let s:PreProcCommentMatcher = '#\a\+\s\+\zs.\{-}\ze\(\s*\/\*.\{-}\*\/\)\?\s*$'

function! BuildElsePreProcComment(content,previous)
	let expression=escape(matchstr(a:content,s:PreProcCommentMatcher), '\~&')
	if match(a:content,'#ifdef') != -1
        return "/* END NOT #ifdef ".expression." */"
	elseif match(a:content,'#ifndef') != -1
        return "/* END #ifndef ".expression." */"
	elseif match(a:content,'#if') != -1
        return "/* END NOT ".expression." */"
	elseif match(a:content,'#elif') != -1
		return substitute(a:previous,' \*/',', '.expression.' */','')
	else
		return ""
	endif
endfunc

function! BuildEndPreProcComment(content,previous)
	let expression=escape(matchstr(a:content,s:PreProcCommentMatcher), '\~&')
	if match(a:content,'#ifdef') != -1
        return "/* END #ifdef ".expression." */"
	elseif match(a:content,'#ifndef') != -1
        return "/* END #ifndef ".expression." */"
	elseif match(a:content,'#if') != -1
        return "/* END ".expression." */"
	elseif match(a:content,'#elif') != -1
		return substitute(a:previous,' \*/',', '.expression.' */','')
	else
		return ""
	endif
endfunc

function! ReplacePreProcComment(content,comment)
	let existing=escape(matchstr(a:content,'#\a\+\s\+\zs.\{-}\s*$'), '\~&')
	if existing == ""
		return substitute(a:content,'^\s*#\a\+\zs.*'," ".a:comment,'')
	elseif existing != a:comment && match(existing,'XXX') == -1
		return a:content." /* XXX */"
	else
		return a:content
	endif
endfunc

let s:OneLineCommentMatcher = '^\s*\/\*.\{-}\*\/\s*$'
let s:EndMultiLineCommentMatcher = '^.*\*\/'
let s:StartMultiLineCommentMatcher = '\/\*.*$'

" Commenting of braces
function! SmartBraceCommenter()
	let saved_view = winsaveview()
	let saved_wrapscan=&wrapscan
	set nowrapscan
	let elsecomment=""
	let endcomment=""
	try
		" Find the last brace in the buffer
		$?^\s*{\s*$
		while 1
			let skip_this_brace_set = 0

			" Build the comments for later use, based on current line
			let backCount = 1
			let content=getline(line('.') - backCount)
			" Skip back over single-line comments
			while match(content, s:OneLineCommentMatcher) != -1
				let backCount = backCount + 1
				let content=getline(line('.') - backCount)
			endwhile
			" Skip back over multi-line comments
			if match(content, s:EndMultiLineCommentMatcher) != -1
				let backCount = backCount + 1
				let content=getline(line('.') - backCount)
				while match(content, s:StartMultiLineCommentMatcher) == -1
					let backCount = backCount + 1
					let content = getline(line('.') - backCount)
				endwhile
			endif
			" Go back to the line with the opening brace
			while match(content, s:BraceCommentMatcher) == -1
				if match(content, '\s*[{}]') != -1
					" This is a nested brace, skip
					let skip_this_brace_set = 1
					break
				endif
				let backCount = backCount + 1
				let content=getline(line('.') - backCount)
			endwhile

			if skip_this_brace_set != 1
				let endcomment=BuildEndBraceComment(content,endcomment)
			endif

			" Change { into ##{ so we know we've already processed this one
			" and don't find it again
			s/^\s*\zs{/##{
			" Find the next closing brace which must belong to this opener
			/^\s*}
			let content=getline('.')

			if skip_this_brace_set != 1
				call setline('.',ReplaceBraceComment(content,endcomment))
			endif

			s/^\s*\zs}/##}
			" Find the previous opening brace
			?^\s*{\s*$
		endwhile
	catch /search hit TOP/
		" Once we have an error (pattern not found, i.e. no more left)
		" Change all our ## markers back to #
		silent! %s/^\s*\zs##\ze[{}]//
	endtry
	let &wrapscan=saved_wrapscan
	call winrestview(saved_view)
endfunc

" This matcher produces a simple match that holds the brace
" comment, so for 'else if (xyz)', it returns 'else if', for
" 'void main(int argc, char **argv)', it returns 'main', for
" 'static const u8 au8BigArray[LOTS] =', it returns 'au8BigArray',
" etc...
let s:BCM  = '^'                    " Start of line
let s:BCM .= '[A-Za-z_0-9\t *]\{-}' " This gets rid of leading rubbish
let s:BCM .= '\('                   " Start OPTION groups

let s:BCM .= '\zs'                  " Start of the real match
let s:BCM .= '\<else\s\+if\ze\s*('  " Option: else if (

let s:BCM .= '\|'                   " Next OPTION: functions

let s:BCM .= '\zs'                  " Start of the real match
let s:BCM .= '\<\w\+\ze\s*('        " Option: e.g. functions, if, switch etc

let s:BCM .= '\|'                   " Next OPTION: enums
let s:BCM .= '\zs'                  " Start of the real match
let s:BCM .= '\%('                  " Specific keywords
let s:BCM .= '\<enum\>'             " Option: enum
let s:BCM .= '\|'                   " Other keywords:
let s:BCM .= '\<struct\>'           " Option: struct
let s:BCM .= '\)'                   " End of keywords

let s:BCM .= '\|'                   " Next OPTION: else

let s:BCM .= '\zs'                  " Start of the real match
let s:BCM .= '\<else\>'             " Option: else

let s:BCM .= '\|'                   " Next OPTION: arrays ('const u8 array[xyz] =')

let s:BCM .= '.* '                  " Soak up everything up to the last space
let s:BCM .= '\zs'                  " Start of the real match
let s:BCM .= '\S\{-1,}'             " Get all the non-space characters
let s:BCM .= '\[\ze'                " Catch the opening '['
let s:BCM .= '\w\+\]'               " This checks for the rest of the [] set
let s:BCM .= '\%(\[\w\+\]\)*'       " Soak up any extra [] groups
let s:BCM .= '\s*='               " Soak up everything up to and inc. the =

let s:BCM .= '\|'                   " Next OPTION: Uncaptured arrays

let s:BCM .= '.\{-}'                " Soak up the start
let s:BCM .= '\[\w\+\]'             " Check for the [] set
let s:BCM .= '\s*'                  " Soak up any spaces
let s:BCM .= '\zs='                 " Just capture the '=' (this is skipped)
let s:BCM .= '\)'                   " End OPTION groups

" Give it a meaningful name
let s:BraceCommentMatcher = s:BCM

let s:NonFunctionBraceParts = ['if', 'else', 'else if', 'switch', 'while', 'do', 'for']
let s:OmitCommentsFor = ['enum', '=', 'struct']

function! BuildEndBraceComment(content,previous)
	let expression=escape(matchstr(a:content,s:BraceCommentMatcher), '\~&')
	" Get rid of any extra spaces in an 'else if'
	if match(expression, '^else\s\+if$') != -1
        let expression = 'else if'
	endif
	if index(s:OmitCommentsFor, expression) >= 0
		return 'OMIT_COMMENT_HERE'
	endif
	if index(s:NonFunctionBraceParts, expression) < 0
		if expression[len(expression)-1] == "["
			let expression = expression[0:len(expression)-2]
		else
			let expression = expression.'()'
		endif
	endif
    return '/* END '.expression.' */'
endfunc

function! ReplaceBraceComment(content,comment)
	if a:comment == 'OMIT_COMMENT_HERE'
		return a:content
	endif

	let existing=escape(matchstr(a:content,'}.\{-}\zs/\*.\{-}\ze\s*$'), '\~&')
	if existing == ""
		return substitute(a:content,'^\s*}.*\zs'," ".a:comment,'')
	elseif existing != a:comment && match(existing,'XXX') == -1
		return a:content." /* XXX */"
	else
		return a:content
	endif
endfunc
