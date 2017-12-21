import QtQuick 2.7
import QtQuick.Controls 2.2

Rectangle {
    id: root

    Text {
        id: selectedFileText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2 - 75
        font.pixelSize: 50
        text: "Converting file..."
    }

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2 - 10
        width: 60
        height: 60
        source: "qrc:/img/loading.png"
        RotationAnimator on rotation {
            running: true
            loops: Animation.Infinite
            duration: 2000
            from: 0 ; to: 360
        }
    }
}