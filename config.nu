$env.config.show_banner = false
$env.config.rm.always_trash = true
# $env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.footer_mode = "auto"
$env.config.table.index_mode = "auto"
$env.config.datetime_format.normal = "%Y-%m-%d %H:%m:%S"
$env.config.filesize.unit = "binary"

# get color code for pwd
# pwd --physical | cksum | split words | first | into int | format number | get upperhex | str substring 2... | fill --alignment left --character 0 --width 6
# TODO: shorten path with ~ and single-letter directory names

$env.PROMPT_COMMAND = {|| fish -c "fish_prompt" }
$env.PROMPT_INDICATOR = ""
$env.PROMPT_COMMAND_RIGHT = {||
	let lastCommandDuration = $env.CMD_DURATION_MS
		| into int
		| into duration --unit ms
	
	let commandDurationLabel = if $lastCommandDuration >= 0.1sec {
		let duration = $lastCommandDuration
			| format duration sec
			| str replace " sec" "s"
		
		$"(ansi reset)($duration) "
	} else {
		""
	}
	
	let currentTime = date now | format date "%H:%m:%S"
	
	$"($commandDurationLabel)(ansi grey)($currentTime)(ansi reset)"
}
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = null

# use std/util "path add"
# path add "~/.local/bin"

alias l = ls
# TODO: this should be an overlay instead of an alias? what about the rest?
alias h = help
alias e = explore
alias map = each
