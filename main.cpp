#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qdebug.h>
#include <QMetaType>
#include <QtQml>

#include "tinytinyrsslogin.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<TinyTinyRSSLogin>("TTRSS", 1, 0, "ServerLogin");
    // qmlRegisterType<TinyTinyRSS>("TTRSS", 1, 0, "Server");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
