#!/usr/bin/fish

ln -f config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/nvim/syntax
ln -f nvim/init.vim ~/.config/nvim/init.vim
ln -f nvim/nvim.lua ~/.config/nvim/nvim.lua
ln -f nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -f nvim/syntax/dex.vim ~/.config/nvim/syntax/dex.vim
ln -f nvim/syntax/kbd.vim ~/.config/nvim/syntax/kbd.vim
ln -f nvim/syntax/my_hex.vim ~/.config/nvim/syntax/my_hex.vim

mkdir -p ~/.config/nushell
ln -f config.nu ~/.config/nushell/config.nu

mkdir -p ~/.config/jj
ln -f jj\ config.toml ~/.config/jj/config.toml

mkdir -p ~/.config/helix/themes
ln -f helix/helix\ config.toml ~/.config/helix/config.toml
ln -f helix/helix_theme.toml ~/.config/helix/themes/helix_theme.toml

ln -f starship.toml ~/.config/starship.toml

# TODO: remove original espanso path in application support?
mkdir -p ~/.config/espanso/config
mkdir -p ~/.config/espanso/match
ln -f espanso/config/default.yml ~/.config/espanso/config/default.yml
ln -f espanso/match/base.yml ~/.config/espanso/match/base.yml

