import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    width: 250
    height: 300
    color: "Transparent"

    property string selectedColor: ""
    property int selectedBrightness

    ListModel {
        id: lightModeModel

        ListElement { name: "Custom"; color: ""; brightness: 0 }
        ListElement { name: "Working"; color: "#FFD700"; brightness: 90 }
        ListElement { name: "Reading"; color: "#FFA500"; brightness: 80 }
        ListElement { name: "Watching TV"; color: "#FF4500"; brightness: 60 }
        ListElement { name: "Night Time"; color: "#2E3B4E"; brightness: 20 }
        ListElement { name: "Relaxing"; color: "#9370DB"; brightness: 50 }
        ListElement { name: "Gaming"; color: "#00FFFF"; brightness: 75 }
        ListElement { name: "Study Mode"; color: "#4682B4"; brightness: 85 }
        ListElement { name: "Dinner Time"; color: "#FF6347"; brightness: 70 }
        ListElement { name: "Meditation"; color: "#008000"; brightness: 40 }
        ListElement { name: "Movie Night"; color: "#4B0082"; brightness: 30 }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.width / 4
        height: 40
        z: 100
        opacity: 0.7
        color: "Transparent"

        Text {
            anchors.centerIn: parent
            font.pixelSize: 24
            color: "white"
            text: "▲"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                modes.decrementCurrentIndex()
            }
        }
    }

    PathView {
        id: modes
        anchors.fill: parent
        delegate: flipCardDelegate
        model: lightModeModel
        currentIndex: 0

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
        opacity: 0.7
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
        id: flipCardDelegate

        LightModeOption {
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
                text: model.name
                font.pixelSize: 20
                font.bold: true
                color: "White"
            }
        }
    }
}
