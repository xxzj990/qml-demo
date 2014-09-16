import QtQuick 2.0

Item {

    signal sidebarClick(var letter);

    // center
    Rectangle {
        id: letterLayout
        width: parent.width * 0.2
        height: parent.width * 0.2
        anchors.centerIn: parent
        color: "yellowgreen"
        radius: 10
        border.color: "#FFFFFF"
        border.width: 4

        Text {
            id: letter
            anchors.centerIn: parent
            text: "B"
            color: "#FFFFFF"
            font.bold: true
            font.pixelSize: parent.width * 0.5
        }
    }

    // sidebar
    Rectangle {
        width: 25
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top
        color: "#FFFFFF"
        radius: 4
        border {
            width: 1
            color: "#999999"
        }

        Column {
            anchors.fill: parent

            Repeater {
                model: [
                    "#", "A", "B", "C", "D", "E",
                    "F", "G", "H", "I", "J", "K",
                    "L", "M", "N", "O", "P", "Q",
                    "R", "S", "T", "U", "V", "W",
                    "X", "Y", "Z"]

                Item {
                    height: parent.height/27
                    width: parent.width

                    Text {
                        text: modelData
                        color: "#C4C4C4"
                        font.pixelSize: 14
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        id: mounse
                        anchors.fill: parent

                        onClicked: {
                            sidebarClick(modelData);
                        }

                        states: [
                            State {
                                name: "show"
                                when: mounse.pressed
                                PropertyChanges {
                                    target: letterLayout
                                    visible: true
                                }
                                PropertyChanges {
                                    target: letter
                                    text: modelData
                                }
                            },
                            State {
                                name: "hide"
                                when: !mounse.pressed
                                PropertyChanges {
                                    target: letterLayout
                                    visible: false
                                }
                                PropertyChanges {
                                    target: letter
                                    text: ""
                                }
                            }
                        ]
                    }
                }

            }
        }

    }

}
