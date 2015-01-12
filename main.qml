import QtQuick 2.3
import QtQuick.Controls 1.2
import TTRSS 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 360

    menuBar: TheMenuBar {}

    Row {
        ListView {
            width: 300
            model: server.posts
            delegate: Text {
                text: title
            }
        }
        Content {
            id: content
            anchors.fill: parent
            visible: false
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
        onSessionIdChanged: {
            login.visible = false;
            server.initialize(serverUrl, sessionId);
        }
    }

    Server {
        id: server
    }
}
