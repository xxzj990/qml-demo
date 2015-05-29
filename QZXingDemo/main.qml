import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QZXing 2.3

ApplicationWindow {
    id: window
    title: qsTr("QZXing demo")
    width: 640
    height: 480
    visible: true

//    property real sWidth: Screen.width
//    property real sHeight: Screen.height
    property real sWidth: vOutput.width
    property real sHeight: vOutput.height

    property real scanRecSize: 200

    property real itemWidth: (sWidth-scanRecSize)/2
    property real itemHeight: (sHeight-scanRecSize)/2

    property bool decoded: false
    property bool decoding: false

    function startScan() {
        console.log("Start scanner...");
        result.text = "Decoding...";
        decoded = false;
        timer.running = true;
        timer.repeat = true;
    }

    Image {
        id: photoPreview
        anchors.fill: parent

        onSourceChanged: {
            if(!decoding) {
                decoder.decodeImageQML(photoPreview);
            }
        }
    }

    VideoOutput {
        id: vOutput
        source: camera
        focus : visible // to receive focus and capture key events when visible
        anchors.fill: parent
        orientation: -90

        Rectangle {
            id: one
            width: itemWidth
            height: itemHeight
            opacity: 0.2
            color: "#999999"
        }

        Rectangle {
            id: two
            width: scanRecSize
            height: itemHeight
            opacity: 0.2
            color: "#999999"
            anchors {
                left: one.right
            }
        }

        Rectangle {
            id: three
            width: itemWidth
            height: itemHeight
            opacity: 0.2
            color: "#999999"
            anchors {
                left: two.right
            }
        }

        Rectangle {
            id: four
            width: itemWidth
            height: scanRecSize
            opacity: 0.2
            color: "#999999"
            anchors {
                top: one.bottom
            }
        }

        Rectangle {
            id: six
            width: itemWidth
            height: scanRecSize
            opacity: 0.2
            color: "#999999"
            anchors {
                top: three.bottom
                right: vOutput.right
            }
        }

        Rectangle {
            id: seven
            width: itemWidth
            height: itemHeight
            opacity: 0.2
            color: "#999999"
            anchors {
                top: four.bottom
            }
        }

        Rectangle {
            id: eight
            width: scanRecSize
            height: itemHeight
            opacity: 0.2
            color: "#999999"
            anchors {
                left: seven.right
                bottom: vOutput.bottom
            }
        }

        Rectangle {
            id: nine
            width: itemWidth
            height: itemHeight
            opacity: 0.2
            color: "#999999"
            anchors {
                right: vOutput.right
                bottom: vOutput.bottom
            }
        }

        Item {
            id: scan
            width: scanRecSize
            height: scanRecSize
            anchors.centerIn: parent

            Rectangle {
                id: topLine
                width: parent.width
                height: 1
                color: "red"
                anchors.top: parent.top
            }

            Rectangle {
                id: leftLine
                width: 1
                height: parent.height
                color: "red"
                anchors.left: parent.left
            }

            Rectangle {
                id: bottomLine
                width: parent.width
                height: 1
                color: "red"
                anchors.bottom: parent.bottom
            }

            Rectangle {
                id: rightLine
                width: 1
                height: parent.height
                color: "red"
                anchors.right: parent.right
            }
        }


        MouseArea {
            anchors.fill: parent
            onClicked: camera.searchAndLock()
        }

        Text {
            id: result
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            width: parent.width - 100
            wrapMode: Text.WrapAnywhere
            anchors.horizontalCenter: vOutput.horizontalCenter
            horizontalAlignment: Text.Center
            color: "red"

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    startScan();
                }
            }
        }

        //display focus areas on camera viewfinder:
//        Repeater {
//            model: camera.focus.focusZones

//            Rectangle {
//                border {
//                    width: 2
//                    color: status == Camera.FocusAreaFocused ? "green" : "white"
//                }
//                color: "transparent"

//                // Map from the relative, normalized frame coordinates
//                property variant mappedRect: vOutput.mapNormalizedRectToItem(area);

//                x: mappedRect.x
//                y: mappedRect.y
//                width: mappedRect.width
//                height: mappedRect.height
//            }
//        }

        Component.onCompleted: {
            startScan();
        }
    }

    Camera {
        id: camera

        focus {
            focusMode: Camera.FocusAuto
            focusPointMode: Camera.FocusPointCenter
        }
    }

    Timer {
        id: timer
        interval: 5000
        running: false
        repeat: false

        onTriggered: {
            if(decoded) {
                repeat = false;
                running = false;
            } else {
                vOutput.grabToImage(function(result) {
                    photoPreview.source = result.url;
                }, Qt.size(100, 100));
            }
        }
    }

    QZXing {
        id:decoder

        enabledDecoders: QZXing.DecoderFormat_QR_CODE

        onDecodingStarted: {
            decoding = true;
            console.log("QZXing decode start!");
        }

        onDecodingFinished: {
            decoding = false;
            if (succeeded) {
                console.log("QZXing decode success");
            } else {
                console.log("QZXing decode fail");
            }
        }

        onTagFound: {
            decoded = true;
            result.text = tag;
        }
    }

}
