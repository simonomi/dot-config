#!/opt/homebrew/bin/fish

ln -fw config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/nvim/syntax
ln -fw nvim/init.vim ~/.config/nvim/init.vim
ln -fw nvim/nvim.lua ~/.config/nvim/nvim.lua
ln -fw nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -fw nvim/syntax/dex.vim ~/.config/nvim/syntax/dex.vim
ln -fw nvim/syntax/kbd.vim ~/.config/nvim/syntax/kbd.vim
ln -fw nvim/syntax/my_hex.vim ~/.config/nvim/syntax/my_hex.vim

mkdir -p ~/.config/nushell
ln -fw config.nu ~/.config/nushell/config.nu

mkdir -p ~/.config/jj
ln -fw jj\ config.toml ~/.config/jj/config.toml

mkdir -p ~/.config/helix/themes
ln -fw helix/helix\ config.toml ~/.config/helix/config.toml
ln -fw helix/helix_theme.toml ~/.config/helix/themes/helix_theme.toml

ln -fw starship.toml ~/.config/starship.toml
