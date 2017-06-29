set -gx global_abbreviations

test "reset global_abbreviations"
    0 = (count (gabbr))
end

test "gabbr -h"
    (count (gabbr -h)) -gt 0
end

gabbr G '| grep'

test "gabbr G '| grep'"
    "gabbr G '| grep'" = (gabbr | string join ":")
end

test "gabbr --list"
    "G" = (gabbr --list | string join ":")
end

gabbr L '| less'

test "gabbr L '| grep'"
    "gabbr G '| grep':gabbr L '| less'" = (gabbr | string join ":")
end

test "gabbr --list"
    "G:L" = (gabbr --list | string join ":")
end

gabbr -e G

test "gabbr -e G"
    "gabbr L '| less'" = (gabbr | string join ":")
end

test "gabbr --list"
    "L" = (gabbr --list | string join ":")
end

gabbr -e L
gabbr -f E 'echo DONE'

test "gabbr -f E 'echo DONE'"
    "gabbr E -f 'echo DONE'" = (gabbr | string join ":")
end
