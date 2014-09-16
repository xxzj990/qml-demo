import QtQuick 2.2
import QtQuick.Controls 1.1

ApplicationWindow {
    id: root
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

    ListView {
        id: mainListView
        model: dataModel
        delegate: mainDelegate
        focus: true
        anchors.fill: parent
        highlightFollowsCurrentItem: true

        section.criteria: ViewSection.FirstCharacter
        section.delegate: sectionHeading
        section.labelPositioning: ViewSection.InlineLabels
        section.property: "title"
    }

    // ListModel need sort by yourself
    ListModel {
        id: dataModel

        ListElement {
            title: "Alex"
            des: "Very litte gay."
        }

        ListElement {
            title: "Ben"
            des: "An strong man."
        }

        ListElement {
            title: "Beni"
            des: "Good singer."
        }

        ListElement {
            title: "Bus"
            des: "Go to shcool."
        }

        ListElement {
            title: "Jingjing"
            des: "Beautiful women :)."
        }

        ListElement {
            title: "Mingming"
            des: "Handsome man :)."
        }

        ListElement {
            title: "Peter"
            des: "Driving a nice car."
        }

        ListElement {
            title: "Sunny"
            des: "Work with PHP."
        }

        ListElement {
            title: "Zone"
            des: "Play very good basketball."
        }

    }

    Component {
        id: mainDelegate

        Rectangle {
            id: wrapper
            width: root.width
            height: root.height * 0.1
            color: ListView.isCurrentItem ? "grey" : "#FFFFFF"

            Column {
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: title
                    font.pointSize: 18
                    color: wrapper.ListView.isCurrentItem ? "#FFFFFF" : "grey"
                }
                Text {
                    text: des
                    font.pointSize: 12
                    color: wrapper.ListView.isCurrentItem ? "#FFFFFF" : "grey"
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    mainListView.currentIndex = index
                }
            }
        }
    }

    Component {
        id: sectionHeading
        Rectangle {
            width: root.width
            height: root.height * 0.05
            color: "lightsteelblue"

            Text {
                text: section
                font.bold: true
                font.pointSize: 14
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

}
