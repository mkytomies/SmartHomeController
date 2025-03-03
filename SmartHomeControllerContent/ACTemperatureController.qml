import QtQuick
import QtQuick.Controls

Control {
    id: temperatureController
    width: 260
    height: 260
    opacity: 1

    property int temperature: 20
    property real ringRadius: 110

    Rectangle {
        anchors.centerIn: parent
        width: 240
        height: 240
        radius: 120
        border.width: 5
        border.color: "#979797"
        color: "transparent"

        Rectangle {
            anchors.centerIn: parent
            width: 220
            height: 220
            radius: 110
            border.width: 3
            border.color: "#979797"
            color: "transparent"
        }

        Rectangle {
            id: indicator
            width: 20
            height: 20
            radius: 10

            x: (parent.width / 2) + ringRadius * Math.cos(temperatureToAngle(temperature)) - width / 2
            y: (parent.height / 2) + ringRadius * Math.sin(temperatureToAngle(temperature)) - height / 2

            Behavior on x { NumberAnimation { duration: 300 } }
            Behavior on y { NumberAnimation { duration: 300 } }
        }

        Text {
            id: temperatureText
            anchors.centerIn: parent
            font.pixelSize: 40
            font.bold: true
            color: "white"
            text: temperature + "°C"
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
                anchors.centerIn: parent
                width: 28
                height: 28
                source: "minus.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (temperature > 15) {
                        temperature -= 1
                    }
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
                anchors.centerIn: parent
                width: 28
                height: 28
                source: "plus.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (temperature < 25) {
                        temperature += 1
                    }
                }
            }
        }
    }

    function temperatureToAngle(temp) {
        return (Math.PI / 220) * (180 + ((temp - 15) / 10) * 300);
    }
}
