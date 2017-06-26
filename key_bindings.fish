if not set -q gabbr_config
    set -U gabbr_config "$HOME/.config/fish/.gabbr.conf"
    set -q XDG_CONFIG_HOME
    and set gabbr_config "$XDG_CONFIG_HOME/fish/.gabbr.conf"
end
bind ' ' '__gabbr_expand; commandline -i " "'
