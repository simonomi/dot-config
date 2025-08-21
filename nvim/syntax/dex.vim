" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

syntax case ignore
setlocal iskeyword+=:
setlocal commentstring=//%s

syntax match dexDefault ".*" contains=dexArgument,dexUnknown
highlight link dexDefault Keyword

syntax region dexArgument start="<" end=">" contains=dexKeyword,dexNumber
highlight link dexArgument Structure

syntax match dexNumber "\<-\?[0-9]\+\>" contained
syntax match dexNumber "\<-\?0x[0-9a-fA-F]\+\>" contained
highlight link dexNumber Number

syntax keyword dexUnknown unknown: unknowns:
highlight link dexUnknown Special

syntax match dexComment "//.*" contains=dexTodo
highlight link dexComment Comment

syntax match dexTodo "MARK\ze:" contained
syntax match dexTodo "TODO\ze:" contained
syntax match dexTodo "FIXME\ze:" contained
highlight def link dexTodo Todo

let b:current_syntax = "dex"
