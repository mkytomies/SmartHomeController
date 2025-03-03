import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    width: 250
    height: 300
    color: "transparent"

    property string selectedColor: ""
    property int selectedBrightness

    ListModel {
        id: lightModeModel

        ListElement { name: "Custom"; color: ""; brightness: 0 }
        ListElement { name: "Working"; color: "#FFD700"; brightness: 90 }
        ListElement { name: "Reading"; color: "#FFA500"; brightness: 80 }
        ListElement { name: "Watching TV"; color: "#FF4500"; brightness: 60 }
        ListElement { name: "Night Time"; color: "#0067ff"; brightness: 20 }
        ListElement { name: "Relaxing"; color: "#6100ff"; brightness: 50 }
        ListElement { name: "Gaming"; color: "#00FFFF"; brightness: 75 }
        ListElement { name: "Study Mode"; color: "#0088ff"; brightness: 85 }
        ListElement { name: "Dinner Time"; color: "#ff1e00"; brightness: 70 }
        ListElement { name: "Meditation"; color: "#07ff00"; brightness: 40 }
        ListElement { name: "Movie Night"; color: "#9400ff"; brightness: 30 }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.width / 4
        height: 40
        z: 100
        color: "transparent"

        Text {
            anchors.centerIn: parent
            font.pixelSize: 24
            color: "white"
            text: "▲"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                modes.decrementCurrentIndex()
            }
        }
    }

    PathView {
        id: modes
        anchors.fill: parent
        model: lightModeModel
        currentIndex: 0
        delegate: option

        path: Path {
            startX: root.width/2
            startY: 50

            PathAttribute { name: "itemZ"; value: 0 }
            PathAttribute { name: "itemAngle"; value: -20.0; }
            PathAttribute { name: "itemScale"; value: 0.8; }
            PathLine { x: root.width / 2; y: root.height * 0.75; }
            PathPercent { value: 0.48; }
            PathLine { x: root.width / 2; y: root.height * 0.4; }
            PathAttribute { name: "itemAngle"; value: 0.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathAttribute { name: "itemZ"; value: 100 }
            PathLine { x: root.width / 2; y: root.height * 0.5; }
            PathPercent { value: 0.52; }
            PathLine { x: root.width / 2; y: root.height * 0.75; }
            PathAttribute { name: "itemAngle"; value: 20.0; }
            PathAttribute { name: "itemScale"; value: 0.8; }
            PathAttribute { name: "itemZ"; value: 0 }
        }

        pathItemCount: 3
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        onCurrentIndexChanged: {
            lights.setProperty(selectedLight, "mode", lightModeModel.get(modes.currentIndex).name)
            if(lights.get(selectedLight).mode !== "Custom") {
                lightColor.setColor(lightModeModel.get(modes.currentIndex).color)
                brightnessController.value = parseInt(lightModeModel.get(modes.currentIndex).brightness)
            }
        }
    }

    property alias modes: modes

    Rectangle {
        anchors.bottom: parent.bottom
        width: root.width
        height: 40
        z: 100
        color: "Transparent"

        Text {
            anchors.centerIn: parent
            font.pixelSize: 24
            color: "white"
            text: "▼"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                modes.incrementCurrentIndex()
            }
        }
    }

    Component {
        id: option

        Option {
            id: wrapper
            width: 100
            height: 64
            antialiasing: true
            visible: PathView.onPath
            scale: PathView.itemScale
            z: PathView.itemZ

            property variant rotX: PathView.itemAngle
            opacity: 1.0 - Math.abs(rotX) / 90

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
                font.pixelSize: 20
                font.bold: true
                color: "white"
                text: model.name
            }
        }
    }
}
