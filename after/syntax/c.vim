" highlight groups defined in after/ftplugin/c.vim

" debug regions for DEBUG, if (DEBUG) ... ;, and if (DEBUG) { ... }
syn keyword cDebugWord DEBUG
syn region cDebugRegion1 start=/^\s*if (DEBUG)/ end=/;/
syn region cDebugRegion2 start="^\s*if (DEBUG)\_s*{" end=";\_s*}"

" assignments in if/while parentheses
syn match cAssignInConditionBad  '\(\s*if\_s*([^=!<>]*\)\@<==[^=][^,)]*'
syn match cAssignInConditionRare '\(\s*while\_s*([^=!<>]*\)\@<==[^=][^,)]*'

