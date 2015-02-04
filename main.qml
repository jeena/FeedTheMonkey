import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import TTRSS 1.0

ApplicationWindow {
    id: window
    title: "FeedMonkey"

    visible: true

    contentItem.minimumWidth: 640
    contentItem.minimumHeight: 480
    contentItem.implicitWidth: 1024
    contentItem.implicitHeight: 800

    menuBar: TheMenuBar {
        id: menu
        server: server
        sidebar: sidebar
    }

    function loggedIn() {
        menu.loggedIn = true;
        login.visible = false;
        server.initialize(serverLogin.serverUrl, serverLogin.sessionId);
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        visible: serverLogin.loggedIn()
        focus: true

        Sidebar {
            id: sidebar
            server: server
            content: content

            Layout.minimumWidth: 200
            implicitWidth: 300
        }

        Content {
            id: content

            Layout.minimumWidth: 200
            implicitWidth: 624
        }

        Keys.onRightPressed: sidebar.next()
        Keys.onLeftPressed: sidebar.previous()
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

    Login {
        id: login
        anchors.fill: parent
        visible: !serverLogin.loggedIn()

        function login() {
            serverLogin.login(serverUrl, userName, password)
        }
    }

    ServerLogin {
        id: serverLogin
        onSessionIdChanged: loggedIn()
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
