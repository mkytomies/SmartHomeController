import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    radius: 10
    color: "#5c5b5b"

    property string selected: "ArmStatusController.qml"

    Text {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 30
        anchors.leftMargin: 20
        font.pixelSize: 24
        color: "white"
        text: "Security"
    }

    Loader {
        anchors.centerIn: parent
        width: parent.width * 0.75
        height: 245
        active: true
        source: selected
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: 260
        height: 55

        Repeater {
            model: ListModel {
                ListElement { name: "Arm status"; image: "bell.png"; source: "ArmStatusController.qml" }
                ListElement { name: "Locks"; image: "lock.png"; source: "LocksController.qml" }
            }

            delegate: Column {
                width: parent.width / 2
                height: parent.height

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 35
                    height: 35
                    source: model.image
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    font.pixelSize: 14
                    color: "white"
                    text: model.name
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selected = model.source
                    }
                }
            }
        }
    }
}

