import QtQuick 2.0

Component {
    id: component
    Item {
        id: item
        height: column.height + 20
        width: parent.parent.parent.width

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                color: "transparent"

                Column {
                    id: column
                    width: parent.width

                    Row {
                        spacing: 10
                        Text {
                            text: feedTitle
                            font.pointSize: 12
                            color: "gray"
                            wrapMode: Text.Wrap
                        }
                        Text {
                            text: date.toLocaleString(null)
                            font.pointSize: 12
                            color: "gray"
                            wrapMode: Text.Wrap
                        }
                    }
                    Text {
                        text: title
                        font.pointSize: 16
                        wrapMode: Text.Wrap
                        width: parent.width
                    }
                    Text {
                        text: excerpt
                        font.pointSize: 12
                        color: "gray"
                        wrapMode: Text.Wrap
                        width: parent.width
                    }
                }
            }

            Rectangle {
                anchors.top: parent.bottom
                width: parent.width
                height: 1
                color: "lightgray"
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.parent.parent.currentIndex = index
            }
        }
    }
}
