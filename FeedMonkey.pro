TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    tinytinyrss.cpp \
    tinytinyrsslogin.cpp \
    post.cpp

RESOURCES += qml.qrc \
    images.qrc

RC_FILE = Icon.icns

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
