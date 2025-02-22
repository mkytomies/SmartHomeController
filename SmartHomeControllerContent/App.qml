// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls 2.15
import SmartHomeController

Window {
    width: 1280
    height: 800
    color: "#222020"

    property string weatherIcon: "..."
    property double temperature: 0
    property double windSpeed: 0

    property bool toggleMusic: false
    property string musicControlIcon: "play_arrow.png"


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
                    color: "#222020"

                    Image {
                        id: menuIcon
                        anchors.centerIn: parent
                        width: 24
                        height: 24
                        source: "menu.png"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: openMenu()
                        }
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
                    color: "#222020"
                    opacity: 0.7
                    Column {
                        anchors.fill: weatherData
                        spacing: 10

                        Text {
                            id: todaysDate
                            y: 10
                            width: 200
                            color: "White"
                            font.pixelSize: 24
                            text: Qt.formatDateTime(new Date(), "dd/MM/yyyy")
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: todaysDate.bottom
                            width: 260
                            height: 210
                            Image {
                                anchors.horizontalCenter: parent.horizontalCenter
                                y: 10
                                width: 150
                                height: 150
                                source: "http://openweathermap.org/img/w/02n.png"
                            }
                            Row {
                                anchors.bottom: parent.bottom
                                width: 260
                                height: 130
                                Text {
                                    id: windSpeedText
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    color: "White"
                                    font.pixelSize: 20
                                    text: windSpeed +"m/s"
                                }

                                Rectangle {
                                    anchors.right: parent.right
                                    width: 130
                                    height: 130
                                    radius: 10
                                    color: "#757575"
                                    opacity: 60
                                    Text {
                                        anchors.centerIn: parent
                                        color: "White"
                                        font.pixelSize: 30
                                        font.bold: true
                                        text: temperature + "°C"
                                    }
                                }
                            }
                        }

                    }
                }
                Rectangle {
                    id: musicPlayer
                    width: 350
                    height: 120
                    color: "#757575"
                    opacity: 0.7
                    radius: 10

                    Column {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 350
                        height: 100
                        Column {
                            x: 20
                            y: 20
                            Text {
                                color: "White"
                                font.bold: true
                                text: "Song title"
                            }
                            Text {
                                color: "White"
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
                color: "#757575"
                opacity: 0.7
                radius: 10

                Loader {
                    anchors.fill: parent
                    id: mainViewLoader
                    source: "LightingView.qml"
                }
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

            Repeater {
                model: ListModel {
                    ListElement { name: "Lighting"; source: "LightingView.qml" }
                    ListElement { name: "Air Conditioner"; source: "ACView.qml" }
                    ListElement { name: "Security"; source: "SecurityView.qml" }
                }

                delegate: Rectangle {
                    id: rec1
                    width: 720 / 3 - 20
                    height: 215
                    color: "#757575"
                    opacity: 0.7
                    radius: 10

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var tempSource = mainViewLoader.source
                            mainViewLoader.source = model.source
                            model.setProperty(index, "source", tempSource)
                        }
                    }
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
        color: "#222020"

        Column {
            anchors.fill: menu
            Rectangle {
                anchors.right: parent.right
                width: 50
                height: 50
                color: "#222020"

                Image {
                    id: closeIcon
                    anchors.centerIn: parent
                    width: 24
                    height: 24
                    source: "close.png"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: closeMenu()
                    }
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
        const url = "https://api.openweathermap.org/data/2.5/weather?q=helsinki&units=metric&appid=6c433438776b5be4ac86001dc88de74d"
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("GET", url);
        httpRequest.onreadystatechange = function() {
            if(httpRequest.readyState === XMLHttpRequest.DONE) {
                if(httpRequest.status === 200) {
                    const response = JSON.parse(httpRequest.responseText);
                    weatherIcon = response.weather[0].icon
                    temperature = response.main.temp
                    windSpeed = response.wind.speed
                }
            }
            else {
                city = "Virhe latauksessa..."
            }
        }
        httpRequest.send();
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

