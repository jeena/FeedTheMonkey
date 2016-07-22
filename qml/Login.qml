/*
 * This file is part of FeedTheMonkey.
 *
 * Copyright 2015 Jeena
 *
 * FeedTheMonkey is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FeedTheMonkey is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with FeedTheMonkey.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    color: "transparent"
    anchors.fill: parent

    property string serverUrl: serverUrl.text
    property string userName: userName.text
    property string password: password.text

    Column {
        anchors.centerIn: parent
        width: parent.width / 2
        anchors.margins: parent.width / 4
        spacing: 10

        Text {
            text: qsTr("Please specify a server url, a username and a password.")
            wrapMode: Text.WordWrap
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 20
            font.pointSize: 20
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
