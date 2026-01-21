" vimtex editor
" this needs to be before `syntax on` so that vimtex loads after it
let g:vimtex_view_method="skim"
let g:vimtex_view_skim_sync=1
let g:vimtex_view_skim_no_select=1
let g:vimtex_compiler_latexmk = {
	\"executable": "latexmk",
	\"options": [
		\"-xelatex",
		\"-file-line-error",
		\"-synctex=1",
		\"-interaction=nonstopmode",
	\],
\}
let g:vimtex_compiler_latexmk_engines = {
	\"_": "-xelatex"
\}
let g:python3_host_prog = expand('~/python_virtual_environment/bin/python')

" disable netrw for nvim-tree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

"let g:coc_global_extensions = ["coc-html", "coc-rust-analyzer", "coc-python", "coc-json", "coc-css", "coc-vimlsp"]
let g:coc_global_extensions = ["coc-python", "coc-vimlsp"]

syntax on
try
	colorscheme vim
catch /^Vim\%((\a\+)\)\=:E185/
	" do nothing—colorscheme doesnt exist
endtry

set notermguicolors

"     k            i
"   h   l   ->   j   l
"     j            k
" but display line-wise, not actual line-wise
" BUT ONLY IN NORMAL/VISUAL MODE, NOT MOTION
noremap j h
onoremap k j
onoremap i k
nnoremap <silent> k gj
nnoremap <silent> i gk
vnoremap <silent> k gj
vnoremap <silent> i gk
noremap h i

" make arrow keys display line-wise
noremap <up> gk
noremap <down> gj

" because of nvim-comment
vnoremap i k

noremap gk j
noremap gi k

" I -> H
noremap <S-h> <S-I>

" set leader to <Space>
let mapleader = " "
noremap <Space> <Nop>

" window switching
noremap <C-j> <C-w>h
noremap <C-k> <C-w>j
" noremap <C-i> <C-w>k
noremap <Tab> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-i>

" window moving
noremap <C-w><S-j> <C-w><S-h>
noremap <C-w><S-k> <C-w><S-j>
noremap <C-w><S-i> <C-w><S-k>
noremap <C-w><S-h> <C-w><S-i>

" terminal window switching
tnoremap <C-j> <C-\><C-n><C-w>h
tnoremap <C-k> <C-\><C-n><C-w>j
tnoremap <C-l> <C-\><C-n><C-w>l

" because ^I is the control code for tab
tnoremap <Tab> <C-i>

" use M instead of m to place marks
noremap M m

" swap ' <-> ` (for jumping to marks)
noremap ` '
noremap ' `

" swap 0 <-> ^
nnoremap 0 ^
nnoremap ^ 0

" move line up/down
nnoremap <S-i> :<C-u>move -<C-r>=v:count1+1<CR><CR>
nnoremap <S-k> :<C-u>move +<C-r>=v:count1<CR><CR>
vnoremap <S-i> :move '<-<C-r>=v:count1+1<CR><CR>gv
vnoremap <S-k> :move '>+<C-r>=v:count1<CR><CR>gv

" make J not insert spaces after '('
noremap J J<Cmd>keeppatterns '[,']s/( /(/e \| noh<CR>

" make gJ join with no spaces (only works in normal mode :/)
nnoremap gJ gJdiW

nnoremap M ca(<C-r>=ReformatListAcrossLines()<CR><Esc>%
" print(one, two, three(four, five), six, seven)

" TODO: should split up argument/array/dictionary/etc list by , into lines (like xcode's ^m)
function! ReformatListAcrossLines()
	echo @"
	return @"
endfunction

" <A-d> duplicate line
nnoremap ∂ <Cmd>copy .<CR>

" v_<A-d> duplicate selected text
vnoremap ∂ ygvppgv

" hide search results with Esc
nnoremap <silent> <Esc> <Cmd>noh<CR>

" v_Q runs previously-recorded macro for each line selected
vnoremap Q :normal Q<CR>

" v_@ runs macro for each line selected
vnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

" open terminal below
noremap <silent> <Leader>t <Cmd>below new\|terminal<CR>

" select all
noremap <Leader>a ggVG

nnoremap == m`Ax<Esc>==$x``

" set register to clipboard
noremap <Leader>c "*

" yank to clipboard
noremap <Leader>y "*y

" put from clipboard
noremap <Leader>p "*p

" cut to clipboard
noremap \x "*ygvd

" \f open telescope find_files
" noremap <Leader>f <Cmd>Telescope find_files<CR>

" fold nearest block
noremap <Leader>f zfa{

" grep for selected word
noremap <Leader>g <Cmd>Telescope grep_string<CR>

" \s split
noremap <Leader>s <C-w><C-s>

" \v split vertically
noremap <Leader>v <C-w><C-v>

" \= equally size windows
noremap <Leader>= <C-w>=

" \q quit
noremap <Leader>q <Cmd>quit<CR>
" \Q force quit all
noremap <Leader>Q <Cmd>quitall!<CR>

" \w update
noremap <Leader>w <Cmd>update<CR>

" \x exit
noremap <Leader>x <Cmd>exit<CR>

" \_ full vertical size window
noremap <Leader>_ <C-w>_

" ^s enable spell checking
noremap <C-s> <Cmd>call ToggleSpellChecking()<CR>

" note to self because i always come here, z= to correct misspelled word

function ToggleSpellChecking()
	if &spell
		setlocal nospell
	else
		setlocal spell
	end
endfunction

" TODO: put all the lsp commands together
" replace current word in file
" TODO: integrate with coc document.renameCurrentWord
" or the lsp "grn"
"noremap \r yiw*#<Cmd>redraw<CR>:%s/\<<C-r>"\>//I<left><left>
noremap \r <Cmd>lua vim.lsp.buf.rename()<CR>

" misc settings
set ruler
set showcmd

set ignorecase
set incsearch
set smartcase

" if a file doesn't end in a newline, don't force it to
" note that nvim DOES NOT show a trailing newline
set nofixeol

set timeoutlen=1000000

set scrolloff=3

set backupcopy=yes " to preserve creation date

set formatoptions+=ro/ " to enable comment continuation

set spelllang=en_us " spell checking language
set spelloptions+=camel " check camelCase words separately
set spellcapcheck="" " disable requiring capital letters at the beginning of sentences
set spellsuggest=best,3 " sets the limit for spell suggestions to 3

" TODO: change spell check highlight colors
highlight SpellBad ctermfg=black
highlight SpellCap ctermfg=black
highlight SpellRare ctermfg=black
highlight SpellLocal ctermfg=black

set smoothscroll " allow scrolling through long single lines

set gdefault " g on by default for :s

set lazyredraw

set comments=b:-,b:*,n:>
augroup fix_list_indentation_in_text_files
	autocmd!
	autocmd FileType text setlocal comments=b:-,b:*,n:>
augroup END

augroup textwidth_should_always_be_0
	autocmd!
	autocmd FileType * setlocal textwidth=0
augroup END

highlight NonText ctermfg=8 " 8 *should* be the same as darkgrey, but isn't, and is prettier
set listchars=tab:╶─╴,nbsp:⍽,space:·
" set listchars=tab:╶─╴,nbsp:⍽,trail:·
set list

" undo
set undofile
set history=1000
nnoremap U <Cmd>UndotreeToggle<CR>
let g:undotree_ShortIndicators = 1
let g:undotree_CursorLine = 0
" needs to be shown or it wont highlight
let g:undotree_DiffpanelHeight = 0
let g:undotree_TreeVertShape = "│"
let g:undotree_TreeSplitShape = "╱"
let g:undotree_TreeReturnShape = "╲"

highlight UndotreeSavedBig ctermbg=black
highlight UndotreeSeq ctermfg=green
highlight UndotreeNext ctermfg=red

function g:Undotree_CustomMap()
	nmap <buffer> I <plug>UndotreeNextState
	nmap <buffer> K <plug>UndotreePreviousState
endfunction

" diff options
" set diffopt+=algorithm:histogram the issue i was trying to fix is intended (see diff.txt:217)

" sticky headers
" highlight TreesitterContext ctermbg=darkgrey
highlight TreesitterContext ctermbg=black
highlight TreesitterContextBottom cterm=underline
highlight TreesitterContextLineNumber ctermfg=grey

" line numbers
set number
set relativenumber
set signcolumn=no

" highlight unwanted whitespace
" trailing tab(s) OR trailing space(s)
match UnwantedWhitespace /\v(\t|^(|\/\/ |-- |# |\" |\<!-- ))@<!\zs\t+| +%#@<!$/
highlight UnwantedWhitespace ctermfg=12 ctermbg=darkgrey

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

highlight LineNrBelow ctermfg=gray
highlight LineNrAbove ctermfg=gray

" fold column
set foldcolumn=auto
highlight FoldColumn ctermbg=black

" matchpair color
highlight MatchParen ctermbg=darkgrey

augroup rustfmt_on_save
	autocmd!
	autocmd BufWritePre *.rs lua vim.lsp.buf.format()
augroup END

augroup terminal_auto_insert
	autocmd!
	autocmd TermOpen * startinsert
	autocmd BufEnter term://* startinsert
augroup END

set guicursor=n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20
augroup fix_cursor_on_quit
	autocmd ExitPre * set guicursor=n:ver25
augroup END

augroup vimtex_clean_when_stopped
	autocmd!
	autocmd User VimtexEventCompileStopped call vimtex#compiler#clean(0)
augroup END

" CoC keybinds
let g:coc_snippet_next="<Tab>"
let g:coc_snippet_prev="<S-Tab>"

"nnoremap <Leader>n <Plug>(coc-diagnostic-next)
"nnoremap <Leader>p <Plug>(coc-diagnostic-prev)

" make autopairs play nice with coc
" AND fix vim wanting to remove my blank line indents !!
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
	\ "x<Backspace>\<CMD>call feedkeys(v:lua.require'nvim-autopairs'.autopairs_cr(), 'in')\<CR>"

"inoremap <silent><expr> <C-Space> coc#pum#visible() ? coc#pum#stop() : coc#refresh()
"nnoremap <expr> <C-Space> CocHasProvider("hover") ? "\<Cmd>call CocAction('doHover')\<CR>" : "\<Cmd>lua vim.lsp.buf.hover()\<CR>"

" TODO: move this someone else
" coq keybinds
nnoremap <C-Space> <Cmd>lua vim.lsp.buf.hover()<CR>
"inoremap <silent><expr> <C-Space> pumvisible() ? "\<C-x>\<C-z>" : "\<Cmd>lua vim.lsp.completion.get()\<CR>"
inoremap <silent><expr> <C-Space> pumvisible() ? "\<C-x>\<C-z>" : "\<C-x>\<C-o>"
" TODO: for the built-in lsp, <C-s> or vim.lsp.buf.signature_help

nnoremap <Leader>? <Cmd>lua vim.lsp.buf.code_action()<CR>

"set completeitemalign=abbr
set completeopt=menu,menuone,noinsert,popup
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "x<Backspace>\<CMD>call feedkeys(v:lua.require'nvim-autopairs'.autopairs_cr(), 'in')\<CR>"

" TODO: why are <C-i> and <Tab> the same :(
inoremap <C-S-i> <Cmd>call CocActionAsync("showSignatureHelp")<CR>

augroup CocSignatureHelp
	autocmd!
	autocmd User CocJumpPlaceholder call CocActionAsync("showSignatureHelp")
augroup end

augroup idris
	autocmd!
	autocmd FileType idris2 nnoremap \s <Cmd>lua require("idris2.code_action").expr_search()<CR>
augroup end

" NvimTree keybinds
" \e to open NvimTree
nnoremap <silent> <Leader>e <Cmd>NvimTreeFindFileToggle<CR>
" TODO: kick cursor out of newly opened window
" TODO: figure out how to remap <C-w><S-k> in NvimTree

" bufferline
"highlight BufferLineBackground ctermfg=DarkGrey
"highlight BufferLineNumbers ctermfg=DarkGrey
"
"highlight BufferLineBufferSelected cterm=bold,underline ctermfg=cyan
"highlight BufferLineNumbersSelected cterm=bold,underline ctermfg=cyan
"highlight BufferLineIndicatorSelected cterm=bold,underline ctermfg=cyan
"
"highlight BufferLineTruncMarker ctermfg=cyan
"
" " this is reverse by default, which flips all of the above
"highlight TabLineFill cterm=none

" ∆ is <A-j>, ¬ is <A-l> " not anymore!
"noremap ∆ <Cmd>BufferLineCyclePrev<CR>
"noremap ¬ <Cmd>BufferLineCycleNext<CR>
noremap <A-j> <Cmd>BufferLineCyclePrev<CR>
noremap <A-l> <Cmd>BufferLineCycleNext<CR>
noremap <C-j> <Cmd>BufferLineCyclePrev<CR>
noremap <C-l> <Cmd>BufferLineCycleNext<CR>

" terminal remaps
tnoremap <C-w> <C-\><C-n><C-w>
tnoremap : <C-\><C-n>:
tnoremap \: :
tnoremap <Esc> <C-\><C-n><C-w>k

" run previous command again (in lower terminal)
noremap <silent> <Leader>r <Cmd>call RunPrevious()<CR>

function RunPrevious()
	let l:filename = expand("%:t")
	wa
	if bufwinnr("term") == -1
		below new
		terminal
		wincmd k
	end
	buffer term
	execute feedkeys("\<Up>\<CR>\<C-\>\<C-n>\<C-^>")
endfunction

" \h manually enable hex editing
noremap <silent> <Leader>h <Cmd>call ToggleHex()<CR>

noremap <silent> <Leader>H <Cmd>bufdo ParseHex<CR>

function ToggleHex()
	if &ft == "my_hex"
		call UnParseHex()
	else
		call ParseHex()
	end
endfunction

" TODO: is there a way to make undo also undo the set ft?
" maybe map u to set ft+u+reset map?
function ParseHex()
	let wasnomodified = &modified == 0
	setlocal eventignore=
	setlocal filetype=my_hex
	setlocal noundofile
	silent! undojoin
	execute "%!~/Documents/programming/rust/my_hex_viewer/my_hex_viewer"
	if wasnomodified
		set nomodified
	endif
endfunction

function UnParseHex()
	let wasnomodified = &modified == 0
	setlocal eventignore=
	setlocal filetype=
	setlocal undofile
	silent! undojoin
	execute "%!~/Documents/programming/rust/my_hex_viewer/my_hex_viewer --revert"
	if wasnomodified
		set nomodified
	endif
endfunction

function DisableASCII()
	let b:no_ascii = "yes"
	set ft=my_hex
endfunction

function EnableASCII()
	unlet b:no_ascii
	set ft=my_hex
endfunction

command -bar ParseHex silent call ParseHex()
command -bar UnParseHex silent call UnParseHex()
command -bar DisableASCII silent call DisableASCII()
command -bar EnableASCII silent call EnableASCII()

augroup hex_editing
	autocmd!
	autocmd BufReadPost *.bin,*.nds,*.sav ParseHex
	autocmd BufWritePre * if &ft == "my_hex" | let win_view = winsaveview() | UnParseHex | setlocal ft=my_hex | endif
	autocmd BufWritePost * if &ft == "my_hex" | ParseHex | call winrestview(win_view) | endif
augroup END

augroup ft_my_hex
	autocmd!
	autocmd Syntax my_hex setlocal listchars=tab:╶─╴,nbsp:⍽,trail:·
augroup END

" hex function
function! Hex(arg)
	return printf('%X', a:arg + 0)
endfunction

" \mfr remove mifare key data from dump
noremap <Leader>mfr gg^jjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjd$jjjjddgg

" \mff format charliecard data
map <Leader>mff <Leader>mfr32ggdGgg

" \mfc format charliecard data (compacct)
map <Leader>mfc <Leader>mfr32ggdGiiiddiiiiddiiiiddiiiiddiiiiddiiiiddiiiiddgg

augroup dex_syntax_highlighting
	autocmd!
	autocmd BufNewFile,BufRead *.dex,*.dep set ft=dex
augroup END

augroup grd_syntax_highlighting
	autocmd!
	autocmd BufNewFile,BufRead *.grd.txt set ft=grd
augroup END

augroup kbd_syntax_highlighting
	autocmd!
	autocmd BufNewFile,BufRead *.kbd set ft=kbd
augroup END

augroup brewfile_syntax_highlighting
	autocmd!
	autocmd BufNewFile,BufRead brewfile set ft=ruby
augroup END

augroup daya_syntax_highlighting
	autocmd!
	autocmd BufNewFile,BufRead *.daya set ft=swift
	autocmd BufNewFile,BufRead *.daya LspStop
augroup END

augroup ft_coq
	autocmd!
	autocmd Syntax coq nnoremap <Leader>n <Cmd>exe "CoqNext".v:count1<CR>
	autocmd Syntax coq nnoremap <Leader>p <Cmd>exe "CoqUndo".v:count1<CR>
	autocmd Syntax coq nnoremap <Leader><Leader> <Cmd>CoqToLine<CR>
	autocmd Syntax coq set tabstop=2
augroup END

" change syntax highlighting colors
highlight Comment ctermfg=8 " 8 *should* be the same as darkgrey, but isn't, and is prettier
highlight Number ctermfg=yellow
highlight Identifier ctermfg=lightblue
highlight String ctermfg=red
highlight Character ctermfg=red
highlight Delimiter ctermfg=none
highlight Boolean cterm=bold ctermfg=magenta
highlight Statement cterm=bold ctermfg=magenta
highlight Operator cterm=none ctermfg=none

" pop-up menu colors
highlight NormalFloat ctermbg=237
highlight! link Pmenu NormalFloat
highlight PmenuSel ctermfg=white ctermbg=238

" TODO: this should link to comment in code, but lightgrey in pmenu
highlight @markup.raw ctermfg=lightgrey
" TODO: comments in pop up menus are horrible to read

" change diff highlighting colors
" i know its bad, but these really are the best
highlight DiffAdd ctermbg=22
highlight DiffChange ctermbg=17
highlight DiffDelete ctermbg=52
highlight DiffText ctermbg=58 cterm=none

" swift syntax highlighting
highlight swiftCoreTypes ctermfg=blue

highlight link swiftImport Keyword
highlight link swiftIdentifierKeyword Keyword
highlight link swiftFuncKeyword Keyword
highlight link swiftFuncDefinition Keyword
highlight link swiftFuncKeywordGeneral Keyword
highlight link swiftTypeDefinition Keyword
highlight link swiftMultiwordTypeDefinition Keyword
highlight link swiftVarDefinition Keyword
highlight link swiftDefinitionModifier Keyword
highlight link swiftCastOp Keyword
highlight link swiftLabel Keyword
highlight link swiftTypeAliasDefinition Keyword
highlight link swiftInOutKeyword Keyword

highlight link swiftOperator Operator
highlight link swiftInterpolation Operator

highlight link swiftTypeName Identifier

highlight link swiftImportModule Normal

highlight link swiftExistentialKeyword swiftKeyword

augroup swift_syntax_changes
	autocmd!
	" remove ? and ! as part of the type, and allow to contain swiftCoreTypes/existentials
	autocmd Syntax swift syntax match swiftType contained contains=swiftCoreTypes,swiftExistentialKeyword skipwhite skipempty nextgroup=swiftTypeParameters /\<[A-Za-z_][A-Za-z_0-9\.]*\>/
	
	" allow swiftCoreTypes to be contained
	autocmd Syntax swift syntax keyword swiftCoreTypes contained
	
	" add common standard library types to swiftCoreTypes
	autocmd Syntax swift syntax keyword swiftCoreTypes
		\ Int UInt Int8 Int16 Int32 Int64 Int128 UInt8 UInt16 UInt32 UInt64 UInt128
		\ Double Float
		\ Bool String Character
		\ Date Data URL UUID
		\ Hashable Codable Comparable Equatable
		\ View
	
	" fix inout Whatever being a type definition
	autocmd Syntax swift syntax keyword swiftInOutKeyword skipwhite skipempty nextgroup=swiftType inout
	
	" add async/await keywords
	autocmd Syntax swift syntax keyword swiftDefinitionModifier async
	autocmd Syntax swift syntax keyword swiftKeyword await
	
	" add any/some keywords FIXME: doesnt correctly highlight the type
	autocmd Syntax swift syntax keyword swiftExistentialKeyword skipwhite skipempty contained nextgroup=swiftType any some
augroup END

" indentation
set tabstop=4
set noexpandtab
set shiftwidth=0
set copyindent
set preserveindent
set cpoptions+=I " dont remove indent when moving line down
set shiftround " make < and > round to tab levels

augroup disable_auto_spaces
	autocmd!
	autocmd FileType * set noexpandtab
	autocmd FileType * set shiftwidth=0
augroup END

" fix vim wanting to remove my blank line indents !!
inoremap <Esc> x<Backspace><Esc>

" TODO: at some point, customize lazy.nvim config
" start plugins
luafile ~/.config/nvim/nvim.lua
