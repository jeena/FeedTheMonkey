import QtWebKit 3.0
import QtWebKit.experimental 1.0
import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls 1.3
import TTRSS 1.0

ScrollView {
    id: content
    property Post post
    property int headLinefontSize: 23
    property int textfontSize: 14
    property int scrollJump: 48
    property int pageJump: parent.height
    Layout.minimumWidth: 400

    style: ScrollViewStyle {
        transientScrollBars: true
    }

    Label { id: fontLabel }

    WebView {
        id: webView
        url: "content.html"
        // experimental.transparentBackground: true

        property Post post: content.post

        function setPost() {
            if(post) {
                experimental.evaluateJavaScript("setArticle(" + post.jsonString + ")")
            }
        }

        function setDefaults() {
            // font name needs to be enclosed in single quotes
            experimental.evaluateJavaScript("document.body.style.fontFamily = \"'" + fontLabel.font.family + "'\";");
            experimental.evaluateJavaScript("document.body.style.fontSize = '" + fontLabel.font.pointSize + "pt';");
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
            if(loadRequest.status === WebView.LoadSucceededStatus) {
                setDefaults()
            }
        }

        onPostChanged: setPost()
    }
}

