#include "tinytinyrss.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>

TinyTinyRSS::TinyTinyRSS(QString serverUrl, QString sessionId)
{
    this->serverUrl = serverUrl;
    this->sessionId = sessionId;
}

TinyTinyRSS::~TinyTinyRSS()
{

}

void TinyTinyRSS::doOperation(QString operation, QVariantMap opts) {
    QVariantMap options;
    options.insert("sid", this->sessionId);
    options.insert("op", operation);

    QMapIterator<QString, QVariant> i(opts);
    while (i.hasNext()) {
        i.next();
        options.insert(i.key(), i.value());
    }

    QJsonObject jsonobj = QJsonObject::fromVariantMap(options);
    QJsonDocument json = QJsonDocument(jsonobj);

    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    QUrl url(this->serverUrl + "/api/");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QObject::connect(manager, &QNetworkAccessManager::finished, this, &TinyTinyRSS::replyFinishedOperation);
    manager->post(request, json);
}

void TinyTinyRSS::replyFinishedOperation(QNetworkReply *reply) {

}
