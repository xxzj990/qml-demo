import QtQuick 2.0
import QtQuick.Controls 1.1

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Demo")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    ListView {
        id: listview
        anchors.fill: parent
        model: listModel
        delegate: ListItem {}
        focus: true

        onDragEnded:  {
            if (header.refresh) {
                console.log("Reload data...")
            }
        }

        ListHeader {
            id: header
            y: -listview.contentY - height
        }
    }

    ListModel {
        id: listModel
        ListElement {
            title: "Line1"
            des: "The line one"
        }

        ListElement {
            title: "Line2"
            des: "The line two"
        }

        ListElement {
            title: "Line3"
            des: "The line three"
        }

        ListElement {
            title: "Line4"
            des: "The line four"
        }
    }

}
