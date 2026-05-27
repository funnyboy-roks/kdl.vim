" Vim syntax file
" Language: KDL
" Maintainer: Aram Drevekenin
" Latest Revision: 29 September 2022
"
syn match kdlNode '\v(\w|-|\=)' display
syn match kdlBool '#true\|#false' display
syn match kdlNull '#null' display

syn keyword kdlTodo contained TODO FIXME XXX NOTE
syn match kdlComment "//.*$" contains=kdlTodo

" Binary/Octal/Hex integers: 0b/0o/0x, followed by digit, followed by digit or _
syn match kdlNumber '[-+]\?0b[01][01_]*'    contained display
syn match kdlNumber '[-+]\?0o\o\%(\o\|_\)*' contained display
syn match kdlNumber '[-+]\?0x\x\%(\x\|_\)*' contained display

" Keyword number #inf, #-inf, #nan
syn match kdlNumber '#\%(-\?inf\|nan\)' contained display

" Floating point numbers (containing '.' and/or 'E'/'e')
syn match kdlNumber '[-+]\?\d[[:digit:]_]*\%(\.\d[[:digit:]_]*\)\?\%([eE][-+]\?\d[[:digit:]_]*\)' contained display

syn region kdlString start='"' end='"' skip='\\\\\|\\"' display
 
syn region kdlChildren start="{" end="}" contains=kdlString,kdlNumber,kdlNode,kdlBool,kdlNull,kdlComment

let b:current_syntax = "kdl"

hi def link kdlTodo        Todo
hi def link kdlComment     Comment
hi def link kdlNode        Statement
hi def link kdlBool        Boolean
hi def link kdlNull        Constant
hi def link kdlString      String
hi def link kdlNumber      Number
