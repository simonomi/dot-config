" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

set termguicolors

syntax match my_hexByte00 "00"
syntax match my_hexByte0 "0[1-9a-fA-F]"
syntax match my_hexByte1 "1[0-9a-fA-F]"
syntax match my_hexByte2 "2[0-9a-fA-F]"
syntax match my_hexByte3 "3[0-9a-fA-F]"
syntax match my_hexByte4 "4[0-9a-fA-F]"
syntax match my_hexByte5 "5[0-9a-fA-F]"
syntax match my_hexByte6 "6[0-9a-fA-F]"
syntax match my_hexByte7 "7[0-9a-fA-F]"
syntax match my_hexByte8 "8[0-9a-fA-F]"
syntax match my_hexByte9 "9[0-9a-fA-F]"
syntax match my_hexByteA "A[0-9a-fA-F]"
syntax match my_hexByteB "B[0-9a-fA-F]"
syntax match my_hexByteC "C[0-9a-fA-F]"
syntax match my_hexByteD "D[0-9a-fA-F]"
syntax match my_hexByteE "E[0-9a-fA-F]"
syntax match my_hexByteF "F[0-9a-eA-E]"
syntax match my_hexByteFF "FF"

highlight my_hexByte00 ctermfg=darkgray
highlight my_hexByte0 ctermfg=52
highlight my_hexByte1 ctermfg=88
highlight my_hexByte2 ctermfg=160
highlight my_hexByte3 ctermfg=202
highlight my_hexByte4 ctermfg=208
highlight my_hexByte5 ctermfg=178
highlight my_hexByte6 ctermfg=226
highlight my_hexByte7 ctermfg=118
highlight my_hexByte8 ctermfg=192
highlight my_hexByte9 ctermfg=29
highlight my_hexByteA ctermfg=51
highlight my_hexByteB ctermfg=68
highlight my_hexByteC ctermfg=27
highlight my_hexByteD ctermfg=55
highlight my_hexByteE ctermfg=206
highlight my_hexByteF ctermfg=200
highlight my_hexByteFF ctermfg=white

" calculated with oklch L0.75 C0.37 H...
highlight my_hexByte00 guifg=#a0a0a0
highlight my_hexByte0 guifg=#ff71a9 " red
highlight my_hexByte1 guifg=#ff7a78 " salmon
highlight my_hexByte2 guifg=#ff8123 " red-orange
highlight my_hexByte3 guifg=#f79300 " yellow-orange
highlight my_hexByte4 guifg=#e69f00 " yellow
highlight my_hexByte5 guifg=#c1b200 " green-yellow
highlight my_hexByte6 guifg=#82c600 " lime
highlight my_hexByte7 guifg=#00d500 " green
highlight my_hexByte8 guifg=#00d459 " clover
highlight my_hexByte9 guifg=#00d091 " teal
highlight my_hexByteA guifg=#00ccbb " cyan
highlight my_hexByteB guifg=#00c7de " light blue
highlight my_hexByteC guifg=#00beff " blue
highlight my_hexByteD guifg=#6cafff " blurple
highlight my_hexByteE guifg=#b298ff " purple
highlight my_hexByteF guifg=#ff4dff " pink
highlight my_hexByteFF guifg=white

syntax match my_hexAddress "^[0-9a-f]\+"
"highlight default link my_hexAddress Constant
highlight my_hexAddress guifg=#8abbc3

if !exists("b:no_ascii")
	syntax match my_hexAscii "  .\{,16\}$"hs=s+2 contains=my_hexNull,my_hexASCIINonGraphic,my_hexNonASCII,my_hexFFCharacter
	highlight default link my_hexASCII String
endif

syntax match my_hexNull "⋄" contained
highlight my_hexNull ctermfg=darkgrey guifg=#aeaeae

syntax match my_hexASCIINonGraphic "•" contained
highlight my_hexASCIINonGraphic ctermfg=green guifg=#50fa7b

syntax match my_hexNonASCII "×" contained
highlight my_hexNonASCII ctermfg=yellow guifg=#f1fa8c

syntax match my_hexFFCharacter "╳" contained
highlight my_hexFFCharacter ctermfg=white guifg=white

let b:current_syntax = "my_hex"
