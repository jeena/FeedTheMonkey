# Feed the Monkey

Feed the Monkey is a desktop client for [TinyTinyRSS](http://tt-rss.org). That means that it doesn't work as a standalone feed reader but only as a client for the TinyTinyRSS API which it uses to get the normalized feeds and to synchronize the "article read" marks.

It is written in PyQt and uses Webkit to show the contents.

## Installation

You need to have PyQt installed and a account on a TinyTinyRSS instance.

Download the [ZIP](https://github.com/jeena/feedthemonkey/archive/master.zip)-file, unzip it and then run:

`sudo python setup.py install`

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

## Trivia

I just hacked together this one within one day so it is not feature complete yet and has no real error handling.

Right now it only loads unread articles and shows them one after another. I might add a sidebar in the future, we will see.

## Screenshot

![Feed the Monkey screenshot](http://jabs.nu/feedthemonkey/feedthemonkey-screenshot.png)
![Feed the Monkey icon](http://jabs.nu/feedthemonkey/feedthemonkey-icon.png)