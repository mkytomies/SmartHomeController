import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    radius: 10
    color: "#5c5b5b"

    property string selectedSetting: "ACTemperatureController.qml"
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

    Loader {
        id: selectedACSetting
        anchors.centerIn: parent
        width: 540
        height: 245
        active: true
        source: selectedSetting

        onLoaded: {
            if (selectedACSetting.item) {
                if (selectedACSetting.item.hasOwnProperty("timerStarted")) {
                    selectedACSetting.item.timerStarted.connect(function() {
                        acStatus = true;
                    });
                }
                if (selectedACSetting.item.hasOwnProperty("timerEnded")) {
                    selectedACSetting.item.timerEnded.connect(function() {
                        acStatus = false;
                    });
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
                    color: "white"
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
        visible: !acStatus
        opacity: 0.3
        color: "black"
    }
}
