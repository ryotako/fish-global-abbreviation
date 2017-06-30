
function setup
    set -gx global_abbreviations
end

test "reset global_abbreviations"
    0 = (count (gabbr))
end

test "gabbr -h"
    (count (gabbr -h)) -gt 0
end

test "gabbr G '| grep'"
    "gabbr G '| grep'" = (gabbr G '| grep' ; and gabbr | string join ":")
end

test "gabbr --list"
    "G" = (gabbr G '| grep' ; and gabbr --list | string join ":")
end

test "gabbr L '| less'"
    "gabbr G '| grep':gabbr L '| less'" = (\
        gabbr G '| grep' \
        ; and gabbr L '| less' \
        ; and gabbr | string join ":")
end

test "gabbr --list"
    "G:L" = (\
        gabbr G '| grep' \
        ; gabbr L '| less' \
        ; gabbr --list | string join ":")
end

test "gabbr -e G"
    "gabbr L '| less'" = (\
        gabbr G '| grep' \
        ; and gabbr L '| less' \
        ; and gabbr -e G \
        ; and gabbr | string join ":")
end

test "gabbr --list"
    "L" = (\
        gabbr G '| grep' \
        ; and gabbr L '| less' \
        ; and gabbr -e G \
        ; and gabbr --list | string join ":")
end

test "gabbr -f E 'echo DONE'"
    "gabbr E -f 'echo DONE'" = (\
        gabbr -f E 'echo DONE' ; and gabbr | string join ":")
end
