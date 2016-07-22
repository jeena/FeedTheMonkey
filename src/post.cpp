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

#include "post.h"
#include <QDebug>
#include <QJsonDocument>
#include <QTextDocument>

Post::Post(QObject *parent) : QObject(parent)
{

}

Post::Post(QJsonObject post, QObject *parent) : QObject(parent)
{
    mTitle = html2text(post.value("title").toString().trimmed());
    mFeedTitle = html2text(post.value("feed_title").toString().trimmed());
    mId = post.value("id").toInt();
    mFeedId = post.value("feed_id").toString().trimmed();
    mAuthor = post.value("author").toString().trimmed();
    QUrl url(post.value("link").toString().trimmed());
    mLink = url;
    QDateTime timestamp;
    timestamp.setTime_t(post.value("updated").toInt());
    mDate = timestamp;
    mContent = post.value("content").toString().trimmed();
    mExcerpt = html2text(post.value("excerpt").toString().remove(QRegExp("<[^>]*>")).replace("&hellip;", " ...").trimmed().replace("(\\s+)", " ").replace("\n", ""));
    mStarred = post.value("marked").toBool();
    mRead = !post.value("unread").toBool();
    mDontChangeRead = false;

    QJsonDocument doc(post);
    QString result(doc.toJson(QJsonDocument::Indented));
    mJsonString = result;
}

Post::~Post()
{

}

void Post::setRead(bool r)
{
    if(mRead == r) return;

    mRead = r;
    emit readChanged(mRead);
}

void Post::setDontChangeRead(bool r)
{
    if(mDontChangeRead == r) return;

    mDontChangeRead = r;
    emit dontChangeReadChanged(mDontChangeRead);
}

QString Post::html2text(const QString htmlString)
{
    QTextDocument doc;
    doc.setHtml(htmlString);
    return doc.toPlainText();
}
