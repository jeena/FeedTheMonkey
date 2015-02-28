#include "tinytinyrss.h"
#include <QJsonDocument>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QJsonArray>

TinyTinyRSS::TinyTinyRSS(QObject *parent) :
    QObject(parent)
{
    qRegisterMetaType<QList<Post *> >();

    mNetworkManager = new QNetworkAccessManager(this);
    mPosts = QList<Post *>();
}

TinyTinyRSS::~TinyTinyRSS()
{
    mPosts.clear();
    delete mNetworkManager;
}

void TinyTinyRSS::initialize(const QString serverUrl, const QString sessionId)
{
    mServerUrl = serverUrl;
    mSessionId = sessionId;
    reload();
}

void TinyTinyRSS::reload()
{
    QVariantMap opts;
    opts.insert("show_excerpt", false);
    opts.insert("view_mode", "unread");
    opts.insert("show_content", true);
    opts.insert("feed_id", -4);
    opts.insert("skip", 0);

    doOperation("getHeadlines", opts, [this] (const QJsonObject &json) {

        mPosts.clear();

        QJsonArray posts = json.value("content").toArray();
        for(int i = 0; i <= posts.count(); i++)
        {
            QJsonObject postJson = posts.at(i).toObject();
            Post *post = new Post(postJson, this);
            connect(post, SIGNAL(readChanged(bool)), this, SLOT(onPostReadChanged(bool)));
            mPosts.append(post);
        }

        emit postsChanged(mPosts);
    });
}

void TinyTinyRSS::loggedOut()
{
    mServerUrl = nullptr;
    mSessionId = nullptr;
    mPosts.clear();
    emit postsChanged(mPosts);
}

void TinyTinyRSS::doOperation(QString operation, QVariantMap opts, std::function<void (const QJsonObject &json)> callback)
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
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkReply *reply = mNetworkManager->post(request, json.toJson());

    connect(reply, &QNetworkReply::finished, [callback, reply] () {
        if (reply) {
            if (reply->error() == QNetworkReply::NoError) {
                QString jsonString = QString(reply->readAll());
                QJsonDocument json = QJsonDocument::fromJson(jsonString.toUtf8());
                callback(json.object());
            } else {
                int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
                //do some error management
                qWarning() << "HTTP error: " << httpStatus;
            }
            reply->deleteLater();
        }
    });
}

void TinyTinyRSS::onPostReadChanged(bool r)
{
    Post *post = (Post *)sender();

    updateArticle(post->id(), 2, !r, [post] (const QJsonObject &) {
        // not doing anything with this yet.
    });
}

void TinyTinyRSS::updateArticle(int articleId, int field, bool trueFalse, std::function<void (const QJsonObject &json)> callback)
{
    QVariantMap opts;
    opts.insert("article_ids", articleId);
    opts.insert("field", field);
    opts.insert("mode", trueFalse ? 1 : 0);

    doOperation("updateArticle", opts, callback);
}

QQmlListProperty<Post> TinyTinyRSS::posts()
{
    return QQmlListProperty<Post>(this, mPosts);
}

int TinyTinyRSS::postsCount() const
{
    return mPosts.count();
}

Post *TinyTinyRSS::post(int index) const
{
    return mPosts.at(index);
}
