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
