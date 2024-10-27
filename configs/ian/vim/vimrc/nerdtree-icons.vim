let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1 
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
"
"" you can add these colors to your .vimrc to help customizing
let s:blue = "689FB6"
""let s:nixblue = '9ec1fa'
let s:nixblue = '6da2f8'
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['nix'] = s:nixblue
let g:NERDTreeExactMatchHighlightColor = {}
let g:NERDTreeExactMatchHighlightColor['flake.lock'] = s:nixblue

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['flake.lock'] = ''
"
"let g:WebDevIconsDefaultFolderSymbolColor = s:yellow " sets the color for folders that did not match any rule
"let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule
