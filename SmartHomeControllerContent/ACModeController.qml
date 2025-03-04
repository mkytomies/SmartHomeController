import QtQuick
import QtQuick.Controls

Rectangle {
    id: acModeController
    anchors.centerIn: parent
    width: 540
    height: 245
    color: "transparent"

    property string selectedMode: "Auto"

    Row {
        anchors.centerIn: parent
        width: parent.width
        height: 150
        spacing: 10

        Repeater {
            model: ListModel {
                ListElement { name: "Auto"; image: "auto.png" }
                ListElement { name: "Cool"; image: "cool.png" }
                ListElement { name: "Heat"; image: "heat.png" }
                ListElement { name: "Dry"; image: "dry.png" }
            }

            delegate: Rectangle {
                width: acModeController.width / 4 - 7.5
                height: width
                color: (selectedMode === model.name) ? "#769172" : "#979797"
                radius: 10

                Image {
                    anchors.centerIn: parent
                    width: 40
                    height: 40
                    source: model.image
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 25
                    color: "white"
                    text: model.name
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedMode = model.name
                    }
                }
            }
        }
    }
}
