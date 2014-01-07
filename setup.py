#!/usr/bin/env python2

import os, PyQt4
from setuptools import setup
from sys import platform as _platform

VERSION = "0.1.1"
APP = ["feedthemonkey"]

files = []
options = {}
setup_requires = []

is_osx = _platform == "darwin"
is_win = os.name == "nt"
is_linux = not is_osx and not is_win

if is_linux:
    files += ('/usr/share/applications', ["feedthemonkey.desktop"])
    files += ('/usr/share/pixmaps', ["feedthemonkey.xpm"])

if is_osx:
    options = {
        'py2app': {
            'argv_emulation': False,
            'iconfile': 'Icon.icns',
            'plist': {
                'CFBundleShortVersionString': VERSION,
                'CFBundleIdentifier': "nu.jabs.apps.feedthemonkey",
                'LSMinimumSystemVersion': "10.4",
                'CFBundleURLTypes': [
                    {
                        'CFBundleURLName': 'nu.jabs.apps.feedthemonkey.handler',
                        'CFBundleURLSchemes': ['feedthemonkey']
                    }
                ]
            },
            'includes':['PyQt4.QtWebKit', 'PyQt4', 'PyQt4.QtCore', 'PyQt4.QtGui', 'PyQt4.QtNetwork'],
            'excludes': ['PyQt4.QtDesigner', 'PyQt4.QtOpenGL', 'PyQt4.QtScript', 'PyQt4.QtSql', 'PyQt4.QtTest', 'PyQt4.QtXml', 'PyQt4.phonon', 'simplejson'],
            'qt_plugins': 'imageformats',
        }
    }

    setup_requires = ["py2app"]

    for dirname, dirnames, filenames in os.walk('.'):
        for filename in filenames:
            if filename == "Icon.icns":
                files += [(dirname, [os.path.join(dirname, filename)])]

print setup_requires

setup(
    app = APP,
    name = "FeedTheMonkey",
    options = options,
    version = VERSION,
    author = "Jeena Paradies",
    author_email = "spam@jeenaparadies.net",
    url = "http://jabs.nu/feedthemonkey",
    license = "BSD license",
    scripts = ["feedthemonkey"],
    data_files = files,
    setup_requires = setup_requires
)
