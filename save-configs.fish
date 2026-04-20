#!/opt/homebrew/bin/fish

echo -s (set_color --bold) "TinyStart:" (set_color normal)
diff tinystart.toml ~/.config/tinystart/settings.toml
echo

echo -s (set_color --bold) "Xcode:" (set_color normal)
diff xcode.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings
echo

read --prompt-str "do you want to save these changes? (y/N): " --local saveChanges

switch $saveChanges
	case Y y
		cp ~/.config/tinystart/settings.toml tinystart.toml
		cp ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings xcode.idekeybindings
	case "" N n
		return 0
end

