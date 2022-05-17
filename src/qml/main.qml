import QtQuick

Window {
    id: window
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    Loader {
        id: loader
        anchors.fill: parent
    }

    Component {
        id: welcome
        Welcome {}
    }

    Component {
        id: hardCut
        HardCut {}
    }

    Component.onCompleted: {
        loader.sourceComponent = welcome
    }

    Connections {
        ignoreUnknownSignals: true
        target: loader.item

        function onStartWork() {
            loader.sourceComponent = hardCut
        }

        function onCloseHardCut() {
            loader.sourceComponent = welcome
        }
    }
}
