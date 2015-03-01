TARGET = feedthemonkey

TEMPLATE = app
QT += qml quick
CONFIG += c++11

SOURCES += \
    src/main.cpp \
    src/post.cpp \
    src/tinytinyrss.cpp \
    src/tinytinyrsslogin.cpp

RESOURCES += \
    html/html.qrc \
    misc/misc.qrc \
    qml/qml.qrc \

mac {
    RC_FILE = misc/Icon.icns
    TARGET = FeedTheMonkey
}

unix {
    target.path = $$PREFIX/usr/local/bin

    shortcutfiles.files = feedthemonkey.desktop
    shortcutfiles.path = $$PREFIX/usr/share/applications/
    data.files += feedthemonkey.xpm
    data.path = $$PREFIX/usr/share/pixmaps/

    INSTALLS += shortcutfiles
    INSTALLS += data
}


# Needed for bringing browser from background to foreground using QDesktopServices: http://bugreports.qt-project.org/browse/QTBUG-8336
TARGET.CAPABILITY += SwEvent

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

OTHER_FILES +=

HEADERS += \
    src/post.h \
    src/tinytinyrss.h \
    src/tinytinyrsslogin.h

DISTFILES += \
    misc/feedthemonkey.desktop \
    README.md \
    LICENSE.txt
