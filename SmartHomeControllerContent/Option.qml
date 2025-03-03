import QtQuick 2.15

Item {
    id: wrapper
    width: 100
    height: 64
    antialiasing: true
    visible: PathView.onPath
    scale: PathView.itemScale
    z: PathView.itemZ

    property variant rotX: PathView.itemAngle

    Rectangle {
        id: gradientBackground
        width: parent.width
        height: parent.height
        color: "transparent"
    }

    transform: Rotation {
        axis.x: 1
        axis.y: 0
        axis.z: 0
        angle: wrapper.rotX
        origin.x: 32
        origin.y: 32
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: 16
        color: "white"
        text: ""
    }
}
