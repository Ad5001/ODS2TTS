import QtQuick 2.7
import QtQuick.Controls 2.2
import QtMultimedia 5.8



Rectangle {

    id: root

    
    signal backToMainPage()
    

    
    function startAudio(){
        playAudio.source = "file:///tmp/out.wav"
        playAudio.play();
    }
    function stopAudio(){
        playAudio.stop()
        playAudio.source = "";
    }

    Audio {
        id: playAudio
        property var paused: false
        autoLoad: false
        audioRole: Audio.MusicRole
    }

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2 - 50
        contentItem: Text {
            text: "Back to select a file"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: root.backToMainPage()
    }

    Rectangle {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.bottom
        anchors.topMargin: -90
        height: 60

        Button {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            id: playPauseButton
            background: Image {
                source: "qrc:/img/pause.png"
                width: 50
                height: 50
            }
            width: 50
            height: 50
            onClicked: function(){
                if(playAudio.paused){
                    playAudio.play()
                    playPauseButton.background.source = "qrc:/img/pause.png"
                } else {
                    playAudio.pause()
                    playPauseButton.background.source = "qrc:/img/play.png"
                }
                playAudio.paused = !playAudio.paused
            }
        }

        ProgressBar {
            id: progress
            value: 0.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 60
            height: 20
            width: 450
            background: Rectangle {
                anchors.left: progress.left
                anchors.leftMargin: -5
                width: 450
                height: 25
                anchors.verticalCenter: parent.verticalCenter
                color: "#000000"
                border.color: "#000000"
                border.width: 5
                radius: 13
            }
            contentItem: Rectangle {
                anchors.left: progress.left
                anchors.verticalCenter: progress.verticalCenter
                width: progress.visualPosition * progress.width
                height: 15
                color: "#ffffff"
                border.color: "#ffffff"
                border.width: 5
                radius: 20
            }
        }

        Slider {
            anchors.left: progress.left
            anchors.verticalCenter: progress.verticalCenter
            anchors.leftMargin: -20
            width: 450
            height: 15
            id: setSlider
            from: 0
            to: 1
            stepSize: 0.0001
            onMoved: function(){
                playAudio.seek(setSlider.value * playAudio.duration);
            }
            opacity: 0.01
        }

        Text {
            id: timeText
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: progress.left
            anchors.leftMargin: 450
            height: 25
            text: "00:00/00:00"
        }
    }

    Timer {
        interval: 500 
        running: true
        repeat: true
        onTriggered:function(){
            progress.value = playAudio.position / playAudio.duration
            var currentSecs = Math.round(playAudio.position / 1000)|0;
            var durationSecs = Math.round(playAudio.duration / 1000)|0;
            var currentMinutes = Math.floor(currentSecs / 60);
            if(currentMinutes < 10) currentMinutes = "0" + currentMinutes;
            var durationMinutes = Math.floor(durationSecs / 60)
            if(durationMinutes < 10) durationMinutes = "0" + durationMinutes;
            var currentSetSecs = currentSecs % 60;
            if(currentSetSecs < 10) currentSetSecs = "0" + currentSetSecs;
            var durationSetSecs = durationSecs % 60;
            if(durationSetSecs < 10) durationSetSecs = "0" + durationSetSecs;
            timeText.text = currentMinutes + ":" + currentSetSecs + "/" + durationMinutes + ":" + durationSetSecs
            setSlider.value = progress.value
        }
    }
}
