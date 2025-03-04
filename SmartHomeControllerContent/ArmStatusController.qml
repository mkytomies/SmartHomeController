import QtQuick
import QtQuick.Controls

Rectangle {
    id: armStatusController
    anchors.centerIn: parent
    width: 540
    height: 245
    color: "transparent"

    property string selectedMode: "Disarm"

    Row {
        anchors.centerIn: parent
        width: parent.width
        height: 150
        spacing: 10

        Repeater {
            model: ListModel {
                ListElement { name: "Arm Away"; image: "away.png"; }
                ListElement { name: "Arm Stay"; image: "stay.png"; }
                ListElement { name: "Disarm"; image: "disarm.png"; }
            }

            delegate: Rectangle {
                width: armStatusController.width / 3 - 6.5
                height: 150
                radius: 10
                color: (selectedMode === model.name) ? "#769172" : "#979797"

                Image {
                    anchors.centerIn: parent
                    width: 40
                    height: 40
                    source: model.image
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 35
                    color: "White"
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
