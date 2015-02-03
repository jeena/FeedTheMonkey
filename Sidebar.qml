import QtQuick 2.0
import TTRSS 1.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

ScrollView {
    id: item

    property Server server
    property Content content

    Layout.minimumWidth: 400

    ListView {

        focus: true
        anchors.fill: parent
        spacing: 1
        model: item.server.posts

        delegate: Component {
            PostListItem {}
        }

        highlight: Rectangle {
            color: "lightblue"
            opacity: 0.5
        }

        onCurrentItemChanged: {
            item.content.post = server.posts[currentIndex]
        }
    }
}
