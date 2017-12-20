import QtQuick 2.7
import QtQuick.Controls 2.2

Rectangle {
    id: root

    Text {
        id: selectedFileText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2 - 25
        font.pixelSize: 50
        text: "Converting files..."
    }

    BusyIndicator {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.horizontalCenter
        running: true
    }
}