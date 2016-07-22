import QtQuick 2.0
import QtQuick.Controls 1.3

Item {
    property int textFontSize: 14
    property int smallfontSize: 11
    property bool nightmode

    Component.onCompleted: fixFontSize()
    onTextFontSizeChanged: fixFontSize()

    function fixFontSize() {
        smallfontSize = textFontSize * 0.8
    }

    id: item
    height: d.height + t.height + e.height + 20

    Item {
        anchors.fill: parent

        Item {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            Column {
                id: column
                width: parent.width

                Item {
                    width: parent.width
                    height: d.height

                    Label {
                        text: feedTitle
                        font.pointSize: smallfontSize
                        textFormat: Text.PlainText
                        color: nightmode ? "#888" : "gray"
                        wrapMode: Text.WrapAnywhere
                        renderType: Text.NativeRendering
                        elide: Text.ElideLeft
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: d.left
                        maximumLineCount: 1
                    }
                    Label {
                        id: d
                        text: date.toLocaleString(Qt.locale(), Locale.ShortFormat)
                        font.pointSize: smallfontSize
                        textFormat: Text.PlainText
                        color: nightmode ? "#888" : "gray"
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        renderType: Text.NativeRendering
                        anchors.right: parent.right
                        anchors.top: parent.top
                    }
                }
                Label {
                    id: t
                    text: title
                    color: nightmode ? (read ? "#888" : "#aaa") : (read ? "gray" : "black")
                    font.pointSize: textFontSize
                    textFormat: Text.PlainText
                    wrapMode: Text.WrapAnywhere
                    renderType: Text.NativeRendering
                    width: parent.width
                    elide: Text.ElideRight
                    maximumLineCount: 1

                }
                Label {
                    id: e
                    text: excerpt
                    font.pointSize: smallfontSize
                    //textFormat: Text.RichText
                    color: nightmode ? "#888" : "gray"
                    wrapMode: Text.WrapAnywhere
                    renderType: Text.NativeRendering
                    width: parent.width
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }
            }
        }

        Rectangle {
            anchors.top: parent.bottom
            width: parent.width
            height: 1
            color: nightmode ? "#222" : "lightgray"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.parent.parent.currentIndex = index
        }
    }
}
