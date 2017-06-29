begin
    #
    # utility for testing
    #
    set -l global_abbreviations
    set -l __gabbr_test_count 0
    function __gabbr_test -S -a preset want
        set __gabbr_test_count (math $__gabbr_test_count + 1)

        commandline "$preset"
        __gabbr_expand

        set -l got (commandline)
        if test "$want" = "$got"
            echo -n (set_color green)"ok"(set_color normal)
            echo " $__gabbr_test_count $preset -> $got"
        else
            echo -n (set_color red)"not ok"(set_color normal)
            echo " $__gabbr_test_count $preset"
            echo "    want: $want"
            echo "    got : $got"
        end

        commandline ""
    end


    #
    # test
    #
    gabbr L '| less'
    __gabbr_test "gabbr -h L" "gabbr -h | less"
    __gabbr_test "LL" "LL"


    gabbr -e L
    __gabbr_test "gabbr -h L" "gabbr -h L"

    gabbr D -f 'echo DONE'
    __gabbr_test 'D' 'DONE'
end
