TEMPLATE = app

QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    tinytinyrss.cpp \
    tinytinyrsslogin.cpp \
    post.cpp

RESOURCES += qml.qrc \
    images.qrc \
    html.qrc

mac {
    RC_FILE = Icon.icns
}

unix {
    target.path = $$PREFIX/usr/local/bin

    shortcutfiles.files += feedthemonkey.desktop
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

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES +=

HEADERS += \
    tinytinyrss.h \
    tinytinyrsslogin.h \
    post.h

DISTFILES += \
    feedthemonkey.desktop \
    README.md \
    LICENSE.txt
