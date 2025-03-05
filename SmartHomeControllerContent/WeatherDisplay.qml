import QtQuick
import QtQuick.Controls

Rectangle {
    id: weatherData
    width: 350
    height: 260
    radius: 10
    color: "transparent"

    property string city: "Helsinki"
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

        TextField {
            id: selectedCity
            anchors.top: todaysDate.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            anchors.leftMargin: 10
            background: Rectangle {
                implicitWidth: 180
                implicitHeight: 24
                border.width: 0
                color: "transparent"
            }
            font.pixelSize: 16
            color: "white"
            placeholderTextColor: "white"
            placeholderText: city

            TapHandler {
                onTapped: {
                    selectedCity.placeholderText = ""
                }
            }

            onEditingFinished: {
                if (text === "") {
                    text = city
                } else {
                    text = text.charAt(0).toUpperCase() + text.slice(1).toLowerCase()
                    city = text
                    fetchWeatherData(city)
                }
            }
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
        fetchWeatherData(city)
    }

    function fetchWeatherData(city) {
        const url = "https://api.openweathermap.org/data/2.5/weather?q=" + city.toLowerCase() + "&units=metric&appid=6c433438776b5be4ac86001dc88de74d"
        const httpRequest = new XMLHttpRequest();
        httpRequest.open("GET", url);
        httpRequest.onreadystatechange = function() {
            if(httpRequest.readyState === XMLHttpRequest.DONE) {
                console.log(httpRequest.status)
                if(httpRequest.status === 200) {
                    const response = JSON.parse(httpRequest.responseText);
                    city = response.name
                    weatherIcon = response.weather[0].icon
                    temperature = response.main.temp
                    windSpeedText.text = response.wind.speed + "m/s"
                }
                else if(httpRequest.status === 404) {
                    temperature = 0
                    windSpeedText.text = "Not found"
                }
                else {
                    windSpeedText.text = "Error while loading..."
                }
            } 
        }
        httpRequest.send();
    }
}
