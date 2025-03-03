import QtQuick
import QtQuick.Controls

Rectangle {
    id: locksController
    width: 540
    height: 245
    color: "transparent"

    property string selectedDoor: "Front door"

    Row {
        anchors.centerIn: parent
        width: 300
        height: 150
        spacing: 10

        Repeater {
            model: ListModel {
                id: locks

                ListElement { name: "Front door"; image: "lock.png"; locked: true }
                ListElement { name: "Back door"; image: "lock.png"; locked: true }
            }

            delegate: Rectangle {
                width: parent.width / locks.count - 5.5
                height: width
                radius: 10
                color: (selectedDoor === model.name) ? "#757575" : "#979797"

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
                        if(model.name === selectedDoor) {
                            if(locked) {
                                model.image = "lock.png"
                            }
                            else {
                                model.image = "open_lock.png"
                            }
                        }
                        selectedDoor = model.name
                        locked = !locked
                    }
                }
            }
        }
    }
}
