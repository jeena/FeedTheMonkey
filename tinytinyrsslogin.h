#ifndef TINYTINYRSSLOGIN_H
#define TINYTINYRSSLOGIN_H

#include <QObject>

class TinyTinyRSSLogin : public QObject
{
    Q_OBJECT
public:
    explicit TinyTinyRSSLogin(QObject *parent = 0);
    login(QString serverUrl, QString user, QString password);

signals:
    replyLogin(QNetworkReply reply);

public slots:

};

#endif // TINYTINYRSSLOGIN_H
