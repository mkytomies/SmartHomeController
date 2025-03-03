import QtQuick
import QtQuick.Controls

Rectangle {
    id: timerController
    width: 260
    height: 245
    color: "#5c5b5b"

    property int selectedMinutes: 0
    property int selectedHours: 0
    property bool timerStatus: false

    signal timerStarted()
    signal timerEnded()

    Row {
        id: timerRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: 170
        height: 170
        spacing: 10

        Column {
            id: hours
            width: parent.width / 2
            height: parent.height

            Text {
                id: hoursText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "#c8c5c5"
                text: "Hours:"
            }

            PathView {
                id: hoursPath
                anchors.fill: parent
                anchors.top: hoursText.bottom
                anchors.topMargin: 30
                model: 24
                currentIndex: 0
                delegate: option

                path: Path {
                    startX: hours.width / 2
                    startY: 10

                    PathAttribute { name: "itemZ"; value: 0 }
                    PathAttribute { name: "itemAngle"; value: -20.0; }
                    PathAttribute { name: "itemScale"; value: 0.8; }
                    PathLine { x: hours.width / 2; y: hours.height * 0.1; }
                    PathPercent { value: 0.48; }
                    PathLine { x: hours.width / 2; y: hours.height * 0.5; }
                    PathAttribute { name: "itemAngle"; value: 0.0; }
                    PathAttribute { name: "itemScale"; value: 1.0; }
                    PathAttribute { name: "itemZ"; value: 100 }
                    PathLine { x: hours.width / 2; y: hours.height * 0.8; }
                    PathPercent { value: 0.52; }
                    PathLine { x: hours.width / 2; y: hours.height * 0.8; }
                    PathAttribute { name: "itemAngle"; value: 20.0; }
                    PathAttribute { name: "itemScale"; value: 0.8; }
                    PathAttribute { name: "itemZ"; value: 0 }
                }

                pathItemCount: 3
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5

                onCurrentIndexChanged: {
                    selectedHours = currentIndex
                }
            }


        }

        Column {
            id: minutes
            width: parent.width / 2
            height: parent.height

            Text {
                id: minutesText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "#c8c5c5"
                text: "Minutes:"
            }

            PathView {
                id: minutesPath
                anchors.fill: parent
                anchors.top: minutesText.bottom
                anchors.topMargin: 30
                model: 60
                currentIndex: 0
                delegate: option

                path: Path {
                    startX: minutes.width / 2
                    startY: 10

                    PathAttribute { name: "itemZ"; value: 0 }
                    PathAttribute { name: "itemAngle"; value: -20.0; }
                    PathAttribute { name: "itemScale"; value: 0.8; }
                    PathLine { x: minutes.width / 2; y: minutes.height * 0.1; }
                    PathPercent { value: 0.48; }
                    PathLine { x: minutes.width / 2; y: minutes.height * 0.5; }
                    PathAttribute { name: "itemAngle"; value: 0.0; }
                    PathAttribute { name: "itemScale"; value: 1.0; }
                    PathAttribute { name: "itemZ"; value: 100 }
                    PathLine { x: minutes.width / 2; y: minutes.height * 0.8; }
                    PathPercent { value: 0.52; }
                    PathLine { x: minutes.width / 2; y: minutes.height * 0.8; }
                    PathAttribute { name: "itemAngle"; value: 20.0; }
                    PathAttribute { name: "itemScale"; value: 0.8; }
                    PathAttribute { name: "itemZ"; value: 0 }
                }

                pathItemCount: 3
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5

                onCurrentIndexChanged: {
                    selectedMinutes = currentIndex
                }
            }
        }

        Component {
            id: option

            Option {
                id: wrapper
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
                    font.pixelSize: 32
                    font.bold: true
                    color: "White"
                    text: model.index
                }
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: 200
        height: 50

        Rectangle {
            id: startButton
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width / 2 - 10
            height: 30
            radius: 15
            color: "#979797"

            Text {
                anchors.centerIn: parent
                color: "White"
                text: (!timerStatus ? "Start" : "Cancel")
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (selectedHours !== 0 || selectedMinutes !== 0) {
                        timerStatus = !timerStatus;

                        if (timerStatus) {
                            minuteTimer.running = minutesPath.currentIndex !== 0;
                            hourTimer.running = hoursPath.currentIndex !== 0;

                            timerStarted()
                    } else {
                        minuteTimer.running = false;
                        hourTimer.running = false;
                        }
                    }
                }
            }

            Timer {
                id: minuteTimer
                interval: 60000
                running: false
                repeat: true
                onTriggered: {
                    if (minutesPath.currentIndex > 0) {
                        minutesPath.currentIndex -= 1;
                    }
                    if (hoursPath.currentIndex > 0 && minutesPath.currentIndex === 0) {
                        minutesPath.currentIndex = 59;
                        hoursPath.currentIndex -= 1;
                    } else {
                        timerStatus = false;
                        timerEnded()
                        minuteTimer.running = false;
                        hourTimer.running = false;
                    }
                }
                }

            Timer {
                id: hourTimer
                interval: 3600000
                running: false
                repeat: true
                onTriggered: {
                    if (hoursPath.currentIndex > 0) {
                        hoursPath.currentIndex -= 1;
                    } else {
                        hourTimer.running = false;
                    }
                }
            }
        }
    }
}
