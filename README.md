<img align=right src="http://jabs.nu/feedthemonkey/feedthemonkey-icon.png" width='256' alt='Icon'>

# Feed the Monkey

Feed the Monkey is a desktop client for [TinyTinyRSS](http://tt-rss.org). That means that it doesn't work as a standalone feed reader but only as a client for the TinyTinyRSS API which it uses to get the normalized feeds and to synchronize the "article read" marks.

It is written in PyQt and uses WebKit to show the contents.

You need to have PyQt installed and a account on a TinyTinyRSS server.

License: BSD

## Installation

### Linux + Windows

Download the [ZIP](https://github.com/jeena/feedthemonkey/archive/master.zip)-file, unzip it and then run:

On Linux you can just do (if you have PyQt4, python2 and python2-autotools already installed):  
`sudo python2 setup.py install`

On Windows you need to install (those are links to the binary packages):

- [Python2 x32](http://www.python.org/ftp/python/2.7.4/python-2.7.4.msi) or [Python x64](http://www.python.org/ftp/python/2.7.4/python-2.7.4.amd64.msi) 
- [PyQt4 x32](http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.10.1/PyQt4-4.10.1-gpl-Py2.7-Qt4.8.4-x32.exe) or [PyQt x64](http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.10.1/PyQt4-4.10.1-gpl-Py2.7-Qt4.8.4-x64.exe)

Then rename `feedthemonkey` to `feedthemonkey.pyw` and then you can run it by double-clicking.

### OS X

Download [FeedTheMonkey.app.zip](http://jabs.nu/feedthemonkey/download/FeedTheMonkey.app.zip) unzip it and move it to your Applications folder. After that just run it like every other app.

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