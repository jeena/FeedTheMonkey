import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 360

    menuBar: TheMenuBar {}

    Content {
        anchors.fill: parent
        visible: false
    }

    Login {
        anchors.fill: parent
        visible: true
    }
}
