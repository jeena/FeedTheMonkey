import QtQuick.Controls 1.2

MenuBar {

    Menu {
        title: "File"
        MenuItem {
            text: "Close"
            shortcut: "Ctrl+W"
        }
        MenuItem {
            text: "Log Out"
        }
        MenuSeparator { }
        MenuItem {
            text: "Exit"
            shortcut: "Ctrl+Q"
            onTriggered: Qt.quit()
        }
    }

    Menu {
        title: "Action"
        MenuItem {
            text: "Reload"
            shortcut: "R"
        }
        MenuItem {
            text: "Show &Starred"
            shortcut: "Ctrl+S"
        }
        MenuItem {
            text: "Set &Starred"
            shortcut: "S"
        }
        MenuItem {
            text: "Set &Unread"
            shortcut: "U"
        }
        MenuItem {
            text: "Next"
            shortcut: "J"
        }
        MenuItem {
            text: "Previous"
            shortcut: "K"
        }
        MenuItem {
            text: "Open in Browser"
            shortcut: "N"
        }
    }

    Menu {
        title: "View"
        MenuItem {
            text: "Zoom In"
            shortcut: "Ctrl++"
        }
        MenuItem {
            text: "Zoom Out"
            shortcut: "Ctrl+-"
        }
        MenuItem {
            text: "Reset"
            shortcut: "Ctrl+0"
        }
    }

    Menu {
        title: "Window"
        MenuItem {
            text: "Reset to default"
            shortcut: "Ctrl+D"
        }
    }

    Menu {
        title: "Help"
        MenuItem {
            text: "About"
            onTriggered: Qt.openUrlExternally("http://jabs.nu/feedthemonkey");
        }
    }

}
