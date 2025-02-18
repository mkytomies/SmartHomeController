// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import SmartHomeController

Window {
    width: 1280
    height: 800
    color: "#222020"

    visible: true
    title: "SmartHomeController"

    property date currentDate: 01-01-2025

    Column {
        anchors.centerIn: parent
        spacing: 30

        Rectangle {
            id: topBar
            width: 1100
            height: 50
            color: "#757575"

            Row {
                anchors.fill: topBar
                Rectangle {
                    id: roomNav
                    anchors.left: parent.left
                    width: 1050
                    height: 50
                }
                Rectangle {
                    id: hamburger
                    anchors.right: parent.right
                    width: 50
                    height: 50
                    color: "Red"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: openMenu()
                    }
                }
            }
        }

        Row {
            id: topRow
            anchors.horizontalCenter: parent.horizontalCenter
            width: 1100
            height: 400
            spacing: 30
            Column {
                width: 350
                spacing: 20
                Rectangle {
                    id: weatherData
                    width: 350
                    height: 260
                    color: "#757575"
                    opacity: 0.7
                    Text {
                        text: "Date: "
                        color: "White"
                    }
                }
                Rectangle {
                    width: 350
                    height: 120
                    color: "#757575"
                    opacity: 0.7
                    radius: 10
                }
            }
            Rectangle {
                width: 720
                height: 400
                color: "#757575"
                opacity: 0.7
                radius: 10
            }
        }

        Row {
            id: bottomRow
            anchors.horizontalCenter: parent.horizontalCenter
            width: 1100
            height: 215
            spacing: 30
            Rectangle {
                width: 350
                height: 215
                color: "#757575"
                opacity: 0.7
                radius: 10
            }
            Row {
                spacing: 15
                Rectangle {
                    width: 230
                    height: 215
                    color: "#757575"
                    opacity: 0.7
                    radius: 10
                }
                Rectangle {
                    width: 230
                    height: 215
                    color: "#757575"
                    opacity: 0.7
                    radius: 10
                }
                Rectangle {
                    width: 230
                    height: 215
                    color: "#757575"
                    opacity: 0.7
                    radius: 10
                }
            }
        }
    }

    Rectangle {
        id: menu
        width: 480
        height: 800
        anchors.right: parent.right
        visible: false
        Column {
            anchors.fill: menu
            Rectangle {
                width: 50
                height: 50
                color: "Red"
                anchors.right: parent.right

                MouseArea {
                    anchors.fill: parent
                    onClicked: closeMenu()
                }
            }
        }
    }

    function openMenu() {
        menu.visible = true
    }

    function closeMenu() {
        menu.visible = false
    }


    Component.onCompleted: fetchWeatherData()

    function fetchWeatherData() {
    }
}

