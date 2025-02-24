import QtQuick
import QtQuick.Controls

import "components"

Rectangle {
    width: 720
    height: 400
    color: "#757575"
    opacity: 1
    radius: 10

    Text {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 30
        anchors.leftMargin: 20
        color: "White"
        font.pixelSize: 24
        text: "Air Conditioner"
    }

    Loader {
        id: selectedACSetting
        anchors.centerIn: parent
        active: true
        width: 260
        height: 245
        source: "TemperatureController.qml"
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: 260
        height: 55

        Column {
            id: fanButton
            anchors.left: parent.left
            width: parent.width / 3
            height: parent.height

            Image {
                id: fanIcon
                anchors.horizontalCenter: parent.horizontalCenter
                width: 35
                height: 35
                source: "fan.png"
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: "White"
                font.pixelSize: 14
                text: "Fan"
            }

            MouseArea {
                anchors.fill: parent
                /*onClicked: {

                }*/
            }
        }

        Column {
            id: timerButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width / 3
            height: parent.height

            Image {
                id: timerIcon
                anchors.horizontalCenter: parent.horizontalCenter
                width: 35
                height: 35
                source: "clock.png"
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: "White"
                font.pixelSize: 14
                text: "Timer"
            }
        }

        Column {
            id: modeButton
            anchors.right: parent.right
            width: parent.width / 3
            height: parent.height

            Image {
                id: modeIcon
                anchors.horizontalCenter: parent.horizontalCenter
                width: 35
                height: 35
                source: "bright.png"
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: "White"
                font.pixelSize: 14
                text: "Mode"
            }
        }
    }
}

