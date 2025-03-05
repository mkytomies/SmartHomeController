import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    radius: 10
    color: "#5c5b5b"

    property bool acStatus: true
    property int selectedSetting: 0

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
            visible: settings.get(selectedSetting).name === "Temperature"
        }

        FanController {
            id: fan
            visible: settings.get(selectedSetting).name === "Fan"
        }

        ACTimerController {
            id: timer
            visible: settings.get(selectedSetting).name === "Timer"

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
            visible: settings.get(selectedSetting).name === "Mode"
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
                id: settings

                ListElement { Id: 0; name: "Temperature"; image: "thermostat.png"; source: "ACTemperatureController.qml" }
                ListElement { Id: 1; name: "Fan"; image: "fan.png"; source: "FanController.qml" }
                ListElement { Id: 2; name: "Timer"; image: "clock.png"; source: "ACTimerController.qml" }
                ListElement { Id: 3; name: "Mode"; image: "bright.png"; source: "ACModeController.qml" }
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
                    font.bold: selectedSetting === model.Id
                    color: "white"
                    text: model.name
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedSetting = model.Id
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
