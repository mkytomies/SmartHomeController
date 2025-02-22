import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    opacity: 0.7
    radius: 10

    Row {
        anchors.fill: parent
        Column {
            id: colorAndBrightnes
            width: 288
            height: parent.height

            Text {
                x: 20
                y: 30
                color: "White"
                font.pixelSize: 24
                text: "Lightning"
            }
            LightColorController {
                anchors.centerIn: parent
            }
            Row {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: 260
                height: 50
                Image {
                    id: bright
                    anchors.left: parent.left
                    width: 24
                    height: 24
                    y: 6
                    source: "bright.png"
                }
                Slider {
                    anchors.horizontalCenter: parent.horizontalCenter
                    from: 1
                    value: 1
                    to: 100
                }
                Image {
                    id: dark
                    anchors.right: parent.right
                    width: 24
                    height: 24
                    y: 6
                    source: "dark.png"
                }
            }
        }
        Column {
            id: lightImage
            width: 144
            height: parent.height

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 140
                height: 265
                source: "light.png"

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 50
                    height: 50
                    radius: width / 2
                    opacity: 0.2

                    color: LightColorController.controller.color
                }
            }


        }
        Column {
            id: lightMode
            width: 248
            height: parent.height


            LightModeController{
                anchors.centerIn: parent
            }
        }
        Column {
            id: power
            width: 40
            y: 20

            Image {
                id: powerIcon
                width: 24
                height: 24
                source: "power.png"
            }
        }
    }
}
