import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("TTS LibreOffice")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        ChooseFile {
            onStarted: function() {
                swipeView.currentIndex = 1;
                playing.stopAudio()
            }
            onFinished: function(){
                swipeView.currentIndex = 2
                playing.startAudio()
            }
        }

        LoadingFile {
        }

        PlayingPage {
            id: playing
            onBackToMainPage: swipeView.currentIndex = 0
        }
    }

    footer: TabBar {
        visible: false
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
        TabButton {
            text: qsTr("Third")
        }
    }
}
