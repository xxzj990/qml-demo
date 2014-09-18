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

    function keyboardChange() {
        console.log("input change: visible=" + Qt.inputMethod.visible);

        if(!Qt.inputMethod.visible) {
            moveDown.running = true;
        }

    }

    Component.onCompleted: {
        Qt.inputMethod.visibleChanged.connect(keyboardChange);
    }

    Rectangle {
        anchors.fill: parent

        Rectangle {
            width: parent.width * 0.8
            height: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "#FFFFFF"

            Rectangle {
                id: inputLayout
                color: "#FFFFFF"
                width: parent.width
                height: parent.height
                radius: 3
                border.color: "#999999"
                border.width: 1

                TextInput {
                    id: textInput
                    width: parent.width * 0.98
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Click for input"
                }

                MouseArea {
                    id: mouseClick
                    anchors.fill: parent

                    onClicked: {
                        moveUp.running = true;
                    }
                }

                SequentialAnimation on y {
                    id: moveUp
                    running: false
                    NumberAnimation  {from:inputLayout.y; to: inputLayout.y - 900; duration: 100 }

                    onStopped: {
                        console.log("moveUp animation stoped...");
                        textInput.focus = true;
                        mouseClick.visible = false;
                    }

                }

                SequentialAnimation on y {
                    id: moveDown
                    running: false
                    NumberAnimation  {from:inputLayout.y; to: 0; duration: 100 }

                    onStopped: {
                        console.log("moveDown animation stoped...");
                        textInput.focus = false;
                        mouseClick.visible = true;
                    }
                }

            }

        }

    }
}
