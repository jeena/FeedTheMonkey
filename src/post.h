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

#ifndef POST_H
#define POST_H

#include <QObject>
#include <QUrl>
#include <QDate>
#include <QJsonObject>

class Post : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title CONSTANT)
    Q_PROPERTY(QString feedTitle READ feedTitle CONSTANT)
    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString feedId READ feedId CONSTANT)
    Q_PROPERTY(QString author READ author CONSTANT)
    Q_PROPERTY(QUrl link READ link CONSTANT)
    Q_PROPERTY(QDateTime date READ date CONSTANT)
    Q_PROPERTY(QString content READ content CONSTANT)
    Q_PROPERTY(QString excerpt READ excerpt CONSTANT)
    Q_PROPERTY(bool starred READ starred NOTIFY starredChanged)
    Q_PROPERTY(bool read READ read WRITE setRead NOTIFY readChanged)
    Q_PROPERTY(bool dontChangeRead READ dontChangeRead WRITE setDontChangeRead NOTIFY dontChangeReadChanged)
    Q_PROPERTY(QString jsonString READ jsonString CONSTANT)

public:
    Post(QObject *parent = 0);
    Post(QJsonObject post, QObject *parent = 0);
    ~Post();
    QString title() const { return mTitle; }
    QString feedTitle() const { return mFeedTitle; }
    int id() const { return mId; }
    QString feedId() const { return mFeedId; }
    QString author() const { return mAuthor; }
    QUrl link() const { return mLink; }
    QDateTime date() const { return mDate; }
    QString content() const { return mContent; }
    QString excerpt() const { return mExcerpt; }
    bool starred() const { return mStarred; }
    bool read() { return mRead; }
    void setRead(bool r);
    bool dontChangeRead() const { return mDontChangeRead; }
    void setDontChangeRead(bool r);
    QString jsonString() const { return mJsonString; }

signals:
    void starredChanged(bool);
    void readChanged(bool);
    void dontChangeReadChanged(bool);

public slots:

private:
    QString mTitle;
    QString mFeedTitle;
    int mId;
    QString mFeedId;
    QString mAuthor;
    QUrl mLink;
    QDateTime mDate;
    QString mContent;
    QString mExcerpt;
    bool mStarred;
    bool mRead;
    bool mDontChangeRead;
    QString mJsonString;
    QString html2text(const QString htmlString);
};

#endif // POST_H
