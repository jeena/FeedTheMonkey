#ifndef TINYTINYRSSLOGIN_H
#define TINYTINYRSSLOGIN_H

#include <QObject>
#include <QMetaType>
#include <QNetworkAccessManager>
#include <QNetworkRequest>

class TinyTinyRSSLogin : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString sessionId READ sessionId NOTIFY sessionIdChanged)
    Q_PROPERTY(QUrl serverUrl READ serverUrl)

public:
    TinyTinyRSSLogin(QObject *parent = 0);
    ~TinyTinyRSSLogin();
    QString sessionId() const { return mSessionId; }
    QUrl serverUrl() const { return mServerUrl; }

    Q_INVOKABLE bool loggedIn();
    Q_INVOKABLE void login(const QString serverUrl, const QString user, const QString password);

signals:
    void sessionIdChanged(QString);

private slots:
    void reply();

private:
    QString mSessionId;
    QUrl mServerUrl;
    QNetworkAccessManager *mNetworkManager;
};

#endif // TINYTINYRSSLOGIN_H
