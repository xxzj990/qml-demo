import QtQuick 2.2
import QtQuick.Controls 1.1

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property var rawData;

    Timer{
        id: timer; running: false; interval: 7000; repeat: false
        onTriggered: {
            searchField.visible = false;
        }
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    TextField {
        id: searchField
        width: root.width
        height: root.height * 0.1
        visible: false
        placeholderText: "Search"

        onTextChanged: {
            timer.restart();
            if(text.length > 0 ) {
                listModel.filter(text);
                console.log("search key=" + text)
            } else {
                listModel.initData();
            }
        }

        onVisibleChanged: {
            if(visible) focus = true
        }

        Behavior on visible {
            NumberAnimation{ duration: 200 }
        }

    }

    ListView {
        id: listview
        width: parent.width
        height: parent.height
        delegate: delegate
        focus: true
        clip: true
        y: searchField.visible ? searchField.height : 0

        Behavior on y {
            NumberAnimation{ duration: 200 }
        }

        model: ListModel {
            id: listModel

            Component.onCompleted: {
                initData();
            }

            function initData() {
                rawData = new Array;

                listModel.clear();
                for(var i=0; i<10; i++) {
                    var item = {title:"Line" + i, des:"This is line" + i};
                    rawData[i] = item;
                    listModel.append(item);
                }
            }

            function filter(key) {
                var result = new Array;

                for(var i=0; i<rawData.length; i++) {
                    var item = rawData[i];
                    var title = item.title;
                    var des = item.des;

                    if(title.toLowerCase().indexOf(key.toLowerCase()) !== -1 || des.toLowerCase().indexOf(key.toLowerCase()) !== -1) {
                        result.push(item);
                    }
                }

                console.log("result size=" + result.length)

                listModel.clear();
                for(var j=0; j<result.length; j++) {
                    listModel.append(result[j]);
                }
            }
        }

        onContentYChanged: {
            if( contentY < -100 ) {
                searchField.visible = true;
                timer.running = true;
            }
        }

    }


    Component {
        id: delegate
        Item {
            width: root.width
            height: root.height * 0.1

            Column {
                Text {
                    text: title
                    font.pointSize: 18
                }
                Text {
                    text: des
                    font.pointSize: 14
                }
            }
        }
    }

}
