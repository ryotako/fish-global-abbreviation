if set -q TAP_VERSION
    echo "#"
    echo "# Fishtape is unavailable for __gabbr_expand.fish,"
    echo "# because these test requires an interactive mode shell."
    echo "#"
    echo "# Run `source test/__gabbr_expand.fish` directly."
    echo "#"
    exit
end

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

function __gabbr_expand_test -S -a preset expected
    set __gabbr_test_count (math $__gabbr_test_count + 1)

    commandline "$preset"
    __gabbr_expand

    set -l recieved (commandline)
    if test "$expected" = "$recieved"
        echo "ok $__gabbr_test_count $preset -> $recieved"
    else
        set __gabbr_fail_count (math $__gabbr_fail_count + 1)
        echo "not ok $__gabbr_test_count $preset"
        echo "    expected: $expected"
        echo "    recieved: $recieved"
    end

    commandline ""
end

#
# tests
#

gabbr L '| less'
__gabbr_expand_test "gabbr -h L" "gabbr -h | less"
__gabbr_expand_test "LL" "LL"

gabbr -e L
__gabbr_expand_test "gabbr -h L" "gabbr -h L"

gabbr D -f 'echo DONE'
__gabbr_expand_test 'D' 'DONE'

gabbr py -x python
__gabbr_expand_test 'test.py' 'python test.py'

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

