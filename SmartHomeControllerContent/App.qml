// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls 2.15
import QtMultimedia
import SmartHomeController

Window {
    width: 1280
    height: 800
    color: "#222020"

    visible: true
    title: "SmartHomeController"

    property bool toggleMusic: false
    property string musicControlIcon: "play_arrow.png"

    Column {
        anchors.centerIn: parent
        spacing: 30

        Row {
            id: topRow
            anchors.horizontalCenter: parent.horizontalCenter
            width: 1100
            height: 400
            spacing: 30

            Column {
                width: 350
                spacing: 20

                WeatherDisplay {}

                Rectangle {
                    id: musicPlayer
                    width: 350
                    height: 120
                    radius: 10
                    color: "#5c5b5b"

                    Column {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 350
                        height: 100

                        Column {
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.margins: 20

                            Text {
                                font.bold: true
                                color: "white"
                                text: "Song title"
                            }

                            Text {
                                color: "white"
                                text: "Artist"
                            }
                        }

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom

                            Image {
                                id: previous
                                width: 24
                                height: 24
                                source: "skip_previous.png"
                            }

                            Image {
                                id: pauseAndPlay
                                width: 24
                                height: 24
                                source: musicControlIcon

                                MouseArea {
                                    anchors.fill: parent
                                    onPressed: musicControls()
                                }
                            }

                            Image {
                                id: next
                                width: 24
                                height: 24
                                source: "skip_next.png"
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: mainView
                width: 720
                height: 400
                radius: 10
                color: "Transparent"

                Loader {
                    id: mainViewLoader
                    anchors.fill: parent
                    source: "LightingView.qml"
                }
            }
        }

        Row {
            id: bottomRow
            anchors.horizontalCenter: parent.horizontalCenter
            width: 1100
            height: 197
            spacing: 30

            Rectangle {
                width: 350
                height: 197
                radius: 10
                color: "Transparent"

                MediaPlayer {
                    id: securityCamera
                    audioOutput: AudioOutput {}
                    videoOutput: videoOutput
                    loops: MediaPlayer.Infinite
                    source: "security-camera-placeholder.mp4"
                }

                VideoOutput {
                    id: videoOutput
                    anchors.fill: parent
                }
            }

            Repeater {
                model: ListModel {
                    ListElement { name: "Lighting"; source: "LightingView.qml"; image: "lightbulb-on.png" }
                    ListElement { name: "AC"; source: "ACView.qml"; image: "ac.png" }
                    ListElement { name: "Security"; source: "SecurityView.qml"; image: "lock.png" }
                }

                delegate: Rectangle {
                    width: 720 / 3 - 20
                    height: 197
                    radius: 10
                    color: "#5c5b5b"

                    Image {
                        id: navImage
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 50
                        width: 60
                        height: 60
                        source: model.image
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: navImage.bottom
                        anchors.topMargin: 10
                        font.pixelSize: 20
                        font.bold: true
                        color: "white"
                        text: model.name
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mainViewLoader.source = model.source
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        securityCamera.play()
    }

    function musicControls() {
        toggleMusic = !toggleMusic
        if(toggleMusic) {
            musicControlIcon = "pause.png"
        }
        else {
            musicControlIcon = "play_arrow.png"
        }
    }

}

