" place in insert mode automatically for commits
"if match(getline(2), "commit message") >= 0
    "setlocal im!
    "imap <buffer> <esc> <c-l>
"endif
