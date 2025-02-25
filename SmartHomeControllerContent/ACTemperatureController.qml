import QtQuick
import QtQuick.Controls

Rectangle {
    id: temperatureController
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
        Rectangle {
            anchors.centerIn: parent
            width: 220
            height: 220
            radius: 120
            color: "Transparent"
            border.color: "#979797"
            border.width: 3
        }
        Text {
            id: temperatureText
            anchors.centerIn: parent
            font.pixelSize: 40
            font.bold: true
            color: "White"
            text: "20°C"
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: 155
        height: 60
        radius: 50
        color: "#757575"

        Rectangle {
            id: minusButton
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 48
            height: 48
            radius: 24
            color: "#979797"
            Image {
                id: minusIcon
                anchors.centerIn: parent
                width: 28
                height: 28
                source: "minus.png"

                MouseArea {
                    anchors.fill: parent
                    /*onClicked {

                    }*/
                }
            }
        }

        Rectangle {
            id: plusButton
            anchors.right: parent.right
            anchors.rightMargin: 10
            width: 48
            height: 48
            radius: 24
            color: "#979797"
            Image {
                id: plusIcon
                anchors.centerIn: parent
                width: 28
                height: 28
                source: "plus.png"

                MouseArea {
                    anchors.fill: parent
                    /*onClicked {

                    }*/
                }
            }
        }
    }
}
