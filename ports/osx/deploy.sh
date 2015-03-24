#!/bin/sh

# The macdeployqt app you get while installing Qt is broken for newer Qt
# versions like 5.4 which we use, we will have to replace it.
#
# Download and compile https://github.com/MaximAlien/macdeployqt do not
# use the .dmg which is too old. Move the new macdeployqt so it is in
# $QTDIR/bin/macdeployqt.
#
# Use fixqtlibspath.sh to fix your Qt installation, you need to change the
# path in this script, you don't have to run the Predator part.
#
# Build FeedTheMonkey.app in QtCreator as Release.

if [[ "" == "$QTDIR" ]]; then
	QTDIR=~/Qt/5.4/clang_64/
fi

BUILDDIR=$1
APPDIR=$BUILDDIR/FeedTheMonkey.app
CONTENTSDIR=$APPDIR/Contents
ABSPATH=$(cd "$(dirname "$0")"; pwd)

if [[ "" == "$BUILDDIR" ]]; then
	echo "Usage: $0 path/to/build/"
	exit 1
fi

# libexec
mkdir -p $APPDIR/Contents/libexec
cp $QTDIR/libexec/QtWebProcess $CONTENTSDIR/libexec
cat > $CONTENTSDIR/libexec/qt.conf << EOF
[Paths]
Plugins = ../PlugIns
Qml2Imports = ../Imports/qtquick2
EOF

# lab settings
mkdir -p $CONTENTSDIR/Imports/qtquick2/Qt/labs
cp -R $QTDIR/qml/Qt/labs/settings $CONTENTSDIR/Imports/qtquick2/Qt/labs
cat > $CONTENTSDIR/Resources/qt.conf << EOF
[Paths]
Plugins = PlugIns
Qml2Imports = Imports/qtquick2
EOF

# deploy
$QTDIR/bin/macdeployqt $APPDIR -no-strip -qmldir=$ABSPATH/../../qml -executable=$CONTENTSDIR/libexec/QtWebProcess

open $BUILDDIR

