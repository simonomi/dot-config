# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

fish_add_path ~/.cargo/bin
# pipx installs here
fish_add_path ~/.local/bin

source ~/.swiftly/env.fish
source ~/python_virtual_environment/bin/activate.fish

export HOMEBREW_NO_ENV_HINTS=true
export SHELL=/opt/homebrew/bin/fish
export EDITOR=nvim
export VISUAL=nvim
export LESS="--RAW-CONTROL-CHARS --incsearch --ignore-case --use-color"
export CARGO_MOMMYS_MOODS="chill/ominous/thirsty/yikes"
export CARGO_MOMMYS_PARTS="milk/cum/feet/fingers/tongue/ass"
export HOMEBREW_BUNDLE_FILE="~/Documents/dot config/brewfile"
export XDG_CONFIG_HOME="/Users/simonomi/.config"
export BACON_PREFS="/Users/simonomi/.config/bacon.toml"

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

alias frc "nvim $dot_config_dir/config.fish"
alias fishrc "nvim $dot_config_dir/config.fish"
alias src "source $dot_config_dir/config.fish"

alias nrc "nvim $dot_config_dir/nvim/init.vim"
alias nvimrc "nvim $dot_config_dir/nvim/init.vim"

alias nvimlua "nvim $dot_config_dir/nvim/nvim.lua"
alias nlua "nvim $dot_config_dir/nvim/nvim.lua"

alias hxrc "hx $dot_config_dir/helix/helix\ config.toml"
alias hrc "hx $dot_config_dir/helix/helix\ config.toml"

alias nurc "nvim $dot_config_dir/config.nu"

alias cd z

alias l "lsd --literal"
alias ll "lsd --literal --color always --almost-all --ignore-glob \".DS_Store\" --total-size --long --blocks date,size,name --sort size"

abbr -a opsw "open Package.swift"

# alias c "export CARGO_MOMMYS_ACTUAL=cargo; cargo-mommy"
# alias s "export CARGO_MOMMYS_ACTUAL=swift; cargo-mommy"
# alias j "export CARGO_MOMMYS_ACTUAL=jj; cargo-mommy"
alias b brew
alias c cargo
alias d "nvim -d"
alias g git
alias h hx
alias j jj
alias n nvim
alias s swift

alias kondo "kondo --default --ignored-dirs \$cardr"

# FIXME: once helix fixes its own cursor, delete this
function hx
	command hx $argv
	fix_cursor
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

alias plan "nvim -c \"normal G\\\$\" $prdr/my\ lang\ planning.swift"

alias swpl "cd $homedr/Desktop; nvim test.swift"

abbr -a u update

function update
	brew update
	brew bundle check || brew bundle install --verbose
	brew upgrade
	brew autoremove
	brew cleanup
end

alias ascii "cat $icldr/Documents/misc/ascii.txt"

alias hide "chflags hidden"
alias unhide "chflags nohidden"

alias python python3
alias jfmt "python $pydr/json_formatter.py"
alias :q exit
alias q exit

abbr -a js "j status"
abbr -a jd --set-cursor "j describe -m \"%\""
abbr -a jn --set-cursor "j new -m \"%\""
abbr -a jl "j log -r \"..\""

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

abbr -a bi "b install"
abbr -a be "b bundle edit"

alias copy fish_clipboard_copy
alias paste fish_clipboard_paste

alias lorem "cat $homedr/Documents/misc/lorem\ ipsum.txt"
alias box "nvim -R $homedr/Documents/misc/box\ drawing\ characters.txt"

alias fix_cursor "printf '\033[6 q'"

abbr -a xcode_file_templates 'cd "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates"'

function brew_size
	brew leaves | xargs -n1 -P8 -I {} fish -c "brew info {} | rg '[0-9]* files, ' | sed 's/^.*[0-9]* files, \\(.*\\)).*\$/{} \\1/'" | sort -h -r -k2 | column -t
end

function brew_size_all
	brew list | xargs -n1 -P8 -I {} fish -c "brew info {} | rg '[0-9]* files, ' | sed 's/^.*[0-9]* files, \\(.*\\)).*\$/{} \\1/'" | sort -h -r -k2 | column -t
end

function brew_not_in_bundle
	nu -c "let bundle = brew bundle list | lines; brew leaves | lines | where \$it not-in \$bundle | collect | to text --no-newline"
end

function convert_all_bmps
	for file in (l **.bmp)
		magick "$file" "$(string sub -e -4 $file).png"
	end
end

