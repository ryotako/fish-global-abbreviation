function setup
    set -g global_abbreviations
end

@test "add an abbreviation" (
    gabbr --add G '| grep'
    gabbr --list
) = "G"

@test "count abbreviations" (
    count (
        gabbr --add G '| grep'
        gabbr --list
    )
) -eq 1

@test "erase an abbreviation" (
    count (
        gabbr --add G '| grep'
        gabbr --erase G
        gabbr --list
    )
) -eq 0

@test "show abbreviations" (
    gabbr --add G '| grep'
    gabbr --add L '| less'
    gabbr --show
) = "gabbr G '| grep'" "gabbr L '| less'"

@test "list abbreviations" (
    gabbr --add G '| grep'
    gabbr --add L '| less'
    gabbr --list
) = G L

@test "add function abbreviations" (
    gabbr --function E 'echo expanded'
    gabbr --show
) = "gabbr E -f 'echo expanded'"

@test "reload abbereviations" (
    set -g gabbr_config $current_dirname/.gabbr.config
    echo "G | grep" > "$gabbr_config"
    gabbr --reload
    gabbr --list
    rm "$gabbr_config"
) = G

@test 'reload abbereviations when $global_abbreviations is not set' (
    unset global_abbreviations
    set -g gabbr_config $current_dirname/.gabbr.config
    echo "F | fzf" > "$gabbr_config"
    fish -c "set -g gabbr_config $gabbr_config && gabbr --reload"
    gabbr --list
    rm "$gabbr_config"
) = F

@test "add suffix alias" (
    gabbr --suffix py python
    gabbr --show
) = "gabbr py -x python"
