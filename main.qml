import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import TTRSS 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 800

    menuBar: TheMenuBar {}

    function loggedIn() {
        login.visible = false;
        server.initialize(serverLogin.serverUrl, serverLogin.sessionId);
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        ScrollView {
            Layout.minimumWidth: 400

            ListView {
                id: listView
                anchors.fill: parent
                spacing: 1
                model: server.posts
                delegate: delegate
                highlight: Rectangle {
                    color: "lightblue"
                    opacity: 0.5
                }
                focus: true
                onCurrentItemChanged: {
                    content.experimental.evaluateJavaScript("setArticle(" + server.posts[currentIndex].jsonString + ")")
                }
            }
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

    Component {
        id: delegate
        PostListItem {}
    }

    Component.onCompleted: {
        if(serverLogin.loggedIn()) {
            loggedIn();
        }
    }
}
