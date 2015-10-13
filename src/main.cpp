#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qdebug.h>
#include <QMetaType>
#include <QtQml>
#include <QIcon>
#include <QtWebEngine/qtwebengineglobal.h>

#include "tinytinyrsslogin.h"
#include "tinytinyrss.h"
#include "post.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Jeena");
    app.setOrganizationDomain("jeena.net");
    app.setApplicationName("FeedTheMonkey");

    QtWebEngine::initialize();

    qmlRegisterType<TinyTinyRSSLogin>("TTRSS", 1, 0, "ServerLogin");
    qmlRegisterType<TinyTinyRSS>("TTRSS", 1, 0, "Server");
    qmlRegisterType<Post>("TTRSS", 1, 0, "Post");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
