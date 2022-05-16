import QtQuick

Window {
    id: window
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"
    width: 850
    height: 564

    Loader {
        id: loader
        anchors.fill: parent
    }

    Component {
        id: welcome
        Welcome {}
    }

    Component.onCompleted: {
        loader.sourceComponent = welcome
    }
}
