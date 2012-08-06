" debug regions for DEBUG, if (DEBUG) ... ;, and if (DEBUG) { ... }
" highlight groups defined in after/ftplugin/c.vim
syn keyword cDebugWord DEBUG
syn region cDebugRegion1 start=/^\s*if (DEBUG)/ end=/;/
syn region cDebugRegion2 start="^\s*if (DEBUG)\_s*{" end=";\_s*}"
