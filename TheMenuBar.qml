import QtQuick.Controls 1.2
import TTRSS 1.0

MenuBar {
    property bool loggedIn: false
    property Server server
    property Sidebar sidebar
    property Content content

    Menu {
        title: qsTr("File")
        MenuItem {
            text: qsTr("Close")
            shortcut: "Ctrl+W"
            enabled: false
        }
        MenuItem {
            text: qsTr("Log Out")
            enabled: false
        }
        MenuSeparator { }
        MenuItem {
            text: qsTr("Exit")
            shortcut: "Ctrl+Q"
            onTriggered: Qt.quit()
        }
    }

    Menu {
        title: qsTr("Action")
        MenuItem {
            text: qsTr("Reload")
            shortcut: "R"
            enabled: false
        }
        MenuItem {
            text: qsTr("Show &Starred")
            shortcut: "Ctrl+S"
            enabled: false
        }
        MenuItem {
            text: qsTr("Set &Starred")
            shortcut: "S"
            enabled: false
        }
        MenuItem {
            text: qsTr("Set &Unread")
            shortcut: "U"
            enabled: true
            onTriggered: content.post.read = false
        }
        MenuItem {
            text: qsTr("Next")
            shortcut: "J"
            enabled: loggedIn
            onTriggered: sidebar.next()
        }
        MenuItem {
            text: qsTr("Previous")
            shortcut: "K"
            enabled: loggedIn
            onTriggered: sidebar.previous()
        }
        MenuItem {
            text: qsTr("Open in Browser")
            shortcut: "N"
            enabled: true
            onTriggered: Qt.openUrlExternally(content.post.link)
        }
    }

    Menu {
        title: qsTr("View")
        MenuItem {
            text: qsTr("Zoom In")
            shortcut: "Ctrl++"
            enabled: false
        }
        MenuItem {
            text: qsTr("Zoom Out")
            shortcut: "Ctrl+-"
            enabled: false
        }
        MenuItem {
            text: qsTr("Reset")
            shortcut: "Ctrl+0"
            enabled: false
        }
    }

    Menu {
        title: qsTr("Window")
        MenuItem {
            text: qsTr("Reset to default")
            shortcut: "Ctrl+D"
            enabled: false
        }
    }

    Menu {
        title: qsTr("Help")
        MenuItem {
            text: qsTr("About")
            onTriggered: Qt.openUrlExternally("http://jabs.nu/feedthemonkey");
        }
    }

}
