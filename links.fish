#!/opt/homebrew/bin/fish

ln -sfw "$(pwd)/config.fish" ~/.config/fish/config.fish

mkdir -p ~/.config/nvim/syntax
mkdir -p ~/.config/nvim/lua/config
mkdir -p ~/.config/nvim/lua/plugins
ln -sfw "$(pwd)/nvim/init.vim" ~/.config/nvim/init.vim
ln -sfw "$(pwd)/nvim/nvim.lua" ~/.config/nvim/nvim.lua
ln -sfw "$(pwd)/nvim/lazy.lua" ~/.config/nvim/lua/config/lazy.lua
ln -sfw "$(pwd)/nvim/plugins.lua" ~/.config/nvim/lua/plugins/plugins.lua
ln -sfw "$(pwd)/nvim/coc-settings.json" ~/.config/nvim/coc-settings.json
ln -sfw "$(pwd)/nvim/syntax/dex.vim" ~/.config/nvim/syntax/dex.vim
ln -sfw "$(pwd)/nvim/syntax/kbd.vim" ~/.config/nvim/syntax/kbd.vim
ln -sfw "$(pwd)/nvim/syntax/my_hex.vim" ~/.config/nvim/syntax/my_hex.vim

mkdir -p ~/.config/nushell
ln -sfw "$(pwd)/nushell/config.nu" ~/.config/nushell/config.nu
ln -sfw "$(pwd)/nushell/starship.nu" ~/.config/nushell/starship.nu
ln -sfw "$(pwd)/nushell/zoxide.nu" ~/.config/nushell/zoxide.nu

mkdir -p ~/.config/jj
ln -sfw "$(pwd)/jj config.toml" ~/.config/jj/config.toml

mkdir -p ~/.config/helix/themes
ln -sfw "$(pwd)/helix/helix config.toml" ~/.config/helix/config.toml
ln -sfw "$(pwd)/helix/helix_theme.toml" ~/.config/helix/themes/helix_theme.toml

ln -sfw "$(pwd)/starship.toml" ~/.config/starship.toml

ln -sfw "$(pwd)/bacon.toml" ~/.config/bacon.toml

mkdir -p ~/.config/macchina
ln -sfw "$(pwd)/macchina.toml" ~/.config/macchina/macchina.toml

# TODO: remove original espanso path in application support?
mkdir -p ~/.config/espanso
for file in espanso/**.*;
	mkdir -p ~/.config/(dirname $file)
	ln -sfw "$(pwd)/$file" ~/.config/$file
end

