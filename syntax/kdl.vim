" Vim syntax file
" Language: KDL
" Maintainer: Aram Drevekenin
" Latest Revision: 29 September 2022
"
syn match kdlNode "\%([^-+.(){}\[\]/\"#;=[:digit:][:space:]]\|[-+.][^(){}\[\]/\"#;=[:space:][:digit:]]\)\%([^(){}\[\]/\"#;=[:space:]]\)*" display
syn match kdlBool '#true\|#false' display
syn match kdlNull '#null' display

" Inline comments with //
syn keyword kdlTodo contained TODO FIXME XXX NOTE
syn match kdlComment "//.*$" contains=kdlTodo

" Block comments with /* */ (supporting nesting)
syn region kdlCommentBlock     matchgroup=kdlCommentBlock start="/\*" end="\*/" contains=kdlTodo,kdlCommentBlockNest,@Spell
syn region kdlCommentBlockNest matchgroup=kdlCommentBlock start="/\*" end="\*/" contains=kdlTodo,kdlCommentBlockNest,@Spell contained transparent

" Binary/Octal/Hex integers: 0b/0o/0x, followed by digit, followed by digit or _
syn match kdlNumber '[-+]\?0b[01][01_]*'    contained display
syn match kdlNumber '[-+]\?0o\o\%(\o\|_\)*' contained display
syn match kdlNumber '[-+]\?0x\x\%(\x\|_\)*' contained display

" Keyword number #inf, #-inf, #nan
syn match kdlNumber '#\%(-\?inf\|nan\)' contained display

" Floating point numbers (containing '.' and/or 'E'/'e')
syn match kdlNumber '[-+]\?\d[[:digit:]_]*\%(\.\d[[:digit:]_]*\)\?\%([eE][-+]\?\d[[:digit:]_]*\)\?' contained display

" Try to error for invalid escape sequence (\<invalid character>, \u{not 1-6 chars}, \u{<non hex char>})
syn match  kdlEscapeError    '\\u{\%([^}]*[^[:xdigit:]}][^}]*\|[^}]\{7,}\)\?}\|\\.' contained display
" Valid escape codes (\<valid escpae char>, \u{<1-6 hex>})
syn match  kdlEscape '\\["nrt\\bfs[:space:]]\|\\u{\x\{1,6}}' contained display
syn region kdlString start='"'           end='"'      skip='\\\\\|\\"'           display contains=kdlEscape,kdlEscapeError,@Spell
syn region kdlString start='"""'         end='"""'    skip='\\\\\|\%(""\?[^"]\)' display contains=kdlEscape,kdlEscapeError,@Spell
syn region kdlString start='\z(#\+\)"'   end='"\z1'                              display contains=@Spell
syn region kdlString start='\z(#\+\)"""' end='"""\z1'                            display contains=@Spell
 
syn region kdlChildren start="{" end="}" contains=kdlString,kdlNumber,kdlNode,kdlBool,kdlNull,kdlComment,kdlCommentBlock

let b:current_syntax = "kdl"

hi def link kdlTodo        Todo
hi def link kdlComment     Comment
hi def link kdlCommentBlock kdlComment
hi def link kdlNode        Statement
hi def link kdlBool        Boolean
hi def link kdlNull         Constant
hi def link kdlEscape      Special
hi def link kdlEscapeError Error
hi def link kdlString      String
hi def link kdlNumber      Number
