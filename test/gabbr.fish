function setup
    set -g global_abbreviations
end

test "add an abbreviation"
    "G" = (gabbr --add G '| grep'
        gabbr --list)
end

test "count abbreviations"
    1 = (count (gabbr --add G '| grep'
        gabbr --list))
end

test "erase an abbreviation"
    0 = (count (gabbr --add G '| grep'
        gabbr --erase G
        gabbr --list))
end
