$env.config.show_banner = false
$env.config.rm.always_trash = true
# $env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.footer_mode = "auto"
$env.config.table.index_mode = "auto"
$env.config.datetime_format.normal = "%Y-%m-%d %H:%m:%S"
$env.config.filesize.unit = "binary"

source starship.nu
source zoxide.nu

# use std/util "path add"
# path add "~/.local/bin"

alias l = ls
# TODO: this should be an overlay instead of an alias? what about the rest?
alias h = help
alias e = explore
alias n = nvim
alias q = exit
alias map = each

# source cant be used in an alias :/
# alias reload = source $nu.config-path

