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
    property ApplicationWindow app

    property int headLinefontSize: 23
    property int textfontSize: 14
    property int scrollJump: 48
    property int pageJump: parent.height
    Layout.minimumWidth: 400

    style: ScrollViewStyle {
        transientScrollBars: true
    }

    function scrollDown(jump) {
        if(!jump) {
            webView.experimental.evaluateJavaScript("window.scrollTo(0, document.body.scrollHeight - " + height + ");")
        } else {
            webView.experimental.evaluateJavaScript("window.scrollBy(0, " + jump + ");")
        }
    }

    function scrollUp(jump) {
        if(!jump) {
            webView.experimental.evaluateJavaScript("window.scrollTo(0, 0);")
        } else {
            webView.experimental.evaluateJavaScript("window.scrollBy(0, -" + jump + ");")
        }
    }

    Label { id: fontLabel }

    WebView {
        id: webView
        url: "content.html"

        // Enable communication between QML and WebKit
        experimental.preferences.navigatorQtObjectEnabled: true;

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

        Keys.onRightPressed: app.sidebar.next()
        Keys.onLeftPressed: app.sidebar.previous()
        Keys.onDownPressed: content.scrollDown(content.scrollJump)
        Keys.onUpPressed: content.scrollUp(content.scrollJump)
        Keys.onSpacePressed: content.scrollDown(content.pageJump)
        Keys.onEnterPressed: Qt.openUrlExternally(content.post.link)
        Keys.onReturnPressed: Qt.openUrlExternally(content.post.link)
        Keys.onPressed: {
            if(event.key === Qt.Key_Home) {
                content.scrollUp();
            } else if (event.key === Qt.Key_End) {
                content.scrollDown();
            } else if (event.key === Qt.Key_PageUp) {
                content.scrollUp(content.pageJump)
            } else if (event.key === Qt.Key_PageDown) {
                content.scrollDown(content.pageJump)
            }
        }
    }
}

