import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 250
    height: 350

    ListModel {
        id: lightModeModel

        ListElement { name: "Working" }
        ListElement { name: "Reading" }
        ListElement { name: "Watching TV" }
        ListElement { name: "Night Time" }
        ListElement { name: "Relaxing" }
        ListElement { name: "Gaming" }
        ListElement { name: "Study Mode" }
        ListElement { name: "Dinner Time" }
        ListElement { name: "Meditation" }
        ListElement { name: "Movie Night" }
    }

    PathView {
        anchors.fill: parent

        delegate: flipCardDelegate
        model: lightModeModel

        path: Path {
            startX: root.width/2
            startY: 0

            PathAttribute { name: "itemZ"; value: 0 }
            PathAttribute { name: "itemAngle"; value: -90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathLine { x: root.width/2; y: root.height*0.4; }
            PathPercent { value: 0.48; }
            PathLine { x: root.width/2; y: root.height*0.5; }
            PathAttribute { name: "itemAngle"; value: 0.0; }
            PathAttribute { name: "itemScale"; value: 1.0; }
            PathAttribute { name: "itemZ"; value: 100 }
            PathLine { x: root.width/2; y: root.height*0.6; }
            PathPercent { value: 0.52; }
            PathLine { x: root.width/2; y: root.height; }
            PathAttribute { name: "itemAngle"; value: 90.0; }
            PathAttribute { name: "itemScale"; value: 0.5; }
            PathAttribute { name: "itemZ"; value: 0 }
        }

        pathItemCount: lightModeModel.count

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
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
                font.pixelSize: 16
                color: "White"
            }
        }
    }
}
