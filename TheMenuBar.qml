import QtQuick.Controls 1.2

MenuBar {

    function loggedIn() {
        return false;
    }

    Menu {
        title: qsTr("File")
        MenuItem {
            text: qsTr("Close")
            shortcut: "Ctrl+W"
        }
        MenuItem {
            text: qsTr("Log Out")
            enabled: loggedIn()
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
            enabled: loggedIn()
        }
        MenuItem {
            text: qsTr("Show &Starred")
            shortcut: "Ctrl+S"
            enabled: loggedIn()
        }
        MenuItem {
            text: qsTr("Set &Starred")
            shortcut: "S"
            enabled: loggedIn()
        }
        MenuItem {
            text: qsTr("Set &Unread")
            shortcut: "U"
            enabled: loggedIn()
        }
        MenuItem {
            text: qsTr("Next")
            shortcut: "J"
            enabled: loggedIn()
        }
        MenuItem {
            text: qsTr("Previous")
            shortcut: "K"
            enabled: loggedIn()
        }
        MenuItem {
            text: qsTr("Open in Browser")
            shortcut: "N"
            enabled: loggedIn()
        }
    }

    Menu {
        title: qsTr("View")
        MenuItem {
            text: qsTr("Zoom In")
            shortcut: "Ctrl++"
        }
        MenuItem {
            text: qsTr("Zoom Out")
            shortcut: "Ctrl+-"
        }
        MenuItem {
            text: qsTr("Reset")
            shortcut: "Ctrl+0"
        }
    }

    Menu {
        title: qsTr("Window")
        MenuItem {
            text: qsTr("Reset to default")
            shortcut: "Ctrl+D"
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
