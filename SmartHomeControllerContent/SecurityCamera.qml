import QtQuick
import QtMultimedia
import QtQuick.Controls

Rectangle {
    width: 350
    height: 197
    radius: 10
    color: "Black"

    property int selectedCamera: 0

    ListModel {
        id: securityFootage

        ListElement { source: "security-camera-placeholder.mp4" }
        ListElement { source: "security-camera-placeholder2.mp4" }
    }

    MediaPlayer {
        id: securityCamera
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
        loops: MediaPlayer.Infinite
        source: securityFootage.get(selectedCamera).source
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }

    Row {
        anchors.centerIn: parent
        anchors.bottom: parent.bottom
        width: parent.width * 0.95
        spacing: parent.width * 0.81

        Image {
            id: previous
            width: 24
            height: 24
            source: "skip_previous.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    selectedCamera = (selectedCamera - 1 + securityFootage.count) % securityFootage.count
                    updateFootage()
                }
            }
        }

        Image {
            id: next
            width: 24
            height: 24
            source: "skip_next.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    selectedCamera = (selectedCamera + 1) % securityFootage.count
                    updateFootage()
                }
            }
        }
    }

    function updateFootage() {
        securityCamera.stop()
        securityCamera.source = securityFootage.get(selectedCamera).source
        securityCamera.play()
    }

    Component.onCompleted: {
        securityCamera.play()
    }
}

