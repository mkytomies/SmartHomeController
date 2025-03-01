import QtQuick
import QtQuick.Controls

Rectangle {
    id: locksController
    width: 540
    height: 245
    color: "Transparent"

    Row {
        anchors.centerIn: parent
        width: parent.width
        height: 150
        spacing: 10

        Repeater {
            model: ListModel {
                ListElement { name: "Arm Away"; source: "LightingView.qml" }
                ListElement { name: "Arm Stay"; source: "ACView.qml" }
                ListElement { name: "Disarm"; source: "SecurityView.qml" }
            }

            delegate: Rectangle {
                width: locksController.width / 3 - 6.5
                height: 150
                color: "Blue"
                opacity: 0.7
                radius: 10

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                    }
                }
            }
        }
    }
}
