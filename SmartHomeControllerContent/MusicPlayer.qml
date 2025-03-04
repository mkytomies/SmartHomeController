import QtQuick
import QtMultimedia
import QtQuick.Controls

Rectangle {
    id: musicPlayer
    width: 350
    height: 120
    radius: 10
    color: "#5c5b5b"

    property bool toggleMusic: false
    property string musicControlIcon: "play_arrow.png"
    property int selectedSong: 0

    ListModel {
        id: songs

        ListElement { Id: 1; songTitle : "Gardens"; artist: "Penguinmusic"; source: "gardens.mp3"}
        ListElement { Id: 2; songTitle : "Groovy Ambient Funk"; artist: "Moodmode"; source: "groovy.mp3"}
    }

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
                text: songs.get(selectedSong).songTitle
            }

            Text {
                color: "white"
                text: songs.get(selectedSong).artist
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

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedSong = (selectedSong - 1 + songs.count) % songs.count
                        updateSong()
                    }
                }
            }

            Image {
                id: pauseAndPlay
                width: 24
                height: 24
                source: musicControlIcon

                MediaPlayer {
                    id: music
                    audioOutput: AudioOutput {}
                    autoPlay: false
                    source: songs.get(selectedSong).source

                    onMediaStatusChanged: {
                        if(mediaStatus === MediaPlayer.EndOfMedia) {
                            if(selectedSong === songs.count - 1) {
                                musicControlIcon = "play_arrow.png";
                                toggleMusic = false;
                            } else {
                                selectedSong++
                                music.source = songs.get(selectedSong).source;
                                music.play();
                            }
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: musicControls()
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
                        selectedSong = (selectedSong + 1) % songs.count
                        updateSong()
                    }
                }
            }
        }
    }
    function musicControls() {
        toggleMusic = !toggleMusic
        if(toggleMusic) {
            music.play()
            musicControlIcon = "pause.png"
        }
        else {
            music.pause()
            musicControlIcon = "play_arrow.png"
        }
    }

    function updateSong() {
        music.stop()
        music.source = songs.get(selectedSong).source
        if (toggleMusic) {
            music.play()
        }
    }
}
