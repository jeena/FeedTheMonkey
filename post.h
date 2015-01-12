#ifndef POST_H
#define POST_H

#include <QObject>
#include <QUrl>
#include <QDate>
#include <QJsonObject>

class Post : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title)
    Q_PROPERTY(QString feedTitle READ feedTitle)
    Q_PROPERTY(QString id READ id)
    Q_PROPERTY(QString feedId READ feedId)
    Q_PROPERTY(QString author READ author)
    Q_PROPERTY(QUrl link READ link)
    Q_PROPERTY(QDateTime date READ date)
    Q_PROPERTY(QString content READ content)
    Q_PROPERTY(bool starred READ starred NOTIFY starredChanged)
    Q_PROPERTY(bool read READ read NOTIFY readChanged)

public:
    Post(QObject *parent = 0);
    Post(QJsonObject post, QObject *parent = 0);
    ~Post();
    QString title() const { return mTitle; }
    QString feedTitle() const { return mFeedTitle; }
    QString id() const { return mId; }
    QString feedId() const { return mFeedId; }
    QString author() const { return mAuthor; }
    QUrl link() const { return mLink; }
    QDateTime date() const { return mDate; }
    QString content() const { return mContent; }
    bool starred() const { return mStarred; }
    bool read() const { return mRead; }

signals:
    void starredChanged(bool);
    void readChanged(bool);

public slots:

private:
    QString mTitle;
    QString mFeedTitle;
    QString mId;
    QString mFeedId;
    QString mAuthor;
    QUrl mLink;
    QDateTime mDate;
    QString mContent;
    bool mStarred;
    bool mRead;
};

#endif // POST_H
