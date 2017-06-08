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

#ifndef TINYTINYRSSLOGIN_H
#define TINYTINYRSSLOGIN_H

#include <QObject>
#include <QMetaType>
#include <QNetworkAccessManager>
#include <QNetworkRequest>

class TinyTinyRSSLogin : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString sessionId READ sessionId NOTIFY sessionIdChanged)
    Q_PROPERTY(QUrl serverUrl READ serverUrl)
    Q_PROPERTY(QString loginError READ loginError NOTIFY loginErrorChanged)

public:
    TinyTinyRSSLogin(QObject *parent = 0);
    ~TinyTinyRSSLogin();
    QString sessionId() const { return mSessionId; }
    QUrl serverUrl() const { return mServerUrl; }
    QString loginError() const { return mLoginError; }

    Q_INVOKABLE bool loggedIn();
    Q_INVOKABLE void login(const QString serverUrl, const QString user, const QString password);
    Q_INVOKABLE void logout();

signals:
    void sessionIdChanged(QString);
    void loginErrorChanged(QString);

private slots:
    void reply();

private:
    QString mSessionId;
    QUrl mServerUrl;
    QString mLoginError;
    QNetworkAccessManager *mNetworkManager;
};

#endif // TINYTINYRSSLOGIN_H
