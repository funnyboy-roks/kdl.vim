" Vim syntax file
" Language: KDL
" Maintainer: Aram Drevekenin
" Latest Revision: 29 September 2022
"
syn match kdlNode "\%([^-+.(){}\[\]/\"#;=[:digit:][:space:]]\|[-+.][^(){}\[\]/\"#;=[:space:][:digit:]]\)\%([^(){}\[\]/\"#;=[:space:]]\)*" display
syn match kdlBool '\v(true|false)' display

syn keyword kdlTodo contained TODO FIXME XXX NOTE
syn match kdlComment "//.*$" contains=kdlTodo

" Regular int like number with - + or nothing in front
syn match kdlNumber '\d\+'
syn match kdlNumber '[-+]\d\+'

" Floating point number with decimal no E or e (+,-)
syn match kdlNumber '\d\+\.\d*' contained display
syn match kdlNumber '[-+]\d\+\.\d*' contained display
 
" Floating point like number with E and no decimal point (+,-)
syn match kdlNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+' contained display
syn match kdlNumber '\d[[:digit:]]*[eE][\-+]\=\d\+' contained display
 
" Floating point like number with E and decimal point (+,-)
syn match kdlNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display
syn match kdlNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display

" Try to error for invalid escape sequence (\<invalid character>, \u{not 1-6 chars}, \u{<non hex char>})
syn match  kdlEscapeError    '\\u{\%([^}]*[^[:xdigit:]}][^}]*\|[^}]\{7,}\)\?}\|\\.' contained display
" Valid escape codes (\<valid escpae char>, \u{<1-6 hex>})
syn match  kdlEscape '\\["nrt\\bfs[:space:]]\|\\u{\x\{1,6}}' contained display
syn region kdlString start='"'           end='"'      skip='\\\\\|\\"'           display contains=kdlEscape,kdlEscapeError,@Spell
syn region kdlString start='"""'         end='"""'    skip='\\\\\|\%(""\?[^"]\)' display contains=kdlEscape,kdlEscapeError,@Spell
syn region kdlString start='\z(#\+\)"'   end='"\z1'                              display contains=@Spell
syn region kdlString start='\z(#\+\)"""' end='"""\z1'                            display contains=@Spell
 
syn region kdlChildren start="{" end="}" contains=kdlString,kdlNumber,kdlNode,kdlBool,kdlComment

let b:current_syntax = "kdl"

hi def link kdlTodo        Todo
hi def link kdlComment     Comment
hi def link kdlNode        Statement
hi def link kdlBool        Boolean
hi def link kdlEscape      Special
hi def link kdlEscapeError Error
hi def link kdlString      String
hi def link kdlNumber      Number
