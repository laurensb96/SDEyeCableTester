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

    Connections {
        target: window
        onAfterRendering: backend.appState = true
    }

    SwipeView {
        id: view

        currentIndex: 0
        anchors.fill: parent

        Page1{}
        Page2{}
        Item {
            id: page3
        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
