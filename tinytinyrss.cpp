#include "tinytinyrss.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>

TinyTinyRSS::TinyTinyRSS(QObject *parent) :
    QObject(parent)
{
    mNetworkManager = new QNetworkAccessManager(this);
}

void TinyTinyRSS::initialize(const QString serverUrl, const QString sessionId)
{
    mServerUrl = serverUrl;
    mSessionId = sessionId;
}

TinyTinyRSS::~TinyTinyRSS()
{
    delete mNetworkManager;
}

void TinyTinyRSS::doOperation(QString operation, QVariantMap opts)
{
    QVariantMap options;
    options.insert("sid", mSessionId);
    options.insert("op", operation);

    QMapIterator<QString, QVariant> i(opts);
    while (i.hasNext()) {
        i.next();
        options.insert(i.key(), i.value());
    }

    QJsonObject jsonobj = QJsonObject::fromVariantMap(options);
    QJsonDocument json = QJsonDocument(jsonobj);

    QNetworkRequest request(mServerUrl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QNetworkReply *reply = mNetworkManager->post(request, json.toBinaryData());
    connect(reply, SIGNAL(finished()), this, SLOT(reply()));
}

void TinyTinyRSS::reply()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if (reply) {
        if (reply->error() == QNetworkReply::NoError) {
            //QJsonDocument json = QJsonDocument::fromBinaryData(reply->readAll());
            //mSessionId = json.toVariant().toMap().value("session_id");
            //emit sessionIdChanged(mSessionId);
        } else {
            int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
            //do some error management
            qWarning() << "HTTP error: " << httpStatus;
        }
        reply->deleteLater();
    }
}
