let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1 
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:DevIconsEnableFoldersOpenClose = 1
"
"" you can add these colors to your .vimrc to help customizing
let s:blue = "689FB6"
let s:git_orange = 'F54D27'
"let s:nix_blue = '6DA2F8'
let s:nix_blue = '5FAFD7'


" Exact matching extensions
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['nix'] = s:nix_blue

let g:NERDTreeExactMatchHighlightColor = {}
let g:NERDTreeExactMatchHighlightColor['flake.lock'] = s:nix_blue


" Pattern matching highlights
let g:NERDTreePatternMatchHighlightColor = {}
let g:NERDTreePatternMatchHighlightColor['.*git.*'] = s:git_orange

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['flake.lock'] = ''

"let g:WebDevIconsDefaultFolderSymbolColor = s:yellow " sets the color for folders that did not match any rule
"let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*git.*'] = '󰊢'
