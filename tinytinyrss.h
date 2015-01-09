#ifndef TINYTINYRSS_H
#define TINYTINYRSS_H

#include <QObject>
#include <QQuickItem>
#include <QMap>
#include <QNetworkReply>

class TinyTinyRSS : QObject
{
    Q_OBJECT

public:
    TinyTinyRSS(QString serverUrl, QString sessionId);
    ~TinyTinyRSS();
    void login();
    void replyFinishedOperation(QNetworkReply *reply);

private:
    QString serverUrl;
    QString sessionId;

    void doOperation(QString operation, QVariantMap opts);
};

#endif // TINYTINYRSS_H
