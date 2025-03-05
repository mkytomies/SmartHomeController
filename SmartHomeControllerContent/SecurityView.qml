import QtQuick
import QtQuick.Controls

Rectangle {
    width: 720
    height: 400
    radius: 10
    color: "#5c5b5b"

    property int  selectedSetting: 0

    Text {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 30
        anchors.leftMargin: 20
        font.pixelSize: 24
        color: "white"
        text: "Security"
    }

    ArmStatusController {
        id: armStatus
        visible: securitySettings.get(selectedSetting).name === "Arm status"
    }

    LocksController {
        id: locks
        visible: securitySettings.get(selectedSetting).name === "Locks"
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10
        width: 260
        height: 55
        spacing: 10

        Repeater {
            model: ListModel {
                id: securitySettings

                ListElement { Id: 0; name: "Arm status"; image: "bell.png"; source: "ArmStatusController.qml" }
                ListElement { Id: 1; name: "Locks"; image: "lock.png"; source: "LocksController.qml" }
            }

            delegate: Column {
                width: parent.width / 2
                height: parent.height
                spacing: 1

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
                    z: 1
                    onClicked: {
                        selectedSetting = model.Id
                    }
                }
            }
        }
    }
}

