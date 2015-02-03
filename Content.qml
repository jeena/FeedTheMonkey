import QtWebKit 3.0
import QtWebKit.experimental 1.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import TTRSS 1.0

ScrollView {
    id: content
    property Post post
    Layout.minimumWidth: 400

    WebView {
        id: webView
        url: "content.html"

        property Post post: content.post

        function setPost() {
            experimental.evaluateJavaScript("setArticle(" + post.jsonString + ")")
        }

        // Enable communication between QML and WebKit
        experimental.preferences.navigatorQtObjectEnabled: true;

        onNavigationRequested: {
            if (request.navigationType != WebView.LinkClickedNavigation) {
                request.action = WebView.AcceptRequest;
            } else {
                request.action = WebView.IgnoreRequest;
                Qt.openUrlExternally(request.url);
            }
        }

        onLoadingChanged: {
            setPost()
        }

        onPostChanged: {
            setPost();
        }
    }
}
