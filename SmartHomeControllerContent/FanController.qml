import QtQuick
import QtQuick.Controls

Rectangle {
    id: fanController
    width: 260
    height: 245
    opacity: 1
    color: "#757575"

    Rectangle {
        anchors.centerIn: parent
        width: 240
        height: 240
        radius: 120
        color: "Transparent"
        border.color: "#979797"
        border.width: 5
    }
}
