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
    Q_PROPERTY(QString author READ author)
    Q_PROPERTY(QUrl link READ link)
    Q_PROPERTY(QDate date READ date)
    Q_PROPERTY(QString content READ content)
    Q_PROPERTY(bool starred READ starred NOTIFY starredChanged)

public:
    Post(QObject *parent = 0);
    Post(QJsonObject post, QObject *parent = 0);
    ~Post();
    QString title() const { return mTitle; }
    QString author() const { return mAuthor; }
    QUrl link() const { return mLink; }
    QDate date() const { return mDate; }
    QString content() const { return mContent; }
    bool starred() const { return mStarred; }

signals:
    void starredChanged(bool);

public slots:

private:
    QString mTitle;
    QString mAuthor;
    QUrl mLink;
    QDate mDate;
    QString mContent;
    bool mStarred;
};

#endif // POST_H
