# Set PATH, MANPATH, etc., for Homebrew.
switch (uname)
	case Darwin
		eval "$(/opt/homebrew/bin/brew shellenv)"
	case Linux
		eval "$(/home/linuxbrew/.linuxbrew/Homebrew/bin/brew shellenv)"
end

fish_add_path ~/.rustup/toolchains/*/bin/
fish_add_path ~/.cargo/bin
fish_add_path ~/.mint/bin
# pipx installs here
fish_add_path ~/.local/bin

if test -e ~/python_virtual_environment/bin/activate.fish
	source ~/python_virtual_environment/bin/activate.fish
end

switch (uname)
	case Darwin
		# source ~/.swiftly/env.fish
		export SHELL=(which fish)
	case Linux
		# source ~/.local/share/swiftly/env.fish
		export SHELL=(which fish)
end

export HOMEBREW_NO_ENV_HINTS=true
export EDITOR=hx
export VISUAL=$EDITOR
export LESS="--RAW-CONTROL-CHARS --incsearch --ignore-case --use-color --tabs=4"
export HOMEBREW_BUNDLE_FILE="~/Documents/dot config/brewfile"
export BACON_PREFS="/Users/simonomi/.config/bacon.toml"
export XDG_CONFIG_HOME="/Users/simonomi/.config"

switch (uname)
	case Darwin
		export XDG_CONFIG_HOME="/Users/simonomi/.config"
	case Linux
		export XDG_CONFIG_HOME="/home/simonomi/.config"
end

if command -q starship
	starship init fish | source
end

if command -q zoxide
	zoxide init fish | source
end

set fish_greeting

# used to be blue, now white by default, i prefer blue
set fish_color_command blue

if status is-interactive
	tabs -4
end

bind / expand-abbr self-insert
bind \; expand-abbr self-insert
bind \- expand-abbr self-insert

set dot_config_dir "~/Documents/dot\ config"

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

abbr -a cd z

alias l "lsd --literal"
alias ll "lsd --literal --color always --almost-all --ignore-glob \".DS_Store\" --total-size --long --blocks date,size,name --sort size"

abbr -a opsw "open Package.swift"
abbr -a opxc "open (fd -e xcodeproj)"

alias kondo "kondo --default --ignored-dirs \$cardr"

alias localip="ipconfig getifaddr en0"

abbr -a r trash

abbr -a st "syncthing browser"

alias "..." "cd ../.."
alias "...." "cd ../../.."

set -g prdr "~/Documents/programming"
set -g pydr $prdr/python
set -g swdr $prdr/swift
set -g cardr $swdr/carbonizer

alias plan "$VISUAL $prdr/daya/my\ lang\ planning.daya"

alias swpl "cd ~/Desktop; $VISUAL test.swift"

abbr -a u update

alias ding "tput bel"

function update
	brew update-if-needed
	set output (brew bundle check) && echo $output || brew bundle install --verbose
	brew upgrade
	brew autoremove
	brew cleanup --scrub
end

alias ascii "cat ~/Documents/misc/ascii.txt"

alias hide "chflags hidden"
alias unhide "chflags nohidden"

alias python python3
alias jfmt "python $pydr/json_formatter.py"
alias :q exit
alias q exit

abbr -a b brew
abbr -a c cargo
abbr -a d "nvim -d"
abbr -a g git
abbr -a h hx
abbr -a j jj
abbr -a n nvim
abbr -a s swift

abbr -a js "jj status"
abbr -a jd --set-cursor "jj describe -m \"%\""
abbr -a jn --set-cursor "jj new -m \"%\""
abbr -a jl "jj log -r \"all()\""
abbr -a jt "jj tug"
abbr -a jp "jj push"
abbr -a jtp "jj tug && jj push"

abbr -a ga "git add"
abbr -a gc --set-cursor "git commit -m \"%\""
abbr -a gac --set-cursor "git commit -am \"%\""
abbr -a gcl --set-cursor "git clone \"%\""
abbr -a gf "git fetch"
abbr -a gfs "git fetch && git status"
abbr -a gp "git push"
abbr -a gpl "git pull"
abbr -a gr "git rebase"
abbr -a gs "git status"
abbr -a gd "git diff"
abbr -a gv "git-visit"
alias git-visit "git remote get-url origin | $swdr/git\ ssh\ url\ to\ https.swift | xargs -r open"

abbr -a bi "brew install"
abbr -a be "brew bundle edit"

alias copy fish_clipboard_copy
alias paste fish_clipboard_paste

alias lorem "cat ~/Documents/misc/lorem\ ipsum.txt"
alias box "cat ~/Documents/misc/box\ drawing\ characters.txt"

abbr -a xcodeFileTemplates 'cd "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates"; fd -e swift'

# abbr -a "ydl" "yt-dlp -f \"bestaudio,bestvideo*\" -o \"%(title)s.%(ext)s\""
abbr -a "ydl" "yt-dlp"

# TODO: these are very slow and pretty unoptimal, but there doesn't seem to be a better way
# - brew info (brew list) would be *very slightly* faster, but would break with xargs and getting the right name
# - manually listing out brew --cellar kinda works, but that doesnt work for installed-only, and casks doesnt work because of symlinks
# - running du -shL on casks breaks bc calibre has an infinite loop
# - brew info --json --installed doesnt include sizes, or it'd be perfect
# - there's now `brew info --size`, but no coloring !
function brewSize
	export HOMEBREW_NO_ANALYTICS=true
	export HOMEBREW_NO_GITHUB_API=true
	brew info (brew leaves; brew list --casks) | rg "^$(brew --prefix)/(Cellar|Caskroom)/([^/]*)/[^ ]* \(([0-9,]+ files, (.*B)|(.*B))\)( \*)?" -r "\$2$(echo \t)\$4\$5" | sort --sort=human-numeric --reverse --key=2 | column -t | $swdr/color-code-file-sizes/color\ code\ file\ sizes
end

function brewSizeAll
	export HOMEBREW_NO_ANALYTICS=true
	export HOMEBREW_NO_GITHUB_API=true
	brew info (brew list) | rg "^$(brew --prefix)/(Cellar|Caskroom)/([^/]*)/[^ ]* \(([0-9,]+ files, (.*B)|(.*B))\)( \*)?" -r "\$2$(echo \t)\$4\$5" | sort --sort=human-numeric --reverse --key=2 | column -t | $swdr/color-code-file-sizes/color\ code\ file\ sizes
end

function brewSizeOf
	export HOMEBREW_NO_ANALYTICS=true
	export HOMEBREW_NO_GITHUB_API=true
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
