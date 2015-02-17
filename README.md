<img align=right src="http://jabs.nu/feedthemonkey/feedthemonkey-icon.png" width='256' alt='Icon'>

# Feed the Monkey

Feed the Monkey is a desktop client for [TinyTinyRSS](http://tt-rss.org). That means that
it doesn't work as a standalone feed reader but only as a client for the TinyTinyRSS API
which it uses to get the normalized feeds and to synchronize the "article read" marks.

It is written in C++ with Qt and QML, it also uses WebKit to show the contents.

You need to have Qt 5.4 installed be able to compile and have a account on a TinyTinyRSS server.
This version 2 is still in a early stage so there are no binaries available yet but will be
as soon as I figure out how to package and distribute them.

License: BSD

## Installation

Clone the repo, install the Qt 5.4 SDK on your computer and use QtCreator to compile and run it.

## Keyboard shortcuts

The keyboard shortcuts are inspired by other feed readers which are inspired by the text editor vi.

`j` or `→` show nex article  
`k` or `←` show previous article  
`n` or `Return` open current article in the default browser  
`r` reload articles  
`Ctrl Q` quit  
`Ctrl +` zoom in  
`Ctrl -` zoom out  
`Ctrl 0` reset zoom

On OS X use `Cmd` instead of `Ctrl`.

## Trivia

This is version 2 of FeedTheMonkey, you can find version 1 which was written in PyQt in the v1 branch
of this repo. My goal is to make this usable on many different targets, for now it is only for
the use on a desktop computer but I'd like to see it on a mobile device too.

## Screenshot

![Feed the Monkey screenshot](http://jabs.nu/feedthemonkey/screenshot.png)