# per-OS stuff
switch (uname)
	case Darwin
		eval "$(/opt/homebrew/bin/brew shellenv fish)"
		set -gx XDG_CONFIG_HOME "/Users/simonomi/.config"
		set -gx LESS "--RAW-CONTROL-CHARS --incsearch --ignore-case --use-color --tabs=4"
	case Linux
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
		set -gx XDG_CONFIG_HOME "/home/simonomi/.config"
		set -gx LESS "--RAW-CONTROL-CHARS --ignore-case --tabs=4"
end

# path
if test -e ~/.rustup
	fish_add_path ~/.rustup/toolchains/*/bin/
end
fish_add_path ~/.cargo/bin

# environment variables
set -gx HOMEBREW_NO_ENV_HINTS true
set -gx EDITOR "hx"
set -gx VISUAL $EDITOR
set -gx HOMEBREW_BUNDLE_FILE "~/Documents/dot-config/brewfile"
set -gx BACON_PREFS "/Users/simonomi/.config/bacon.toml"
set -gx LESSCHARSET "utf-8"

# custom tool inits
if command -q starship
	starship init fish | source
end

if command -q zoxide
	zoxide init fish | source
end

if test -e ~/.local/share/swiftly/env.fish
	# @fish-lsp-disable-next-line 1004
	source ~/.local/share/swiftly/env.fish
end

# fish settings
set fish_greeting

# used to be blue, now white by default, i prefer blue
set fish_color_command blue

if status is-interactive
	tabs -4
end

# path variables
set --local dot_config_dir "~/Documents/dot-config"

set --global prdr "$HOME/Documents/programming"
set --global pydr $prdr/python
set --global swdr $prdr/swift
set --global cardr $swdr/carbonizer

# abbrs and aliases
alias frc "$VISUAL $dot_config_dir/config.fish"
alias fishrc "$VISUAL $dot_config_dir/config.fish"
alias src "source $dot_config_dir/config.fish"

alias nrc "nvim $dot_config_dir/nvim/init.vim"
alias nvimrc "nvim $dot_config_dir/nvim/init.vim"

alias nvimlua "nvim $dot_config_dir/nvim/nvim.lua"
alias nlua "nvim $dot_config_dir/nvim/plugins.lua"

alias hxrc "hx $dot_config_dir/helix/helix\ config.toml"
alias hrc "hx $dot_config_dir/helix/helix\ config.toml"

alias hxlang "hx $dot_config_dir/helix/languages.toml"
alias hlang "hx $dot_config_dir/helix/languages.toml"

alias nurc "$VISUAL $dot_config_dir/config.nu"

alias l "lsd --literal"
alias ll "lsd --literal --color always --almost-all --ignore-glob \".DS_Store\" --total-size --long --blocks date,size,name --sort size"

abbr --add opsw "open Package.swift"
abbr --add opxc "open (fd -e xcodeproj)"

alias kondo "kondo --default --ignored-dirs \$cardr"

alias localip="ipconfig getifaddr en0"

abbr --add r trash

abbr --add st "syncthing browser"

alias "..." "cd ../.."
alias "...." "cd ../../.."
alias "....." "cd ../../../.."
alias "......" "cd ../../../../.."
alias "......." "cd ../../../../../.."
alias "........" "cd ../../../../../../.."

alias plan "$VISUAL $prdr/daya/my\ lang\ planning.daya"

alias swpl "cd ~/Desktop; $VISUAL test.swift"

abbr --add u update

alias ding "tput bel"

alias ascii "cat ~/Documents/misc/ascii.txt"

alias hide "chflags hidden"
alias unhide "chflags nohidden"

alias python python3
alias jfmt "python $pydr/json_formatter.py"
alias :q exit
alias q exit

abbr --add b brew
abbr --add c cargo
abbr --add d "nvim -d"
abbr --add g git
abbr --add h hx
abbr --add j jj
abbr --add n nvim
abbr --add s swift

abbr --add js "jj status"
abbr --add jd --set-cursor "jj describe -m \"%\""
abbr --add jn --set-cursor "jj new -m \"%\""
abbr --add jl "jj log -r \"all()\""
abbr --add jt "jj tug"
abbr --add jf "jj fetch"
abbr --add jp "jj push --remote origin && jj push --remote codeberg"
abbr --add jtp "jj tug && jj push --remote origin && jj push --remote codeberg"

abbr --add ga "git add"
abbr --add gc --set-cursor "git commit -m \"%\""
abbr --add gac --set-cursor "git commit -am \"%\""
abbr --add gcl --set-cursor "git clone \"%\""
abbr --add gf "git fetch"
abbr --add gfs "git fetch && git status"
abbr --add gp "git push"
abbr --add gpl "git pull"
abbr --add gr "git rebase"
abbr --add gs "git status"
abbr --add gd "git diff"
abbr --add gv "git-visit"
alias git-visit "open (git remote get-url origin | $swdr/git\ ssh\ url\ to\ https.swift)"
abbr --add cv "code-visit"
alias code-visit "open (git remote get-url codeberg | $swdr/git\ ssh\ url\ to\ https.swift)"

abbr --add bi "brew install"
abbr --add be "$VISUAL $HOMEBREW_BUNDLE_FILE"

alias copy "fish_clipboard_copy"
alias paste "fish_clipboard_paste"

alias lorem "cat ~/Documents/misc/lorem\ ipsum.txt"
alias box "cat ~/Documents/misc/box\ drawing\ characters.txt"

abbr --add xcodeFileTemplates 'cd "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates"; fd -e swift'

abbr --add ydl "yt-dlp"

abbr --add tr "transmission-remote"
abbr --add tl "transmission-remote --list"
abbr --add ta --set-cursor "transmission-remote --add \"%\""
abbr --add td --set-cursor "transmission-remote -t % --remove"
abbr --add v "viddy -w transmission-remote --list"

alias bks "cd ~/Documents/books; webdav"

alias rot13 "tr \"[a-zA-Z]\" \"[n-za-mN-ZA-M]\""

alias meth "bat | math"

alias hexapoda "~/Documents/programming/rust/hexapoda/target/debug/hexapoda"

abbr --add x "hexapoda"

alias conflicts "fd \"\\.sync-conflict\" --hidden --exclude .stversions/"

abbr --add --set-cursor code "jj git remote add codeberg \"%\"; jj bookmark track main --remote=codeberg"

# custom functions
function update
	brew update-if-needed
	set output (brew bundle check) && echo $output || brew bundle install --verbose
	brew upgrade
	brew autoremove
	brew cleanup --scrub
end

# TODO: these are very slow and pretty unoptimal, but there doesn't seem to be a better way
# - brew info (brew list) would be *very slightly* faster, but would break with xargs and getting the right name
# - manually listing out brew --cellar kinda works, but that doesnt work for installed-only, and casks doesnt work because of symlinks
# - running du -shL on casks breaks bc calibre has an infinite loop
# - brew info --json --installed doesnt include sizes, or it'd be perfect
# - there's now `brew info --size`, but no coloring !
function brewSize
	set -x HOMEBREW_NO_ANALYTICS true
	set -x HOMEBREW_NO_GITHUB_API true
	brew info (brew leaves; brew list --casks) | rg "^$(brew --prefix)/(Cellar|Caskroom)/([^/]*)/[^ ]* \(([0-9,]+ files, (.*B)|(.*B))\)( \*)?" -r "\$2$(echo \t)\$4\$5" | sort --sort=human-numeric --reverse --key=2 | column -t | $swdr/color-code-file-sizes/color\ code\ file\ sizes
end

function brewSizeAll
	set -x HOMEBREW_NO_ANALYTICS true
	set -x HOMEBREW_NO_GITHUB_API true
	brew info (brew list) | rg "^$(brew --prefix)/(Cellar|Caskroom)/([^/]*)/[^ ]* \(([0-9,]+ files, (.*B)|(.*B))\)( \*)?" -r "\$2$(echo \t)\$4\$5" | sort --sort=human-numeric --reverse --key=2 | column -t | $swdr/color-code-file-sizes/color\ code\ file\ sizes
end

function brewSizeOf
	set -x HOMEBREW_NO_ANALYTICS true
	set -x HOMEBREW_NO_GITHUB_API true
	brew info (echo $argv; brew deps $argv) | rg "^$(brew --prefix)/(Cellar|Caskroom)/([^/]*)/[^ ]* \(([0-9,]+ files, (.*B)|(.*B))\)( \*)?" -r "\$2$(echo \t)\$4\$5" | sort --sort=human-numeric --reverse --key=2 | column -t | $swdr/color-code-file-sizes/color\ code\ file\ sizes
end

function brewNotInBundle
	nu -c "let bundle = brew bundle list --all | lines; (brew leaves) ++ \"\n\" ++ (brew list --casks) | lines | where \$it not-in \$bundle | collect | to text --no-newline"
end

function convertAllBmps
	for file in (fd --extension bmp)
		magick "$file" "$(path change-extension png $file)"
	end
end

set -g fish_color_selection white --background=brblack

function not_fish_user_key_bindings
	fish_vi_key_bindings insert
	
	# Add a way to switch from insert to normal (command) mode.
	# Note if we are paging, we want to stay in insert mode
	# See #2871
	set -l on_escape "
		if commandline -P
			commandline -f cancel
		else
			set fish_bind_mode default
			set fish_cursor_selection_mode inclusive
			if test (commandline --cursor) -gt (commandline --selection-start || echo -1)
				commandline -f backward-char
			end
			commandline -f repaint-mode
		end
	"
	bind --mode insert escape $on_escape
	
	bind --mode default --sets-mode visual v "
		set -g fish_color_selection yellow --background=brblack
		if not commandline --selection-start > /dev/null
			commandline -f begin-selection
		end
		commandline -f repaint-mode
	"
	
	bind --mode default j "fish_vi_run_count end-selection backward-char begin-selection"
	bind --mode default l "fish_vi_run_count end-selection forward-char begin-selection"
	
	bind --mode default i "fish_vi_run_count end-selection up-or-search begin-selection"
	bind --mode default k "fish_vi_run_count end-selection down-or-search begin-selection"
	
	# TODO: fix web for beginning/end of line
	# TODO: fix web in general, currently selects too much
	
	bind --mode default w "fish_vi_run_count end-selection begin-selection forward-word-vi"
	bind --mode default W "fish_vi_run_count end-selection begin-selection forward-bigword-vi"
	
	bind --mode default e "
		if test (commandline --cursor) != (math (commandline | wc -c) - 2)
			fish_vi_run_count end-selection begin-selection forward-word-end
		end
	"
	bind --mode default E "fish_vi_run_count end-selection begin-selection forward-bigword-end"
	
	bind --mode default b "
		if test (commandline --cursor) != 0
			fish_vi_run_count end-selection begin-selection backward-word
		end
	"
	bind --mode default B "
		if test (commandline --cursor) != 0
			fish_vi_run_count end-selection begin-selection backward-bigword
		end
	"
	
	bind --mode default g,e "
		if test (commandline --cursor) != 0
			fish_vi_run_count end-selection begin-selection backward-word-end
		end
	"
	bind --mode default g,E "
		if test (commandline --cursor) != 0
			fish_vi_run_count end-selection begin-selection backward-bigword-end
		end
	"
	
	bind --mode default g,j "end-selection" "beginning-of-line" "begin-selection"
	bind --mode default g,l "end-selection" "end-of-line" "begin-selection"
	
	bind --mode default ";" "begin-selection"
	bind --mode default "alt-;" "swap-selection-start-stop"
	
	bind --sets-mode insert h "
		if test (commandline --cursor) -gt (commandline --selection-start || echo -1)
			commandline -f swap-selection-start-stop
		end
		commandline -f repaint-mode
	"
	bind --sets-mode insert H "beginning-of-line" "begin-selection" "repaint-mode"
	
	bind --sets-mode insert a "
		set fish_cursor_end_mode exclusive
		set fish_cursor_selection_mode exclusive
		if test (commandline --cursor) = (commandline --selection-start || echo -1)
			commandline -f swap-selection-start-stop
		end
		commandline -f forward-single-char
		commandline -f repaint-mode
	"
	bind --sets-mode insert A "set fish_cursor_end_mode exclusive" "set fish_cursor_selection_mode exclusive" "end-selection" "end-of-line" "repaint-mode"
	
	bind --mode insert "" "self-insert" "backward-char" "forward-char" "
		if test (commandline --cursor) = (commandline --selection-start || echo -1)
			commandline -f swap-selection-start-stop
			commandline -f forward-char
			commandline -f swap-selection-start-stop
		end
	"
	
	for character in " " ";" "<" ">" "|" ")" "&" "/" "-"
		bind --mode insert "$character" "self-insert" "expand-abbr" "backward-char" "forward-char" "
			if test (commandline --cursor) = (commandline --selection-start || echo -1)
				commandline -f swap-selection-start-stop
				commandline -f forward-char
				commandline -f swap-selection-start-stop
			end
		"
	end
	
	bind --mode default d "kill-selection" "end-selection"
	bind --mode default --sets-mode insert c "kill-selection" "end-selection" "repaint-mode"
	
	bind U redo
	
	# visual mode
	bind --mode visual --sets-mode default v "set -g fish_color_selection white --background=brblack" "repaint-mode"
	
	bind --mode visual j "backward-char"
	
	bind --mode visual j "backward-char"
	bind --mode visual l "forward-char"
	
	bind --mode visual i "up-line"
	bind --mode visual k "down-line"
	
	bind --mode visual w "fish_vi_run_count forward-word-vi"
	bind --mode visual W "fish_vi_run_count forward-bigword-vi"
	
	bind --mode visual e "fish_vi_run_count forward-word-end"
	bind --mode visual E "fish_vi_run_count forward-bigword-end"
	
	bind --mode visual b "fish_vi_run_count backward-word"
	bind --mode visual B "fish_vi_run_count backward-bigword"
	
	bind --mode visual g,e "fish_vi_run_count backward-word-end"
	bind --mode visual g,E "fish_vi_run_count backward-bigword-end"
	
	bind --mode visual g,j "beginning-of-line"
	bind --mode visual g,l "end-of-line"
	
	bind --mode visual ";" "begin-selection"
	bind --mode visual "alt-;" "swap-selection-start-stop"
	
	bind --mode visual --sets-mode insert h "repaint-mode"
	bind --mode visual --sets-mode insert H "end-selection" "beginning-of-line" "repaint-mode"
end
