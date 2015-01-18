import QtQuick 2.0

Item {
    property ListView listView
    height: column.height

    Rectangle {
        color: "white"
        anchors.margins: 10
        anchors.fill: parent
        Column {
            id: column
            Text {
                text: "[" + date.toLocaleString(null, "hh:mm:ss") + "] " + feedTitle
                font.pointSize: 9
                color: "gray"
                wrapMode: Text.Wrap
            }
            Text {
                text: title
                font.pointSize: 12
                wrapMode: Text.Wrap
            }
            Text {
                text: excerpt
                font.pointSize: 9
                color: "gray"
                wrapMode: Text.Wrap
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            listView.currentIndex = index
        }
    }
}
