import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    radius: 10
    opacity: 1
    color: "#757575"

    property string selectedSetting: "ACTemperatureController.qml"
    property bool fanStatus: true

    Row {
        width: parent.width
        height: 70

        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 30
            anchors.leftMargin: 20
            font.pixelSize: 24
            color: "White"
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
                    if(fanStatus) {
                        fanStatus = false
                    }
                    else {
                        fanStatus = true
                    }
                }
            }
        }
    }

    Loader {
        id: selectedACSetting
        anchors.centerIn: parent
        width: 260
        height: 245
        active: true
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
                    font.pixelSize: 14
                    color: "White"
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

    Rectangle {
        id: overlay
        width: 720
        height: 400
        visible: !fanStatus
        opacity: 0.3
        color: "Black"
    }
}
