import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Studio.Components 1.0

import laurens.mybackend

Window {
    id: window
    width: 800
    height: 480
    visible: true
    color: "#d4d4d4"
    title: qsTr("Hello World")

    MyBackend{
        id: backend
    }

    Rectangle {
        x: 20
        y: 200
        width: 120
        height: 260
        color: "#a0a0a0"
        radius: 20
    }

    Rectangle {
        x: 660
        y: 200
        width: 120
        height: 260
        color: "#a0a0a0"
        radius: 20
    }

    Text {
        x: 680
        y: 200
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

    Column {
        id: column
        x: 70
        y: 230
        width: 600
        height: 400
        clip: false
        spacing: 0

        property variant cableNames: ["PWR1+","PWR1-","PWR2+","PWR2-","CTRL1","CTRL2"]
        property variant cableColors: ["#ff0000","#ffffff","#ff0000","#ffffff","#00ff00","#00ff00"]

        Repeater {
            id: repeater
            model: 6

            Item {
                id: item2
                width: 200
                height: 30

                Text {
                    id: textSide1
                    x: 0
                    y: 0
                    width: 80
                    height: 30
                    text: qsTr(column.cableNames[index])
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.bold: false
                }

                Text {
                    id: textSide2
                    x: 600
                    y: 0
                    width: 80
                    height: 30
                    text: qsTr(column.cableNames[index])
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.bold: false
                }

                Rectangle {
                    id: rectangle
                    x: 70
                    y: 12
                    width: 220
                    height: 4
                    color: column.cableColors[index]
                }

                Rectangle {
                    id: rectangle1
                    x: 370
                    y: 12
                    width: 220
                    height: 4
                    color: column.cableColors[index]
                    transformOrigin: Item.Center
                }
            }
        }
    }


    Text {
        x: 40
        y: 200
        width: 80
        height: 40
        text: qsTr("SIDE 1")
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    Rectangle {
        id: rectangle2
        x: 270
        y: 242
        width: 288
        height: 10
        color: "#c1c946"
        transformOrigin: Item.TopLeft
        rotation: 90
    }

    Rectangle {
        id: rectangle3
        x: rectangle2.x + 30
        y: rectangle2.y + 30
        width: 288
        height: 10
        color: "#efff00"
        rotation: 90
        transformOrigin: Item.TopLeft
    }
    
    Dial {
        id: dial
        x: 660
        y: 29

        Connections {
            target: dial
            onMoved: {
                backend.val = dial.value
            }
        }
        to: 10
    }



}
