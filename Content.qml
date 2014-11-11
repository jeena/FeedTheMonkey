import QtWebKit 3.0

WebView {
    id: webview
    url: "content.html"
    onNavigationRequested: {
        if (request.navigationType != WebView.LinkClickedNavigation) {
            request.action = WebView.AcceptRequest;
        } else {
            request.action = WebView.IgnoreRequest;
            Qt.openUrlExternally(request.url);
        }
    }
}
