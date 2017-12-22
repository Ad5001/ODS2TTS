import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
import Process 1.0

Rectangle {
    id: root
    
    property var choosenFile: "";
    property var choosenLang: "fr-FR";
    property var textFileContents: ""

    
    signal started()
    signal finished()
    


    FileDialog {
        id: fileDialog
        title: "Select a LibreOffice document"
        nameFilters: [ "Libre Office documents (*.odt *.ods *.odg *.odf)", "All files (*)" ]
        onAccepted: {
            root.choosenFile = fileDialog.fileUrl.toString().replace("file://", "");
            selectedFileText.text = "Selected file: " + root.choosenFile
        }
        selectExisting: true
        folder: shortcuts.documents
    }

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2 - 70
        contentItem: Text {
            text: "Select a file"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: fileDialog.visible = true
    }

    Text {
        id: selectedFileText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2 - 25
        text: ""
    }

    ComboBox {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2
        currentIndex: 0
        model: ["French", "English", "German", "Spanish"]
        property var langData: [
            "fr-FR",
            "en-US",
            "de-DE",
            "es-ES"
        ]
        width: 200
        onCurrentIndexChanged: function(){
            root.choosenLang = langData[currentIndex];
        }
    }

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: -80
        contentItem: Text {
            text: "Speak file contents"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: function(){
            root.started();
            odt2TxtProc.start("odt2txt", [root.choosenFile], false);
        }
    }

    Process {
        id: odt2TxtProc
        onFinished: function(){
            var text = readAll().toString().replace(/\n/img, "").replace(/\[-- ([\w]+): Objet(\d+) --\]/img, ", $1$2 ,");
            txt2waveProc.start("pico2wave", ["-l=" + root.choosenLang, "-w=/tmp/out.wav", '"' + text.replace('"', "'") + '"'], false);
        }
    }

    Process {
        id: txt2waveProc
        onFinished: function(){
            root.finished();
        }
    }
}
