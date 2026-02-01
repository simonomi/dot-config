#!/home/linuxbrew/.linuxbrew/bin/fish

ln -sf "$(pwd)/config.fish" ~/.config/fish/config.fish

mkdir -p ~/.config/nvim/syntax
mkdir -p ~/.config/nvim/lua/plugins
ln -sf "$(pwd)/nvim/init.vim" ~/.config/nvim/init.vim
ln -sf "$(pwd)/nvim/nvim.lua" ~/.config/nvim/nvim.lua
ln -sf "$(pwd)/nvim/plugins.lua" ~/.config/nvim/lua/plugins/plugins.lua
ln -sf "$(pwd)/nvim/coc-settings.json" ~/.config/nvim/coc-settings.json
for file in (ls "$(pwd)/nvim/syntax")
	ln -sf "$(pwd)/nvim/syntax/$file" ~/.config/nvim/syntax/$file
end

mkdir -p ~/.config/nushell
ln -sf "$(pwd)/nushell/config.nu" ~/.config/nushell/config.nu
ln -sf "$(pwd)/nushell/starship.nu" ~/.config/nushell/starship.nu
ln -sf "$(pwd)/nushell/zoxide.nu" ~/.config/nushell/zoxide.nu

mkdir -p ~/.config/jj
ln -sf "$(pwd)/jj config.toml" ~/.config/jj/config.toml

mkdir -p ~/.config/helix/themes
mkdir -p ~/.config/helix/runtime/queries/dex
ln -sf "$(pwd)/helix/helix config.toml" ~/.config/helix/config.toml
ln -sf "$(pwd)/helix/languages.toml" ~/.config/helix/languages.toml
ln -sf "$(pwd)/helix/helix_theme.toml" ~/.config/helix/themes/helix_theme.toml
for file in helix/queries/*.scm;
	mkdir -p ~/.config/helix/runtime/queries/(basename -s .scm $file)/
	ln -sf "$(pwd)/$file" ~/.config/helix/runtime/queries/(basename -s .scm $file)/highlights.scm
end

ln -sf "$(pwd)/starship.toml" ~/.config/starship.toml

ln -sf "$(pwd)/bacon.toml" ~/.config/bacon.toml

mkdir -p ~/.config/macchina
ln -sf "$(pwd)/macchina.toml" ~/.config/macchina/macchina.toml

mkdir -p ~/.config/rustfmt
ln -sf "$(pwd)/rustfmt.toml" ~/.config/rustfmt/rustfmt.toml

ln -sf "$(pwd)/gitconfig" ~/.gitconfig

# TODO: remove original espanso path in application support?
mkdir -p ~/.config/espanso
for file in espanso/**.*;
	mkdir -p ~/.config/(dirname $file)
	ln -sf "$(pwd)/$file" ~/.config/$file
end

if test -e ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings
	cp "$(pwd)/xcode.idekeybindings" ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings
end
