import QtQuick 2.2
import QtQuick.Controls 1.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Rectangle {
        id: shareText
        width: parent.width
        height: parent.height * 0.1

        Text {
            text: qsTr("Share text")
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                appData.shareText("Hello world.");
            }
        }
    }

    Rectangle {
        id: share2WeChat
        anchors.top: shareText.bottom
        width: parent.width
        height: parent.height * 0.1

        Text {
            text: qsTr("Share to WeChat")
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                appData.share2WeChat("Hello WeChat.");
            }
        }
    }


}
