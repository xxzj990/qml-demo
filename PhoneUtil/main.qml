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

    Column {
        anchors.fill: parent

        Rectangle {
            width: parent.width
            height: parent.height * 0.1
            color: "#FFFFFF"

            Text {
                id: label
                text: qsTr("Click get phonenumber")
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent

                onClicked: label.text = appData.getPhoneNumber()
            }

        }

        Rectangle {
            width: parent.width
            height: parent.height * 0.1
            color: "lightgrey"

            Text {
                id: label2
                text: qsTr("Click get phone contacts")
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent

                onClicked: phonelist.text = appData.getAddressbook()
            }
        }

        TextArea {
            id: phonelist
            width: parent.width
            height: parent.height * 0.6
        }

    }



}
