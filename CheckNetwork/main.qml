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
        id: lableLayout
        width: parent.width
        height: parent.height * 0.1

        Text {
            id: label
            text: qsTr("Click for check")
            anchors.centerIn: parent

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    var avail = appData.isAvailable();

                    var result = new Date().toString();
                    result = "network available=" + avail + " - " + result;

                    var old = state.text;
                    result = old + result + "\n\r";
                    state.text = result
                }
            }
        }
    }

    ScrollView {
        width: parent.width
        height: parent.height * 0.9
        anchors.top: lableLayout.bottom

        Text {
            id: state
            text: "\n\r"
        }
    }

}
