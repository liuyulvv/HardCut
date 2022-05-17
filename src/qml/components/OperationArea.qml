import QtQuick
import "../utils/" as Utils

Rectangle {
    anchors.fill: parent
    color: "transparent"

    Utils.ActionButton {
        imageSource: "qrc:/images/media.png"
    }
}
