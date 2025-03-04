import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    radius: 10
    color: "#5c5b5b"

    property bool acStatus: true

    Row {
        width: parent.width
        height: 70

        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 30
            anchors.leftMargin: 20
            font.pixelSize: 24
            color: "white"
            text: "Air Conditioner"
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
                    acStatus = !acStatus
                }
            }
        }
    }

    Rectangle {
        id: selectedACSetting
        anchors.centerIn: parent
        width: 540
        height: 245
        color: "transparent"

        ACTemperatureController {
            id: temperature
            visible: true
        }

        FanController {
            id: fan
            visible: false
        }

        ACTimerController {
            id: timer
            visible: false

            onVisibleChanged: {
                timerStarted.connect(function() {
                    acStatus = true
                });
                timerEnded.connect(function() {
                    acStatus = false
                });
            }
        }

        ACModeController {
            id: mode
            visible: false
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: 300
        height: 55

        Repeater {
            model: ListModel {
                ListElement { name: "Temperature"; image: "thermostat.png"; source: "ACTemperatureController.qml" }
                ListElement { name: "Fan"; image: "fan.png"; source: "FanController.qml" }
                ListElement { name: "Timer"; image: "clock.png"; source: "ACTimerController.qml" }
                ListElement { name: "Mode"; image: "bright.png"; source: "ACModeController.qml" }
            }

            delegate: Column {
                width: parent.width / 4
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
                        temperature.visible = model.name.toLowerCase() === "temperature"
                        fan.visible = model.name.toLowerCase() === "fan"
                        timer.visible = model.name.toLowerCase() === "timer"
                        mode.visible = model.name.toLowerCase() === "mode"
                    }
                }
            }
        }
    }

    Rectangle {
        id: overlay
        width: 720
        height: 400
        visible: !acStatus
        opacity: 0.3
        color: "black"
    }
}
