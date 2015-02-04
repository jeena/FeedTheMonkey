import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import TTRSS 1.0

ScrollView {
    property Post post

    style: ScrollViewStyle {
        transientScrollBars: true
    }

    Item {
        height: column.height + 50
        width: parent.parent.width

        Rectangle {
            anchors.fill: parent
            width: parent.width
            height: column.height
            anchors.margins: 30
            color: "transparent"

            Column {
                id: column
                spacing: 10
                width: parent.width

                Label {
                    text: {
                        if(post) {
                            var str = post.feedTitle
                            if(post.author) {
                                str += " - " + post.author;
                            }
                            return str;
                        } else {
                            return ""
                        }
                    }
                    color: "gray"
                    font.pointSize: 16
                    textFormat: Text.PlainText
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    width: parent.width
                    renderType: Text.NativeRendering
                }

                Label {
                    text: post ? post.title : ""
                    font.pointSize: 30
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    width: parent.width
                    renderType: Text.NativeRendering

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Qt.openUrlExternally(post.link)
                    }
                }

                Label {
                    text: post ? post.date.toLocaleString(Qt.locale(), Locale.LongFormat) : ""
                    color: "gray"
                    font.pointSize: 16
                    textFormat: Text.PlainText
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    width: parent.width
                    renderType: Text.NativeRendering
                }

                Rectangle {
                    width: parent.width
                    height: 14
                    color: "transparent"

                    Rectangle {
                        width: parent.width
                        height: 1
                        anchors.top: parent.top
                        anchors.topMargin: 15
                        color: "lightgray"
                        visible: {
                            if(post) {
                                return true;
                            }
                            return false;
                        }
                    }
                }

                Rectangle {
                    height: contentLabel.height + 20
                    width: parent.width
                    color: "transparent"

                    Label {
                        id: contentLabel
                        text: post ? "<style>a { color: #555; }</style>" + post.content : ""
                        textFormat: Text.RichText
                        font.pointSize: 16
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        width: parent.width
                        renderType: Text.NativeRendering
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        lineHeight: 1.3
                        onLinkActivated: {
                            Qt.openUrlExternally(link)
                        }
                    }
                }
            }
        }
    }
}
