import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    color: "#757575"
    opacity: 1
    radius: 10

    property int selectedLight: 0

    Row {
        anchors.fill: parent
        Column {
            id: colorAndBrightnes
            anchors.left: parent.left
            width: 288
            height: parent.height - 55

            Text {
                x: 20
                y: 30
                color: "White"
                font.pixelSize: 24
                text: "Lightning"
            }
            ColorController {
                id: lightColor
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
                    id: brightnessController
                    anchors.horizontalCenter: parent.horizontalCenter
                    from: 1
                    value: lights.get(selectedLight).brightness
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
            id: lightMode
            anchors.right: parent.right
            width: 248
            height: parent.height - 55


            LightModeController {
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


        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.margins: 10
            width: 260
            height: 55

            Repeater {
                model: ListModel {
                    id: lights
                    ListElement { Id: 0; name: "Light 1"; image: "lightbulb.png"; color: "#FFD700"; brightness: 90 }
                    ListElement { Id: 1; name: "Light 2"; image: "lightbulb.png"; color: "#FFD700"; brightness: 90 }
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
                        color: "White"
                        font.pixelSize: 14
                        text: model.name
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            selectedLight = model.Id
                            lightColor.setColor(model.color)
                            brightnessController.value = model.brightness
                            console.log(selectedLight)
                        }
                    }
                }
            }
        }
    }
}
