#include "post.h"
#include <QDebug>

Post::Post(QObject *parent) : QObject(parent)
{

}

Post::Post(QJsonObject post, QObject *parent) : QObject(parent)
{
    mTitle = post.value("title").toString();
    mFeedTitle = post.value("feed_title").toString();
    mId = post.value("id").toString();
    mFeedId = post.value("feed_id").toString();
    mAuthor = post.value("author").toString();
    QUrl url(post.value("link").toString());
    mLink = url;
    QDateTime timestamp;
    timestamp.setTime_t(post.value("updated").toInt());
    mDate = timestamp;
    mContent = post.value("content").toString();
    mStarred = post.value("marked").toBool();
    mRead = !post.value("unread").toBool();
}

Post::~Post()
{

}

