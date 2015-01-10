#include "tinytinyrsslogin.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>

TinyTinyRSSLogin::TinyTinyRSSLogin(QObject *parent) :
    QObject(parent)
{
    mNetworkManager = new QNetworkAccessManager(this);
}

TinyTinyRSSLogin::~TinyTinyRSSLogin()
{
    delete mNetworkManager;
}

void TinyTinyRSSLogin::login(const QString serverUrl, const QString user, const QString password)
{
    mServerUrl = QUrl(serverUrl + "/api/");

    QVariantMap options;
    options.insert("op", "login");
    options.insert("user", user);
    options.insert("password", password);

    QJsonObject jsonobj = QJsonObject::fromVariantMap(options);
    QJsonDocument json = QJsonDocument(jsonobj);

    QNetworkRequest request(mServerUrl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QNetworkReply *reply = mNetworkManager->post(request, json.toBinaryData());
    connect(reply, SIGNAL(finished()), this, SLOT(reply()));
}

void TinyTinyRSSLogin::reply()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (reply) {
        if (reply->error() == QNetworkReply::NoError) {
        //read data from reply
        } else {
        //get http status code
        int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
        //do some error management
        }
        reply->deleteLater();
    }
    mSessionId = "1234";
    emit sessionIdChanged(mSessionId);
}
