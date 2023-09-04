import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Studio.Components 1.0

Item {
    id: page1

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

    Column {
        id: column
        x: 70
        y: 200
        width: 600
        height: 400
        clip: false
        spacing: 0

        property variant cableNames: ["PWR1+","PWR1-","PWR2+","PWR2-","CTRL1","CTRL2","FIB1","FIB2"]
        property variant cableColors: ["#ff0000","#ffffff","#ff0000","#ffffff","#00ff00","#00ff00","#7800ff","#7800ff"]

        Repeater {
            id: repeater
            model: 8

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

    Text {
        id: text1
        x: 193
        y: 72
        width: 89
        height: 52
        text: backend.val
        font.pixelSize: 30
    }

    Button {
        id: button
        x: 396
        y: 29
        text: qsTr("Button")

        Connections {
            target: button
            onClicked: {
                console.log("button.clicked")
                console.log(repeater.itemAt(0).y)
                console.log(repeater.itemAt(2).y)
                rectangle3.x = 180
                rectangle3.y = 242
                rectangle3.width = repeater.itemAt(2).y - repeater.itemAt(0).y
            }
        }
    }

    Row {
        id: row
        x: 170
        y: 212
        width: 508
        height: 238
        spacing: 20

        Repeater {
            id: repeater1
            model: backend.arr.length

            Rectangle {
                id: rectangle3
                x: 0
                y: backend.arr[index][0]*30
                width: 4
                height: (backend.arr[index][1]-backend.arr[index][0])*30+width
                //color: "#efff00"
                rotation: 0
                transformOrigin: Item.TopLeft
                gradient: Gradient {
                        GradientStop { position: 0.0; color: column.cableColors[backend.arr[index][0]] }
                        GradientStop { position: 1.0; color: column.cableColors[backend.arr[index][1]] }
                    }
            }
        }
    }
}
