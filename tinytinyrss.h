#ifndef TINYTINYRSS_H
#define TINYTINYRSS_H

#include <QObject>
#include <QMap>
#include <QNetworkReply>
#include <QList>

#include "post.h"

class TinyTinyRSS : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<Post*> posts READ posts NOTIFY postsChanged)

public:
    TinyTinyRSS(QObject *parent = 0);
    ~TinyTinyRSS();
    QList<Post *> posts() const { return mPosts; }

    Q_INVOKABLE void initialize(const QString serverUrl, const QString sessionId);
    Q_INVOKABLE void reload();

signals:
    void postsChanged(QList<Post*>);

private slots:
    void reply();

private:
    void doOperation(QString operation, QVariantMap opts);

    QString mServerUrl;
    QString mSessionId;
    QList<Post*> mPosts;
    QNetworkAccessManager *mNetworkManager;
};

#endif // TINYTINYRSS_H
