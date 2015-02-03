import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3
import TTRSS 1.0

ScrollView {
    property Post post
    Layout.minimumWidth: 400

    style: ScrollViewStyle {
        transientScrollBars: true
    }

    Item {
        height: column.height + 20
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
                    wrapMode: Text.Wrap
                    width: parent.width
                }

                Label {
                    text: post ? post.title : ""
                    font.pointSize: 30
                    wrapMode: Text.Wrap
                    width: parent.width
                }

                Label {
                    text: post ? post.date.toLocaleString(Qt.locale(), Locale.LongFormat) : ""
                    color: "gray"
                    font.pointSize: 16
                    wrapMode: Text.Wrap
                    width: parent.width
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
                        text: post ? post.content : ""
                        font.pointSize: 16
                        wrapMode: Text.Wrap
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        lineHeight: 1.3
                        linkColor: "#555"
                        onLinkActivated: {
                            Qt.openUrlExternally(link)
                        }
                    }
                }
            }
        }
    }
}
