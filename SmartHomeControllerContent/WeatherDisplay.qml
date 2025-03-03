import QtQuick
import QtQuick.Controls

Rectangle {
    id: weatherData
    width: 350
    height: 260
    radius: 10
    color: "transparent"

    property string city: "helsinki"
    property string weatherIcon: ""
    property double windSpeed: 0
    property double temperature: 0

    Column {
        anchors.fill: weatherData
        spacing: 10

        Text {
            id: todaysDate
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 15
            anchors.leftMargin: 20
            width: 200
            font.pixelSize: 24
            color: "white"
            text: Qt.formatDateTime(new Date(), "dd/MM/yyyy")
        }

        Text {
            anchors.top: todaysDate.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            anchors.leftMargin: 20
            font.pixelSize: 16
            color: "white"
            text: city
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: todaysDate.bottom
            width: 260
            height: 210

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 150
                height: 150
                y: 10
                source: "http://openweathermap.org/img/w/" + weatherIcon + ".png"
            }

            Row {
                anchors.bottom: parent.bottom
                width: 260
                height: 130

                Text {
                    id: windSpeedText
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    font.pixelSize: 20
                    color: "white"
                    text: windSpeed +"m/s"
                }

                Rectangle {
                    anchors.right: parent.right
                    width: 130
                    height: 130
                    radius: 10
                    opacity: 0.8
                    color: "#757575"

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                        color: "white"
                        text: temperature + "°C"
                    }
                }
            }
        }

    }

    Component.onCompleted: {
        fetchWeatherData()
    }

    function fetchWeatherData() {
        const url = "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&units=metric&appid=6c433438776b5be4ac86001dc88de74d"
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("GET", url);
        httpRequest.onreadystatechange = function() {
            if(httpRequest.readyState === XMLHttpRequest.DONE) {
                if(httpRequest.status === 200) {
                    const response = JSON.parse(httpRequest.responseText);
                    city = response.name
                    weatherIcon = response.weather[0].icon
                    temperature = response.main.temp
                    windSpeed = response.wind.speed
                }
            }
            else {
                windSpeed = "Error while loading..."
            }
        }
        httpRequest.send();
    }
}
