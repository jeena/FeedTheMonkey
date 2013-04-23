#!/usr/bin/env python2

import os
from distutils.core import setup

setup(
    name = "feedthemonkey",
    version = "0.1.0",
    author = "Jeena Paradies",
    author_email = "spam@jeenaparadies.net",
    url = "http://jabs.nu/feedthemonkey",
    license = "BSD license",
    packages = ['feedthemonkey'],
    scripts = ["feedthemonkey.py"],
    data_files=[
        ('/usr/share/applications', ["feedthemonkey.desktop"]),
        ('/usr/share/pixmaps', ["feedthemonkey.xpm"])
    ]
)
