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

                MusicPlayer {}
            }

            Rectangle {
                id: mainView
                width: 720
                height: 400
                radius: 10
                color: "Transparent"

                LightingView {
                    id: lights
                    visible: true
                }

                ACView {
                    id: ac
                    visible: false
                }

                SecurityView {
                    id: security
                    visible: false
                }
            }
        }

        Row {
            id: bottomRow
            anchors.horizontalCenter: parent.horizontalCenter
            width: 1100
            height: 197
            spacing: 30

            SecurityCamera {}

            Repeater {
                model: ListModel {
                    ListElement { Id: "lights"; name: "Lighting"; image: "lightbulb-on.png" }
                    ListElement { Id: "ac"; name: "AC"; image: "ac.png" }
                    ListElement { Id: "security"; name: "Security"; image: "lock.png" }
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
                            lights.visible = model.Id === "lights"
                            ac.visible = model.Id === "ac"
                            security.visible = model.Id === "security"
                        }
                    }
                }
            }
        }
    }
}

