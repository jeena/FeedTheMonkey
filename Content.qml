import QtWebKit 3.0
import QtWebKit.experimental 1.0

WebView {
    url: "content.html"

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
}
