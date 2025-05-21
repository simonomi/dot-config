#!/opt/homebrew/bin/fish

link config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/nvim/syntax
link nvim/init.vim ~/.config/nvim/init.vim
link nvim/nvim.lua ~/.config/nvim/nvim.lua
link nvim/coc-settings.json ~/.config/nvim/coc-settings.json
link nvim/syntax/dex.vim ~/.config/nvim/syntax/dex.vim
link nvim/syntax/kbd.vim ~/.config/nvim/syntax/kbd.vim
link nvim/syntax/my_hex.vim ~/.config/nvim/syntax/my_hex.vim

# TODO: change this path
mkdir -p ~/.config/nushell
link config.nu ~/.config/nushell/config.nu

mkdir -p ~/.config/jj
link jj\ config.toml ~/.config/jj/config.toml

mkdir -p ~/.config/helix/themes
link helix/helix\ config.toml ~/.config/helix/config.toml
link helix/helix_theme.toml ~/.config/helix/themes/helix_theme.toml

