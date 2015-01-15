import QtQuick 2.3
import QtQuick.Controls 1.3
import TTRSS 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 800

    menuBar: TheMenuBar {}

    Component {
        id: delegate
        Text { text: title }
    }

    ScrollView {
        width: parent.width / 3
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        ListView {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            spacing: 5
            model: server.posts
            delegate: delegate
        }
    }

    Content {
        width: parent.width / 3 * 2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
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
        onSessionIdChanged: {
            login.visible = false;
            server.initialize(serverUrl, sessionId);
        }
    }

    Server {
        id: server
    }
}
