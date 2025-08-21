" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

setlocal commentstring=;;%s

syntax region kbdFunctionCall start="(" end=")" contains=kbdKeyword,kbdNumber,kbdFunctionName
highlight link kbdFunctionCall Delimiteer

syntax match kbdFunctionName "(\zs[a-zA-Z][a-zA-Z\-0-9]\+" contained
highlight link kbdFunctionName Identifier

syntax match kbdKeyword defcfg contained
syntax match kbdKeyword defsrc contained
syntax match kbdKeyword deflayer contained
syntax match kbdKeyword defalias contained
highlight link kbdKeyword Keyword

syntax match kbdNumber "\<-\?[0-9]\+\>" contained
syntax match kbdNumber "\<-\?0x[0-9a-fA-F]\+\>" contained
highlight link kbdNumber Number

syntax match kbdComment ";;.*" contains=kbdTodo
highlight link kbdComment Comment

syntax keyword kbdTodo MARK TODO FIXME contained
highlight def link kbdTodo Todo

let b:current_syntax = "kbd"
