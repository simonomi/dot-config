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

syntax match dexKeyword "image" contained
syntax match dexKeyword "frames" contained
syntax match dexKeyword "character" contained
syntax match dexKeyword "degrees" contained
syntax match dexKeyword "effect" contained
syntax match dexKeyword "movement" contained
highlight link dexKeyword Identifier

syntax match dexNumber "\<-\?[0-9]\+\>" contained
syntax match dexNumber "\<-\?0x[0-9a-fA-F]\+\>" contained
highlight link dexNumber Number

syntax keyword dexUnknown unknown: unknowns:
highlight link dexUnknown Special

syntax match dexComment "//.*" contains=dexTodo
highlight link dexComment Comment

syntax keyword dexTodo MARK TODO FIXME contained
highlight def link dexTodo Todo

let b:current_syntax = "dex"

