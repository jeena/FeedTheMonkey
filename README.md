
# FeedTheMonkey

<img align=right src="http://jeena.net/feedthemonkey/feedthemonkey-icon.png" width='256' alt='Icon'>

FeedTheMonkey is a desktop client for [TinyTinyRSS](http://tt-rss.org). That means that
it doesn't work as a standalone feed reader but only as a client for the TinyTinyRSS API
which it uses to get the normalized feeds and to synchronize the "article read" marks.

It is written in Rust and GTK. You need to have an account on a TinyTinyRSS server.

## Installation

TBD

## Keyboard shortcuts

The keyboard shortcuts are inspired by other feed readers which are inspired by the text editor vi.

`j` or `→` show nex article  
`k` or `←` show previous article  
`n` or `Return` open current article in the default browser  
`r` reload articles  
`F11` full screen  
`1` night mode  
`Ctrl Q` quit  
`Ctrl +` zoom in  
`Ctrl -` zoom out  
`Ctrl 0` reset zoom  

## Trivia

This is version 3 of FeedTheMonkey, you can find version 1 which was written
in PyQt in the v1 branch of this repo and version 2 which was written in C++
and Qt/QML in the v2 branch.

## Screenshot

![Feed the Monkey screenshot](http://jeena.net/feedthemonkey/feedthemonkey-dark.png)

## License

This file is part of FeedTheMonkey.

Copyright 2020 Jeena

FeedTheMonkey is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

FeedTheMonkey is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with FeedTheMonkey. If not, see <http://www.gnu.org/licenses/>.
