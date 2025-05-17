#!/opt/homebrew/bin/fish

link config.fish ~/.config/fish/config.fish

mkdir ~/.config/nvim
link init.vim ~/.config/nvim/init.vim
link coc-settings.json ~/.config/nvim/coc-settings.json
mkdir -p ~/.config/nvim/syntax
link dex.vim ~/.config/nvim/syntax/dex.vim
link kbd.vim ~/.config/nvim/syntax/kbd.vim
link my_hex.vim ~/.config/nvim/syntax/my_hex.vim

# TODO: change this path
link config.nu ~/Library/Application\ Support/nushell/config.nu

mkdir -p ~/.config/jj
link jj\ config.toml ~/.config/jj/config.toml

mkdir -p ~/.config/helix/themes
link helix\ config.toml ~/.config/helix/config.toml
link helix_theme.toml ~/.config/helix/themes/helix_theme.toml

