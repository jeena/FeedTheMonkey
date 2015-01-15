import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    color: "white"
    anchors.fill: parent

    property string serverUrl: serverUrl.text
    property string userName: userName.text
    property string password: password.text

    Column {
        width: parent.width
        anchors.margins: parent.width / 4
        spacing: 10

        Text {
            text: qsTr("Please specify a server url, a username and a password.")
            wrapMode: Text.WordWrap
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 20
        }

        TextField {
            id: serverUrl
            placeholderText: "http://example.com/ttrss/"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 20
            validator: RegExpValidator { regExp: /https?:\/\/.+/ }
            onAccepted: login()
        }

        TextField {
            id: userName
            placeholderText: qsTr("username")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 20
            onAccepted: login()
        }

        TextField {
            id: password
            placeholderText: qsTr("password")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 20
            echoMode: TextInput.Password
            onAccepted: login()
        }

        Button {
            id: loginButton
            text: "Ok"
            anchors.right: parent.right
            anchors.margins: 20
            onClicked: login()
        }
    }

}
