import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0
import TTRSS 1.0

ApplicationWindow {
    id: app
    title: "FeedTheMonkey"
    visible: true

    minimumWidth: 480
    minimumHeight: 320

    width: 800
    height: 640
    x: 200
    y: 200

    property Server server: server
    property Sidebar sidebar: sidebar
    property Content content: content

    property variant fontSizes: [7,9,11,13,15,17,19,21,23,25,27,29,31]
    property int defaultTextFontSizeIndex: 3
    property int textFontSizeIndex: defaultTextFontSizeIndex
    property int textFontSize: fontSizes[textFontSizeIndex]

    Settings {
        id: settings
        category: "window"
        property alias x: app.x
        property alias y: app.y
        property alias width: app.width
        property alias height: app.height
        property alias sidebarWidth: sidebar.width
        property alias textFontSizeIndex: app.textFontSizeIndex
    }

    property TheMenuBar menu: TheMenuBar {
        id: menu
        serverLogin: serverLogin
        server: server
        sidebar: sidebar
        content: content
    }

    function loggedIn() {
        if(serverLogin.loggedIn()) {
            menu.loggedIn = true;
            contentView.visible = true
            login.visible = false;
            server.initialize(serverLogin.serverUrl, serverLogin.sessionId);
        } else {
            menu.loggedIn = false
            contentView.visible = false
            login.visible = true
            server.loggedOut()
            content.loggedOut()
        }
    }

    function zoomIn() {
        if(textFontSizeIndex + 1 < fontSizes.length) {
            textFontSize = fontSizes[++textFontSizeIndex]
        }
    }

    function zoomOut() {
        if(textFontSizeIndex - 1 > 0) {
            textFontSize = fontSizes[--textFontSizeIndex]
        }
    }

    function zoomReset() {
        textFontSizeIndex = defaultTextFontSizeIndex
        textFontSize = fontSizes[textFontSizeIndex]
    }

    function keyPressed(event) {
        switch (event.key) {
        case Qt.Key_Right:
        case Qt.Key_J:
        case Qt.Key_j:
            sidebar.next()
            break
        case Qt.Key_Left:
        case Qt.Key_K:
        case Qt.Key_k:
            sidebar.previous()
            break
        case Qt.Key_Home:
            content.scrollUp()
            break
        case Qt.Key_End:
            content.scrollDown()
            break
        case Qt.Key_PageUp:
            content.scrollUp(content.pageJump)
            break
        case Qt.Key_PageDown:
        case Qt.Key_Space:
            content.scrollDown(content.pageJump)
            break
        case Qt.Key_Down:
            content.scrollDown(content.scrollJump)
            break
        case Qt.Key_Up:
            content.scrollUp(content.scrollJump)
            break
        case Qt.Key_Enter:
        case Qt.Key_Return:
            Qt.openUrlExternally(content.post.link)
            break
        default:
            break
        }
    }

    SplitView {
        id: contentView
        anchors.fill: parent
        orientation: Qt.Horizontal
        visible: serverLogin.loggedIn()
        focus: true

        Sidebar {
            id: sidebar
            content: content
            server: server

            Layout.minimumWidth: 200
            implicitWidth: 300
            textFontSize: app.textFontSize
        }

        Content {
            id: content
            app: app

            Layout.minimumWidth: 200
            implicitWidth: 624
            textFontSize: app.textFontSize
        }

        Keys.onPressed: keyPressed(event)
        Keys.onReleased: {
            switch (event.key) {
            case Qt.Key_Alt:
                app.menuBar = menu
                break
            default:
                break
            }
        }
    }

    Login {
        id: login
        anchors.fill: parent
        visible: !serverLogin.loggedIn()

        function login() {
            console.log("FOO")
            serverLogin.login(serverUrl, userName, password)
        }
    }

    ServerLogin {
        id: serverLogin
        onSessionIdChanged: app.loggedIn()
    }

    Server {
        id: server
    }

    Component.onCompleted: {
        if(serverLogin.loggedIn()) {
            loggedIn();
        }
    }
}
