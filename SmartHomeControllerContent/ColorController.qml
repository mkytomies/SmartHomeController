import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Control {
    id: colorcontroller
    width: 175
    height: 175
    property real ringWidth: 25
    property real hsvValue: 1.0
    property real hsvSaturation: 1.0
    property color lightColor: Qt.hsva(colorWheelMouseArea.angle, 1.0, 1.0, 1.0)

    function setColor(hexColor) {
        let rgb = hexToRgb(hexColor);
        let hsv = rgbToHsv(rgb.r, rgb.g, rgb.b);
        lights.setProperty(selectedLight, "color", hexColor);
        innerCircle.color = hexColor
        colorWheelMouseArea.angle = hsv.hue;
    }

    function hexToRgb(hex) {
        if (hex.charAt(0) === "#") {
            hex = hex.substr(1);
        }
        let bigint = parseInt(hex, 16);
        let r = (bigint >> 16) & 255;
        let g = (bigint >> 8) & 255;
        let b = bigint & 255;
        return { r: r, g: g, b: b };
    }

    function rgbToHsv(r, g, b) {
        r /= 255;
        g /= 255;
        b /= 255;

        let max = Math.max(r, g, b), min = Math.min(r, g, b);
        let h, s, v = max;
        let d = max - min;
        s = max === 0 ? 0 : d / max;

        if (max === min) {
            h = 0;
        } else {
            switch (max) {
                case r: h = (g - b) / d + (g < b ? 6 : 0); break;
                case g: h = (b - r) / d + 2; break;
                case b: h = (r - g) / d + 4; break;
            }
            h /= 6;
        }

        return { hue: h, saturation: s, value: v };
    }

    contentItem: Item {
        implicitWidth: 175
        implicitHeight: width

        Image {
            id: colorWheel
            anchors.centerIn: parent
            width: colorcontroller.width
            height: width
            source: "colorwheel.png"

            Rectangle {
                id: innerCircle
                anchors.centerIn: parent
                width: 60
                height: 60
                radius: 30
                color: setColor(lights.get(selectedLight).color)
            }

            Rectangle {
                id: indicator
                x: (parent.width - width) / 2
                y: colorcontroller.ringWidth * 0.1
                width: colorcontroller.ringWidth * 0.8; height: width
                radius: width / 2
                color: 'white'
                border {
                    width: colorWheelMouseArea.containsPress ? 3 : 1
                    color: Qt.lighter(colorcontroller.lightColor)
                    Behavior on width { NumberAnimation { duration: 50 } }
                }

                transform: Rotation {
                    angle: colorWheelMouseArea.angle * 360
                    origin.x: indicator.width/2
                    origin.y: colorcontroller.availableHeight/2 - indicator.y
                }
            }
        }

        MouseArea {
            id: colorWheelMouseArea
            anchors.fill: parent

            property real angle: Math.atan2(width / 2 - mouseX, mouseY - height / 2) / 6.2831 + 0.5

            onPressed: {
                angle = Math.atan2(width / 2 - mouseX, mouseY - height / 2) / 6.2831 + 0.5;
                updateIndicator();
            }

            onPositionChanged: {
                angle = Math.atan2(width / 2 - mouseX, mouseY - height / 2) / 6.2831 + 0.5;
                updateIndicator();
            }

            function updateIndicator() {
                if(lights.get(selectedLight).mode !== "Custom") {
                    lights.setProperty(selectedLight, "mode", "Custom")
                }

                colorcontroller.lightColor = Qt.hsva(colorWheelMouseArea.angle, 1.0, 1.0, 1.0);
                innerCircle.color = Qt.hsva(colorWheelMouseArea.angle, 1.0, 1.0, 1.0);
            }
        }

    }
}
