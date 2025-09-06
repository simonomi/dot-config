" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

set nolist
highlight UnwantedWhitespace ctermbg=NONE

syntax match grd1 "1"
highlight grd1 ctermfg=52
syntax match grd2 "2"
highlight grd2 ctermfg=88
syntax match grd3 "3"
highlight grd3 ctermfg=160
syntax match grd4 "4"
highlight grd4 ctermfg=202
syntax match grd5 "5"
highlight grd5 ctermfg=208
syntax match grd6 "6"
highlight grd6 ctermfg=178
syntax match grd7 "7"
highlight grd7 ctermfg=226
syntax match grd8 "8"
highlight grd8 ctermfg=118
syntax match grd9 "9"
highlight grd9 ctermfg=192
syntax match grd9 "a"
highlight grd9 ctermfg=29
syntax match grdA "b"
highlight grdA ctermfg=51
syntax match grdB "c"
highlight grdB ctermfg=68
syntax match grdC "d"
highlight grdC ctermfg=27
syntax match grdD "e"
highlight grdD ctermfg=55
syntax match grdfz "[f-z]"
highlight grdfz ctermfg=206
syntax match grdAZ "[A-Z]"
highlight grdAZ ctermfg=200

let b:current_syntax = "grd"
