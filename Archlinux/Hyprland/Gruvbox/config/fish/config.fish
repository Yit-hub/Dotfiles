set -g fish_greeting
fastfetch
if status is-interactive
    # Commands to run in interactive sessions can go here

end
#Starship
starship init fish | source

#Zoxide
zoxide init fish | source

#Alias
alias c="clear"

fish_add_path /home/yi/.spicetify

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#editor
export EDITOR=nvim

#FZF
fzf --fish | source

set -Ux HYPRSHOT_DIR ~/Pictures/Screenshots/
