#!/opt/homebrew/bin/fish

set --local tinyStartChanges "$(diff --color=always tinystart.toml ~/.config/tinystart/settings.toml)"
set --local xcodeChanges "$(diff --color=always xcode.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings)"
set --local iinaChanges "$(diff --color=always iina.conf ~/Library/Application\ Support/com.colliderli.iina/input_conf/iina.conf)"
set --local prismChanges "$(diff --color=always prismlauncher.cfg ~/Library/Application\ Support/PrismLauncher/prismlauncher.cfg)"

if test -n "$tinyStartChanges"
	echo -s (set_color --bold) "TinyStart:" (set_color normal)
	echo "$tinyStartChanges"
end

if test -n "$xcodeChanges"
	echo -s (set_color --bold) "Xcode:" (set_color normal)
	echo "$xcodeChanges"
end

if test -n "$iinaChanges"
	echo -s (set_color --bold) "IINA:" (set_color normal)
	echo "$iinaChanges"
end

if test -n "$prismChanges"
	echo -s (set_color --bold) "Prism Launcher:" (set_color normal)
	echo "$prismChanges"
end

if test -n "$tinyStartChanges$xcodeChanges$iinaChanges$prismChanges"
	read --prompt-str "do you want to save these changes? (y/N): " --local saveChanges
	
	switch $saveChanges
		case Y y
			cp ~/.config/tinystart/settings.toml tinystart.toml
			cp ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings xcode.idekeybindings
			cp ~/Library/Application\ Support/com.colliderli.iina/input_conf/iina.conf iina.conf
			cp ~/Library/Application\ Support/PrismLauncher/prismlauncher.cfg prismlauncher.cfg
		case "" N n
			return 1
	end
end
