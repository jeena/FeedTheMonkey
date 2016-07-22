/*
 * This file is part of FeedTheMonkey.
 *
 * Copyright 2015 Jeena
 *
 * FeedTheMonkey is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FeedTheMonkey is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with FeedTheMonkey.  If not, see <http://www.gnu.org/licenses/>.
 */

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
