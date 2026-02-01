# per-OS stuff
switch (uname)
	case Darwin
		eval "$(/opt/homebrew/bin/brew shellenv)"
	case Linux
		eval "$(/home/linuxbrew/.linuxbrew/Homebrew/bin/brew shellenv)"
		export XDG_CONFIG_HOME="/home/simonomi/.config"
end

# path
fish_add_path ~/.rustup/toolchains/*/bin/
fish_add_path ~/.cargo/bin

# environment variables
export HOMEBREW_NO_ENV_HINTS=true
export EDITOR=hx
export VISUAL=$EDITOR
export LESS="--RAW-CONTROL-CHARS --incsearch --ignore-case --use-color --tabs=4"
export HOMEBREW_BUNDLE_FILE="~/Documents/dot config/brewfile"
export BACON_PREFS="/Users/simonomi/.config/bacon.toml"
export XDG_CONFIG_HOME="/Users/simonomi/.config"

# custom tool inits
if command -q starship
	starship init fish | source
end

if command -q zoxide
	zoxide init fish | source
end

# fish settings
set fish_greeting

# used to be blue, now white by default, i prefer blue
set fish_color_command blue

if status is-interactive
	tabs -4
end

bind / expand-abbr self-insert
bind \; expand-abbr self-insert
bind \- expand-abbr self-insert

# path variables
set --local dot_config_dir "~/Documents/dot\ config"

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

abbr --add cd z

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
abbr --add jp "jj push"
abbr --add jtp "jj tug && jj push"

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
alias git-visit "git remote get-url origin | $swdr/git\ ssh\ url\ to\ https.swift | xargs -r open"

abbr --add bi "brew install"
abbr --add be "brew bundle edit"

alias copy fish_clipboard_copy
alias paste fish_clipboard_paste

alias lorem "cat ~/Documents/misc/lorem\ ipsum.txt"
alias box "cat ~/Documents/misc/box\ drawing\ characters.txt"

abbr --add xcodeFileTemplates 'cd "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates"; fd -e swift'

abbr --add "ydl" "yt-dlp"

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
