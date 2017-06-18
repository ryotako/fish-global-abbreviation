function __gabbr_expand

    # expand abbreviations
    if test 0 = (count (commandline -poc))
        for abbr in $fish_user_abbreviations
            echo $abbr | read word phrase
            if test "$word" = (commandline -t)
                commandline -t $phrase
            end
        end
    end

    # expand global abbreviations
    for abbr in $global_abbreviations
        echo $abbr | read word phrase
        if test "$word" = (commandline -t)
            commandline -t $phrase
        end
    end

end

