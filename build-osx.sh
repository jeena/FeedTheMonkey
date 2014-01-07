#!/bin/bash

HERE=`pwd`
TMP="/tmp"

rm -rf FeedTheMonkey.app
rm -rf $TMP/feedthemonkey
mkdir $TMP/feedthemonkey
cp Icon.icns $TMP/feedthemonkey/
cp setup.py $TMP/feedthemonkey
cp feedthemonkey $TMP/feedthemonkey/
cd $TMP/feedthemonkey
python setup.py py2app
mv $TMP/feedthemonkey/dist/FeedTheMonkey.app $HERE
cd $HERE
rm -rf $TMP/feedthemonkey
FeedTheMonkey.app/Contents/MacOS/FeedTheMonkey