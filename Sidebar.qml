import QtQuick 2.0
import TTRSS 1.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.3

ScrollView {
    id: item

    property Server server
    property Content content

    style: ScrollViewStyle {
        transientScrollBars: true
    }

    function next() {
        if(listView.count > listView.currentIndex) {
            listView.currentIndex++;
        }
    }

    function previous() {
        if(listView.currentIndex > 0) {
            listView.currentIndex--;
        }
    }

    Layout.minimumWidth: 400

    ListView {
        id: listView

        focus: true
        anchors.fill: parent
        spacing: 1
        model: item.server.posts

        delegate: PostListItem {}

        highlightFollowsCurrentItem: false
        highlight: Component {
            Rectangle {
                width: listView.currentItem.width
                height: listView.currentItem.height
                color: "lightblue"
                opacity: 0.5
                y: listView.currentItem.y
            }
        }

        onCurrentItemChanged: {
            item.content.post = server.posts[currentIndex]
        }
    }
}
