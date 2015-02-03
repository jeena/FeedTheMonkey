#include "post.h"
#include <QDebug>
#include <QJsonDocument>

Post::Post(QObject *parent) : QObject(parent)
{

}

Post::Post(QJsonObject post, QObject *parent) : QObject(parent)
{
    mTitle = post.value("title").toString().trimmed();
    mFeedTitle = post.value("feed_title").toString().trimmed();
    mId = post.value("id").toString().trimmed();
    mFeedId = post.value("feed_id").toString().trimmed();
    mAuthor = post.value("author").toString().trimmed();
    QUrl url(post.value("link").toString().trimmed());
    mLink = url;
    QDateTime timestamp;
    timestamp.setTime_t(post.value("updated").toInt());
    mDate = timestamp;
    mContent = post.value("content").toString().trimmed();
    mExcerpt = post.value("excerpt").toString().remove(QRegExp("<[^>]*>")).replace("&hellip;", " ...").trimmed().replace("(\\s+)", " ").replace("\n", "");
    mStarred = post.value("marked").toBool();
    mRead = !post.value("unread").toBool();

    QJsonDocument doc(post);
    QString result(doc.toJson(QJsonDocument::Indented));
    mJsonString = result;
}

Post::~Post()
{

}

