" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

set nolist
highlight UnwantedWhitespace ctermbg=NONE

syntax match grd1 "1"
syntax match grd2 "2"
syntax match grd3 "3"
syntax match grd4 "4"
syntax match grd5 "5"
syntax match grd6 "6"
syntax match grd7 "7"
syntax match grd8 "8"
syntax match grd9 "9"
syntax match grd9 "a"
syntax match grdA "b"
syntax match grdB "c"
syntax match grdC "d"
syntax match grdD "e"
syntax match grdfz "[f-z]"
syntax match grdAZ "[A-Z]"

" copied from my_hex
highlight grd1 ctermfg=52   guifg=#ff71a9
highlight grd2 ctermfg=88   guifg=#ff7a78
highlight grd3 ctermfg=160  guifg=#ff8123
highlight grd4 ctermfg=202  guifg=#f79300
highlight grd5 ctermfg=208  guifg=#e69f00
highlight grd6 ctermfg=178  guifg=#c1b200
highlight grd7 ctermfg=226  guifg=#82c600
highlight grd8 ctermfg=118  guifg=#00d500
highlight grd9 ctermfg=192  guifg=#00d459
highlight grd9 ctermfg=29   guifg=#00d091
highlight grdA ctermfg=51   guifg=#00ccbb
highlight grdB ctermfg=68   guifg=#00c7de
highlight grdC ctermfg=27   guifg=#00beff
highlight grdD ctermfg=55   guifg=#6cafff
highlight grdfz ctermfg=206 guifg=#b298ff
highlight grdAZ ctermfg=200 guifg=#ff4dff

let b:current_syntax = "grd"
