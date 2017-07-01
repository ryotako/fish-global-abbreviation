#
# setup
#

## backups
set -q global_abbreviations
and set -l __global_abbreviations $global_abbreviations
set -q gabbr_config
and set -l __gabbr_config $gabbr_config

## variable preparation
set global_abbreviations
set gabbr_config (dirname (status current-filename))"/.gabbr.config"
set -l __gabbr_test_count 0
set -l __gabbr_fail_count 0

function __gabbr_test -S -a expected recieved msg
    set __gabbr_test_count (math $__gabbr_test_count + 1)

    if test "$expected" = "$recieved"
        echo "ok $__gabbr_test_count $msg"
    else
        set __gabbr_fail_count (math $__gabbr_fail_count + 1)
        echo "not ok $__gabbr_test_count $msg"
        echo "    expected: $expected"
        echo "    recieved: $recieved"
    end
end

#
# test
#

__gabbr_test 0 (count (gabbr)) "reset abbreviations"

gabbr G '| grep'

__gabbr_test "gabbr G '| grep'" (gabbr | string join ':') \
    "add an abbreviation: G '| grep'"

gabbr L '| less'

__gabbr_test "gabbr G '| grep':gabbr L '| less'" \
    (gabbr | string join ':') \
    "add one more abbreviation: L '| less'"

__gabbr_test "G:L" (gabbr --list | string join ':') \
    "list names of abbreviations"

gabbr -e L

__gabbr_test "gabbr G '| grep'" (gabbr | string join ':') \
    "erase an abbreviation: L"

gabbr -e G
__gabbr_test 0 (count (gabbr)) "erase all abbreviations"

gabbr B -f 'git symbolic-ref --short HEAD'

__gabbr_test "gabbr B -f 'git symbolic-ref --short HEAD'" \
    (gabbr | string join ':') \
    "add function abbreviation"

#
# teardown
#

set global_abbreviations $__global_abbreviations
set gabbr_config $__gabbr_config

if test "$__gabbr_test_count" -gt 0
    echo
    echo "1..$__gabbr_test_count"
    echo "# tests $__gabbr_test_count"
    echo "# pass  "(math $__gabbr_test_count - $__gabbr_fail_count)
    echo "# fail  $__gabbr_fail_count"
    if test "$__gabbr_fail_count" -eq 0
        echo
        echo "# ok"
    end
end

if test "$__gabbr_fail_count" -gt 0
    exit 1
end

