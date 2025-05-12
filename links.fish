#!/opt/homebrew/bin/fish

link ~/Documents/dot\ config/config.fish ~/.config/fish/config.fish

mkdir ~/.config/nvim
link ~/Documents/dot\ config/init.vim ~/.config/nvim/init.vim
link ~/Documents/dot\ config/coc-settings.json ~/.config/nvim/coc-settings.json
mkdir -p ~/.config/nvim/syntax
link ~/Documents/dot\ config/dex.vim ~/.config/nvim/syntax/dex.vim
link ~/Documents/dot\ config/kbd.vim ~/.config/nvim/syntax/kbd.vim
link ~/Documents/dot\ config/my_hex.vim ~/.config/nvim/syntax/my_hex.vim
link ~/Documents/dot\ config/config.nu ~/Library/Application\ Support/nushell/config.nu
link ~/Documents/dot\ config/jj\ config.toml ~/.config/jj/config.toml

