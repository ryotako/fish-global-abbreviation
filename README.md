# fish-global-abbreviation

[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

global abbreviation for fish shell

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
# Function-abbreviations are evaluated when it is expanded.
gabbr (-f|--function) D 'date +%Y/%m/%d'
```

[travis-link]: https://travis-ci.org/ryotako/fish-global-abbreviation
[travis-badge]: https://img.shields.io/travis/ryotako/fish-global-abbreviation.svg
[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
