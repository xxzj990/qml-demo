import QtQuick 2.0

Item {
    width: root.width
    height: root.height * 0.1

    Column {
        Text {
            text: model.title
            font.pointSize: 18
        }
        Text {
            text: model.des
            font.pointSize: 14
        }
        Rectangle {
            width: root.width
            height: 1
        }
    }
}
