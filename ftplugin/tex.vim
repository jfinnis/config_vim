set textwidth=80   " wrap at 80 chars
"set textwidth=0    " do not hardwrap lines
set wrap linebreak " but do softwrap lines
set iskeyword+=:   " <C-n> autocompletes labels when written
                   " as \label{fig:something}
set winaltkeys=no  " disable default vim mapping for latex-suite macros
set shiftwidth=2
set autoindent

" insert template from latex-suite/template
map <Leader>tt :TTemplate<CR>

" map pdflatex command
 map <Leader>lc :!pdflatex %<CR>
