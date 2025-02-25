import QtQuick
import QtQuick.Controls

import "components"

Rectangle {
    width: 720
    height: 400
    color: "#757575"
    opacity: 1
    radius: 10

    property string selectedSetting: "ACTemperatureController.qml"

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
        source: selectedSetting
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: 260
        height: 55

        Repeater {
            model: ListModel {
                ListElement { name: "Temperature"; image: "thermostat.png"; source: "ACTemperatureController.qml" }
                ListElement { name: "Fan"; image: "fan.png"; source: "FanController.qml" }
                ListElement { name: "Timer"; image: "clock.png"; source: "ACTimerController.qml" }
                ListElement { name: "Mode"; image: "bright.png"; source: "ACModeController.qml" }
            }

            delegate: Column {
                width: parent.width / 3
                height: parent.height
                visible: selectedSetting !== model.source

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
                        selectedSetting = model.source
                    }
                }
            }
        }
    }
}

