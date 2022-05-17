import QtQuick

Rectangle {
    property int buttonSize: 45
    property url imageSource: ""
    property string buttonText: ""
    width: buttonSize
    height: buttonSize
    color: "transparent"

    Image {
        id: buttonImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: buttonSize / 9
        width: buttonSize / 2
        height: buttonSize / 2
        source: imageSource
    }

    Text {
        anchors.top: buttonImage.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: buttonText
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("clicked")
        }
    }
}
