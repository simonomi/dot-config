#!/opt/homebrew/bin/fish

set --local tinyStartChanges "$(diff --color=always tinystart.toml ~/.config/tinystart/settings.toml)"
set --local xcodeChanges "$(diff --color=always xcode.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings)"
set --local iinaChanges "$(diff --color=always iina.conf ~/Library/Application\ Support/com.colliderli.iina/input_conf/iina.conf)"

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

if test -n "$tinyStartChanges$xcodeChanges$iinaChanges"
	read --prompt-str "do you want to save these changes? (y/N): " --local saveChanges
	
	switch $saveChanges
		case Y y
			cp ~/.config/tinystart/settings.toml tinystart.toml
			cp ~/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings xcode.idekeybindings
			cp ~/Library/Application\ Support/com.colliderli.iina/input_conf/iina.conf iina.conf
		case "" N n
			return 1
	end
end
