setlocal formatoptions+=a         " test out automatic paragraph formatting
setlocal formatoptions+=n         " recognize numbered lists
setlocal nonumber                 " don't need line numbering
setlocal spell spelllang=en_us    " turn on spellcheck
setlocal spellfile="~/.vim/spell.en_us.add"

" remap { and } brackets to be useful for mail
" travels to empty lines (possibly beginning with >)
map <buffer> { :call MailBracket(1)<cr>
map <buffer> } :call MailBracket(0)<cr>
function! MailBracket(rev)
    if (a:rev != 1)
        /^\(>\s*\)*$
    else
        ?^\(>\s*\)*$
    endif
    nohl
endfunction

" automatically go into insert mode
if !match(getline(1), "On")
    " email is a reply, insert two spaces and insert
    normal! OO
endif
setlocal im!
imap <buffer> <esc> <c-l>
