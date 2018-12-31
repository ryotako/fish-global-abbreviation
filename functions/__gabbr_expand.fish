function __gabbr_expand

    if test (string trim (commandline -b)) = ''
        return
    end

    # expand abbreviations
    if test 0 = (count (commandline -poc))
        for word in (abbr -l)
            if test "$word" = (commandline -t)
                set escaped_word (string escape --style=var -- $word)
                set phrase "_fish_abbr_$escaped_word"
                commandline -t $$phrase
            end
        end
    end

    # expand global abbreviations
    for abbr in $global_abbreviations
        echo $abbr | read word phrase

        if string match -q -- "*.$word" (commandline -t)
            if string match -q -- '-x *' $phrase
                set -l file (commandline -t)
                if test 0 = (count (commandline -poc))
                    set -l cmd (string sub -s 4 -- $phrase)
                    commandline -t "$cmd $file"
                end
            end
        else if test "$word" = (commandline -t)
            if string match -q -- '-x *' $phrase
                # do nothing
            else if string match -q -- '-f *' $phrase
                # --function option
                set -l cmd (string sub -s 4 -- $phrase)
                eval $cmd ^/dev/null | string join ' ' | read -l buf
                and commandline -t $buf
            else
                commandline -t $phrase
            end
        end
    end

end

