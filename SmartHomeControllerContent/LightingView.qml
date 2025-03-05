import QtQuick
import QtQuick.Controls

Rectangle {
    id: lightingView
    width: 720
    height: 400
    radius: 10
    color: "#5c5b5b"

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
                font.pixelSize: 24
                color: "White"
                text: "Lighting"
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
                id: modeController
                anchors.centerIn: parent
            }
        }

        Column {
            id: power
            anchors.right: parent.right
            anchors.rightMargin: 20
            width: 24
            height: 24
            y: 20

            Image {
                id: powerIcon
                width: 24
                height: 24
                source: "power.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(lights.get(selectedLight).status === "on") {
                        lights.setProperty(selectedLight, "status", "off")
                        lights.setProperty(selectedLight, "image", "lightbulb.png")
                    }
                    else {
                        lights.setProperty(selectedLight, "status", "on")
                        lights.setProperty(selectedLight, "image", "lightbulb-on.png")
                    }
                }
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

                    ListElement { Id: 0; name: "Light 1"; image: "lightbulb-on.png"; color: "#FFD700"; brightness: 90; mode: "Custom"; status: "on" }
                    ListElement { Id: 1; name: "Light 2"; image: "lightbulb-on.png"; color: "#FFD700"; brightness: 90; mode: "Custom"; status: "on" }

                    onDataChanged: {
                        onDataChanged: {
                            if (lights.get(selectedLight).mode === "Custom") {
                                modeController.modes.currentIndex = 0
                            }
                        }
                    }
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
                        font.bold: selectedLight === model.Id
                        color: "white"
                        text: model.name
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            selectedLight = model.Id
                            lightColor.setColor(model.color)
                            brightnessController.value = model.brightness
                        }
                    }
                }
            }
        }
    }
}
