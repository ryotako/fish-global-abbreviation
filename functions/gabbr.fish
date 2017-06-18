function gabbr -d 'Global abbreviation for fish'

    # parse options
    set -l opts
    set -l args
    while count $argv >/dev/null
        switch $argv[1]
            case -{a,f,s,l,e} --{add,function,show,list,erase}
                set opts $opts $argv[1]

            case -h --help
                string trim "
Name: gabbr - Global abbreviation for fish shell

Usage:
    gabbr [options] WORD PHRASE

Options:
    -a, --add       Add abbreviation
    -e, --erase     Erase abbreviation
    -f, --function  Add function-abbreviation
    -l, --list      Print all abbreviation names
    -s, --show      Print all abbreviations
    -h, --help      Help
"
                return
            case '--'
                if set -q argv[2]
                    set args $args $argv[2]
                    set -e $argv[2]
                end
            case '-*'
                echo "$_: invalid option -- $argv[1]" >&2
            case '*'
                set args $args $argv[1]
        end

        set -e argv[1]
    end

    # check option-conflict
    if test (count $opts) -gt 1
        echo "$_: $opts[2] cannot be specified along with $opts[1]" >&2
        return 1
    else if not count $opts >/dev/null
        # default behavior
        count $args >/dev/null
        and set opts '--add'
        or set opts '--show'
    end

    # execute
    switch $opts
        case -a --add -f --function
            # argument number check
            if test (count $args) -lt 2
                echo "$_: abbreviation must have a value" >&2
                return 1
            end

            # key value check
            if string match '* *' "$args[1]"
                echo "$_: abbreviation cannot have spaces in the key" >&2
                return 1
            end
          
            # erase abbreviations
            gabbr --erase "$args[1]" ^/dev/null

            # use a global variable as default
            if not set -q global_abbreviations
                set -U global_abbreviations
            end

            # add an abbreviation
            switch $opts
                case -a --add
                    set global_abbreviations $global_abbreviations "$args"
                case -f --function
                    set global_abbreviations $global_abbreviations "$args[1] -f $args[2..-1]"
            end

        case -l --list
            # argument number check
            if count $args >/dev/null
                echo "$_: unexpected argument -- $args[1]" >&2
                return 1
            end

            # list words
            for abbr in $global_abbreviations
                echo $abbr | read -l word _
                echo "$word"
            end

        case -s --show
            # argument number check
            if count $args >/dev/null
                echo "$_: unexpected argument -- $args[1]" >&2
                return 1
            end

            for abbr in $global_abbreviations
                echo $abbr | read -l word phrase
                if string match -q -- '-f *' $phrase
                    echo "gabbr $word -f "(string sub -s 4 -- $phrase | string escape)
                else
                    echo "gabbr $word "(string escape -- $phrase)
                end
            end

        case -e --erase
            if contains "$args[1]" (gabbr --list)
                for i in (seq (count $global_abbreviations) 1)
                    echo "$global_abbreviations[$i]" | read word _
                    if test "$word" = "$args[1]"
                        set -e global_abbreviations[$i]
                    end
                end
            else
                echo "$_: no such abbreviation '$args[1]'" >&2
            end
    end
end
