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

#include "tinytinyrsslogin.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>
#include <QSettings>

#define APP_URL "net.jeena"
#define APP_NAME "FeedTheMonkey"

TinyTinyRSSLogin::TinyTinyRSSLogin(QObject *parent) :
    QObject(parent)
{
    mNetworkManager = new QNetworkAccessManager(this);

    QSettings settings;
    mSessionId = settings.value("sessionId").toString();
    mServerUrl = settings.value("serverUrl").toString();
}

TinyTinyRSSLogin::~TinyTinyRSSLogin()
{
    delete mNetworkManager;
}

bool TinyTinyRSSLogin::loggedIn()
{
    return !mSessionId.isEmpty();
}

void TinyTinyRSSLogin::login(const QString serverUrl, const QString user, const QString password)
{
    mServerUrl = QUrl(serverUrl + "/api/");

    QVariantMap options;
    options.insert("op", "login");
    options.insert("user", user);
    options.insert("password", password);

    QJsonObject jsonobj = QJsonObject::fromVariantMap(options);
    QJsonDocument json = QJsonDocument(jsonobj);

    QNetworkRequest request(mServerUrl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkReply *reply = mNetworkManager->post(request, json.toJson());
    connect(reply, SIGNAL(finished()), this, SLOT(reply()));
}

void TinyTinyRSSLogin::logout()
{
    if(mSessionId.length() > 0 && mServerUrl.toString().length() > 0) {
        QVariantMap options;
        options.insert("op", "logout");
        options.insert("sid", mSessionId);

        QJsonObject jsonobj = QJsonObject::fromVariantMap(options);
        QJsonDocument json = QJsonDocument(jsonobj);

        QNetworkRequest request(mServerUrl);
        request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

        QNetworkReply *reply = mNetworkManager->post(request, json.toJson());
        connect(reply, SIGNAL(finished()), this, SLOT(reply()));
    }
}

void TinyTinyRSSLogin::reply()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (reply) {

        if (reply->error() == QNetworkReply::NoError) {

            QString jsonString = QString(reply->readAll());
            QJsonDocument json = QJsonDocument::fromJson(jsonString.toUtf8());
            if(json.object().value("content").toObject().value("error").toString().length() > 0) {

                mLoginError = json.object().value("content").toObject().value("error").toString();
                qWarning() << mLoginError;
                emit loginErrorChanged(mLoginError);

                if(mLoginError == "NOT_LOGGED_IN") {
                    mSessionId = nullptr;
                    mServerUrl = nullptr;

                    QSettings settings;
                    settings.remove("sessionId");
                    settings.remove("serverUrl");
                    settings.sync();

                    emit sessionIdChanged(mSessionId);
                }

            } else {
                mSessionId = json.object().value("content").toObject().value("session_id").toString();

                emit sessionIdChanged(mSessionId);

                QSettings settings;
                settings.setValue("sessionId", mSessionId);
                settings.setValue("serverUrl", mServerUrl);
                settings.sync();
            }
        } else {
            mLoginError = "HTTP error: "
                    + reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString()
                    + " :: "
                    + reply->errorString();
            qWarning() << mLoginError;

            emit loginErrorChanged(mLoginError);
        }
        reply->deleteLater();
    }
}
