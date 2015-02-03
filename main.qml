import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import TTRSS 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 800

    menuBar: TheMenuBar {
        id: menu
        server: server
    }

    function loggedIn() {
        menu.loggedIn = true;
        login.visible = false;
        server.initialize(serverLogin.serverUrl, serverLogin.sessionId);
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Sidebar {
            server: server
            content: content
        }

        Content {
            id: content
            Layout.minimumWidth: 50
            Layout.fillWidth: true
        }
    }

    Login {
        id: login
        anchors.fill: parent
        visible: true

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
