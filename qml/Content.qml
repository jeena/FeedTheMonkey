import QtWebEngine 1.0
import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls 1.3
import TTRSS 1.0

Item {
    id: content
    property Post post
    property ApplicationWindow app

    property int textFontSize: 14
    property bool nightmode
    property int scrollJump: 48
    property int pageJump: parent.height
    Layout.minimumWidth: 400
    onTextFontSizeChanged: webView.setDefaults()
    onNightmodeChanged: webView.setDefaults()

    function scrollDown(jump) {
        if(!jump) {
            webView.runJavaScript("window.scrollTo(0, document.body.scrollHeight - " + height + ");")
        } else {
            webView.runJavaScript("window.scrollBy(0, " + jump + ");")
        }
    }

    function scrollUp(jump) {
        if(!jump) {
            webView.runJavaScript("window.scrollTo(0, 0);")
        } else {
            webView.runJavaScript("window.scrollBy(0, -" + jump + ");")
        }
    }

    function loggedOut() {
        post = null
    }

    Label { id: fontLabel }

    WebEngineView {
        id: webView
        anchors.fill: parent
        url: "../html/content.html"

        property Post post: content.post

        function setPost() {
            if(post) {
                webView.runJavaScript("setArticle(" + post.jsonString + ")")
            } else {
                webView.runJavaScript("setArticle('logout')")
            }
        }

        function setDefaults() {
            // font name needs to be enclosed in single quotes
            // and this is needed for El Capitain because ".SF NS Text" won't work
            var defFont = ", system, -apple-system, '.SFNSDisplay-Regular', 'Helvetica Neue', 'Lucida Grande'";
            var font = "'" + fontLabel.font.family + "'" + defFont;
            webView.runJavaScript("document.body.style.fontFamily = \"" + font + "\";");
            webView.runJavaScript("document.body.style.fontSize = '" + content.textFontSize + "pt';");
            webView.runJavaScript("if(typeof setNightmode == \"function\") setNightmode(" + (content.nightmode ? "true" : "false") + ")")
        }


        onNavigationRequested: {
            if (request.navigationType != WebEngineView.LinkClickedNavigation) {
                request.action = WebEngineView.AcceptRequest;
            } else {
                request.action = WebEngineView.IgnoreRequest;
                Qt.openUrlExternally(request.url);
            }
        }

        onLoadingChanged: {
            if(!loading) {
                setPost()
                setDefaults()
            }
        }

        onPostChanged: setPost()
        Keys.onPressed: app.keyPressed(event)
    }
}

