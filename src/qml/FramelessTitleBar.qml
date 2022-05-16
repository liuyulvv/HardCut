import QtQuick

Rectangle {
    property color backgroundColor : "#121212"
    property int barWidth : parent.width
    property int barHeight : parent.height
    width : barWidth
    height : barHeight
    color : backgroundColor
    DragHandler {
        grabPermissions : TapHandler.CanTakeOverFromAnything
        onActiveChanged : if (active) {
            window.startSystemMove();
        }
    }
}
