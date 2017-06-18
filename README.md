# fish-global-abbreviation

[![Slack Room][slack-badge]][slack-link]

Global abbreviation for fish shell

![demo.gif](demo.gif)

## Install

With [fisherman]

```
fisher ryotako/fish-global-abbreviation
```

## Usage

```fish
# add abbreviation
gabbr G '| grep'
gabbr (-a|--add) G '| grep'

# show abbreviation
gabbr
gabbr (-s|--show)

# list abbreviation names
gabbr (-l|--list)

# erase abbreviation
gabbr (-e|--erase)

# add function-abbreviation
# Function-abbreviations are evaluated when they are expanded.
gabbr (-f|--function) D 'date +%Y/%m/%d'
```

[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
