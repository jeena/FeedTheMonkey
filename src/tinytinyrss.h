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

#ifndef TINYTINYRSS_H
#define TINYTINYRSS_H

#include <QObject>
#include <QMap>
#include <QNetworkReply>
#include <QList>
#include <QQmlListProperty>
#include <QJsonObject>

#include <functional>

#include "post.h"

class TinyTinyRSS : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Post> posts READ posts NOTIFY postsChanged)

public:
    TinyTinyRSS(QObject *parent = 0);
    ~TinyTinyRSS();

    Q_INVOKABLE void initialize(const QString serverUrl, const QString sessionId);
    Q_INVOKABLE void reload();
    Q_INVOKABLE void loggedOut();


    QQmlListProperty<Post> posts();
    int postsCount() const;
    Post *post(int) const;

signals:
    void postsChanged(QList<Post *>);

private slots:
    void onPostReadChanged(bool);

private:
    void doOperation(QString operation, QVariantMap opts, std::function<void (const QJsonObject &json)> callback);
    void updateArticle(int articleId, int field, bool trueFalse, std::function<void (const QJsonObject &json)> callback);

    QString mServerUrl;
    QString mSessionId;
    QList<Post*> mPosts;
    QNetworkAccessManager *mNetworkManager;
};

#endif // TINYTINYRSS_H
