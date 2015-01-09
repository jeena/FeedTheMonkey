#include "tinytinyrsslogin.h"

TinyTinyRSSLogin::TinyTinyRSSLogin(QObject *parent) :
    QObject(parent)
{
}

void TinyTinyRSSLogin::login(QString serverUrl, QString user, QString password)
{
    QVariantMap options;
    options.insert("op", "login");
    options.insert("user", user);
    options.insert("password", password);

    QJsonObject jsonobj = QJsonObject::fromVariantMap(options);
    QJsonDocument json = QJsonDocument(jsonobj);

    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    QUrl url(serverUrl + "/api/");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QObject::connect(manager, SIGNAL(finished(QNetworkReply)), this, SIGNAL(replyLogin(QNetworkReply)));
    manager->post(request, json.toBinaryData());
}

TinyTinyRSSLogin::replyLogin(QNetworkReply reply)
{
    QString sessionId = "1234";
    this->parent()->loggedIn(QString(sessionId));
}
