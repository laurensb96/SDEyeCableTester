import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Studio.Components 1.0

Item {
    id: page2

    Rectangle {
        x: 20
        y: 160
        width: 120
        height: 300
        color: "#a0a0a0"
        radius: 20
    }

    Rectangle {
        x: 660
        y: 160
        width: 120
        height: 300
        color: "#a0a0a0"
        radius: 20
    }

    Text {
        x: 40
        y: 160
        width: 80
        height: 40
        text: qsTr("SIDE 1")
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    Text {
        x: 680
        y: 160
        width: 80
        height: 40
        text: qsTr("SIDE 2")
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    Item {
        id: item1
        x: 0
        Timer {
            interval: 50; running: true; repeat: true
            onTriggered: {time.text = Date().toString()}
        }

        Text { id: time }
    }

    Text {
        id: text1
        x: 193
        y: 72
        width: 89
        height: 52
        text: backend.val
        font.pixelSize: 30
    }
}
