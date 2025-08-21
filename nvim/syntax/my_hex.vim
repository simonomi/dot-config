" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

syntax match my_hexByte00 "00"
highlight my_hexByte00 ctermfg=darkgray
syntax match my_hexByte0 "0[1-9a-fA-F]"
highlight my_hexByte0 ctermfg=52
syntax match my_hexByte1 "1[0-9a-fA-F]"
highlight my_hexByte1 ctermfg=88
syntax match my_hexByte2 "2[0-9a-fA-F]"
highlight my_hexByte2 ctermfg=160
syntax match my_hexByte3 "3[0-9a-fA-F]"
highlight my_hexByte3 ctermfg=202
syntax match my_hexByte4 "4[0-9a-fA-F]"
highlight my_hexByte4 ctermfg=208
syntax match my_hexByte5 "5[0-9a-fA-F]"
highlight my_hexByte5 ctermfg=178
syntax match my_hexByte6 "6[0-9a-fA-F]"
highlight my_hexByte6 ctermfg=226
syntax match my_hexByte7 "7[0-9a-fA-F]"
highlight my_hexByte7 ctermfg=118
syntax match my_hexByte8 "8[0-9a-fA-F]"
highlight my_hexByte8 ctermfg=192
syntax match my_hexByte9 "9[0-9a-fA-F]"
highlight my_hexByte9 ctermfg=29
syntax match my_hexByteA "A[0-9a-fA-F]"
highlight my_hexByteA ctermfg=51
syntax match my_hexByteB "B[0-9a-fA-F]"
highlight my_hexByteB ctermfg=68
syntax match my_hexByteC "C[0-9a-fA-F]"
highlight my_hexByteC ctermfg=27
syntax match my_hexByteD "D[0-9a-fA-F]"
highlight my_hexByteD ctermfg=55
syntax match my_hexByteE "E[0-9a-fA-F]"
highlight my_hexByteE ctermfg=206
syntax match my_hexByteF "F[0-9a-eA-E]"
highlight my_hexByteF ctermfg=200
syntax match my_hexByteFF "FF"
highlight my_hexByteFF ctermfg=white

syntax match my_hexAddress "^[0-9a-f]\+"
highlight default link my_hexAddress Constant

if !exists("b:no_ascii")
	syntax match my_hexAscii "  .\{,16\}$"hs=s+2 contains=my_hexNull,my_hexASCIINonGraphic,my_hexNonASCII,my_hexFFCharacter
	highlight default link my_hexASCII String
endif

syntax match my_hexNull "⋄" contained
highlight my_hexNull ctermfg=darkgray

syntax match my_hexASCIINonGraphic "•" contained
highlight my_hexASCIINonGraphic ctermfg=green

syntax match my_hexNonASCII "×" contained
highlight my_hexNonASCII ctermfg=yellow

syntax match my_hexFFCharacter "╳" contained
highlight my_hexFFCharacter ctermfg=white

let b:current_syntax = "my_hex"
