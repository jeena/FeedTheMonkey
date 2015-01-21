import QtQuick 2.0

Item {
    property ListView listView

    height: column.height + 10
    width: listView.parent.width

    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        color: "transparent"

        Column {
            id: column

            Row {
                spacing: 10
                Text {
                    text: feedTitle
                    font.pointSize: 9
                    color: "gray"
                    wrapMode: Text.Wrap
                }
                Text {
                    text: date.toLocaleString(null)
                    font.pointSize: 9
                    color: "gray"
                    wrapMode: Text.Wrap
                }
            }
            Text {
                text: title
                font.pointSize: 12
                wrapMode: Text.Wrap
                width: parent.width
            }
            Text {
                text: excerpt
                font.pointSize: 9
                color: "gray"
                wrapMode: Text.Wrap
                width: parent.width
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
