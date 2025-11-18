# TODO: add custom fish_title function
# - if not running command, show path
# - if running nvim, show file name
# - if running other command... show everything?

# Set PATH, MANPATH, etc., for Homebrew.
switch (uname)
	case Darwin
		eval "$(/opt/homebrew/bin/brew shellenv)"
	case Linux
		eval "$(/home/linuxbrew/.linuxbrew/Homebrew/bin/brew shellenv)"
end

fish_add_path ~/.cargo/bin
fish_add_path ~/.mint/bin
# pipx installs here
fish_add_path ~/.local/bin
# ruby gems install here
fish_add_path (gem environment home)/bin

source ~/python_virtual_environment/bin/activate.fish

switch (uname)
	case Darwin
		# source ~/.swiftly/env.fish
		export SHELL=(which fish)
	case Linux
		# source ~/.local/share/swiftly/env.fish
		export SHELL=(which fish)
end

export HOMEBREW_NO_ENV_HINTS=true
export EDITOR=nvim
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

export JAVA_HOME="$(/usr/libexec/java_home)"
export ANDROID_HOME="/Users/simonomi/Library/Android/sdk"
export ANDROID_NDK_HOME="/Users/simonomi/Library/Android/sdk/ndk/29.0.14033849"
fish_add_path "$JAVA_HOME/bin" # jdk tools dir
fish_add_path "$ANDROID_HOME/platform-tools" # sdk platform tools
fish_add_path "$ANDROID_HOME/build-tools" # sdk tools ?

switch (hostname)
	case saphira.local
		set signingKey (git config --system user.signingKey)
		if test -z $signingKey
			echo "setting git signing key, sudo required"
			sudo git config --system user.signingKey 375A7BA7
		end
end

starship init fish | source
zoxide init fish | source

set fish_greeting

if status is-interactive
	tabs -4
end

bind / expand-abbr self-insert
bind \; expand-abbr self-insert

# set -g icldr /Users/simonomi/Library/Mobile\\ Documents/com\\\~apple\\\~CloudDocs
set -g icldr /Users/simonomi/Library/Mobile\\\ Documents/com\\\~apple\\\~CloudDocs
# set -g icldr "/Users/simonomi/Library/Mobile Documents/com~apple~CloudDocs"
set homedr "/Users/simonomi"

set dot_config_dir "$homedr/Documents/dot\ config"

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

alias kondo "kondo --default --ignored-dirs \$cardr"

# FIXME: once helix fixes its own cursor, delete this
function hx
	command hx $argv
	fixCursor
end

alias "..." "cd ../.."
alias "...." "cd ../../.."

set -g prdr "$homedr/Documents/programming"
set -g pydr $prdr/python
set -g rsdr $prdr/rust
set -g swdr $prdr/swift
set -g hsdr $prdr/haskell
set -g texdr $prdr/latex
set -g webdr $prdr/websites
set -g witdr $homedr/Documents/college
set -g bookdr $homedr/Documents/books
set -g obsdr "/Users/simonomi/Library/Mobile\\ Documents/iCloud\\~md\\~obsidian/Documents/main"
set -g cardr $swdr/carbonizer
set -g magedr $swdr/mage

alias plan "$VISUAL $prdr/daya/my\ lang\ planning.daya"

alias swpl "cd $homedr/Desktop; $VISUAL test.swift"

abbr -a u update

function update
	brew update-if-needed
	set output (brew bundle check) && echo $output || brew bundle install --verbose
	brew upgrade
	brew autoremove
	brew cleanup --scrub
end

alias ascii "cat $icldr/Documents/misc/ascii.txt"

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
abbr -a main "jj bookmark move main --to @"
abbr -a push "jj git push"

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

alias lorem "cat $homedr/Documents/misc/lorem\ ipsum.txt"
alias box "nvim -R $homedr/Documents/misc/box\ drawing\ characters.txt"

alias fixCursor "printf '\033[6 q'"

abbr -a xcodeFileTemplates 'cd "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates"'

# TODO: these are very slow and pretty unoptimal, but there doesn't seem to be a better way
# - brew info (brew list) would be *very slightly* faster, but would break with xargs and getting the right name
# - manually listing out brew --cellar kinda works, but that doesnt work for installed-only, and casks doesnt work because of symlinks
# - running du -shL on casks breaks bc calibre has an infinite loop
# - brew info --json --installed doesnt include sizes, or it'd be perfect
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

function brewNotInBundle
	nu -c "let bundle = brew bundle list --all | lines; (brew leaves) ++ \"\n\" ++ (brew list --casks) | lines | where \$it not-in \$bundle | collect | to text --no-newline"
end

function convertAllBmps
	for file in (fd --extension bmp)
		magick "$file" "$(path change-extension png $file)"
	end
end
