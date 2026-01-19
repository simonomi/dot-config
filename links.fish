#!/opt/homebrew/bin/fish

ln -sfw "$(pwd)/config.fish" ~/.config/fish/config.fish

mkdir -p ~/.config/nvim/syntax
mkdir -p ~/.config/nvim/lua/plugins
ln -sfw "$(pwd)/nvim/init.vim" ~/.config/nvim/init.vim
ln -sfw "$(pwd)/nvim/nvim.lua" ~/.config/nvim/nvim.lua
ln -sfw "$(pwd)/nvim/plugins.lua" ~/.config/nvim/lua/plugins/plugins.lua
ln -sfw "$(pwd)/nvim/coc-settings.json" ~/.config/nvim/coc-settings.json
for file in (ls "$(pwd)/nvim/syntax")
	ln -sfw "$(pwd)/nvim/syntax/$file" ~/.config/nvim/syntax/$file
end

mkdir -p ~/.config/nushell
ln -sfw "$(pwd)/nushell/config.nu" ~/.config/nushell/config.nu
ln -sfw "$(pwd)/nushell/starship.nu" ~/.config/nushell/starship.nu
ln -sfw "$(pwd)/nushell/zoxide.nu" ~/.config/nushell/zoxide.nu

mkdir -p ~/.config/jj
ln -sfw "$(pwd)/jj config.toml" ~/.config/jj/config.toml

mkdir -p ~/.config/helix/themes
mkdir -p ~/.config/helix/runtime/queries/dex
ln -sfw "$(pwd)/helix/helix config.toml" ~/.config/helix/config.toml
ln -swf "$(pwd)/helix/languages.toml" ~/.config/helix/languages.toml
ln -sfw "$(pwd)/helix/helix_theme.toml" ~/.config/helix/themes/helix_theme.toml
for file in helix/queries/*.scm;
	mkdir -p ~/.config/helix/runtime/queries/(basename -s .scm $file)/
	ln -sfw "$(pwd)/$file" ~/.config/helix/runtime/queries/(basename -s .scm $file)/highlights.scm
end

ln -sfw "$(pwd)/starship.toml" ~/.config/starship.toml

ln -sfw "$(pwd)/bacon.toml" ~/.config/bacon.toml

mkdir -p ~/.config/macchina
ln -sfw "$(pwd)/macchina.toml" ~/.config/macchina/macchina.toml

mkdir -p ~/.config/rustfmt
ln -swf "$(pwd)/rustfmt.toml" ~/.config/rustfmt/rustfmt.toml

ln -sfw "$(pwd)/gitconfig" ~/.gitconfig

# TODO: remove original espanso path in application support?
mkdir -p ~/.config/espanso
for file in espanso/**.*;
	mkdir -p ~/.config/(dirname $file)
	ln -sfw "$(pwd)/$file" ~/.config/$file
end

if test -e ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings
	cp "$(pwd)/xcode.idekeybindings" ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings
end
