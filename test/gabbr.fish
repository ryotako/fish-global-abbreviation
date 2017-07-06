function setup
    set -g global_abbreviations
end

test "add an abbreviation"
    "G" = (
        gabbr --add G '| grep'
        gabbr --list
        )
end

test "count abbreviations"
    1 = (count (
        gabbr --add G '| grep'
        gabbr --list
        ))
end

test "erase an abbreviation"
    0 = (count (
        gabbr --add G '| grep'
        gabbr --erase G
        gabbr --list
        ))
end

test "show abbreviations"
    "gabbr G '| grep'" "gabbr L '| less'" = (
        gabbr --add G '| grep'
        gabbr --add L '| less'
        gabbr --show
        )
end

test "list abbreviations"
    G L = (
        gabbr --add G '| grep'
        gabbr --add L '| less'
        gabbr --list
        )
end


test "add function abbreviations"
    "gabbr E -f 'echo expanded'" = (
        gabbr --function E 'echo expanded'
        gabbr --show
        )
end


test "reload abbereviations"
    G = (set -g gabbr_config (dirname (realpath $FILENAME))"/.gabbr.config"
        echo "G | grep" > "$gabbr_config"
        gabbr --reload
        gabbr --list
        rm "$gabbr_config"
        )
end
