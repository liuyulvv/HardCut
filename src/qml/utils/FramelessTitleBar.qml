import QtQuick

Rectangle {
    property color backgroundColor: "transparent"
    property int barWidth: parent.width
    property int barHeight: parent.height
    property bool resizable: false

    width: barWidth
    height: barHeight
    color: backgroundColor

    signal toggleMaximized

    DragHandler {
        grabPermissions: TapHandler.CanTakeOverFromAnything
        onActiveChanged: if (active) {
                             window.startSystemMove()
                         }
    }

    // 更改窗口大小
    DragHandler {
        id: resizeHandler
        target: null
        onActiveChanged: if (active) {
                             const p = resizeHandler.centroid.pressPosition
                             const b = 5
                             let e = 0
                             if (p.x < b && p.y < b) {
                                 e |= Qt.LeftEdge
                                 e |= Qt.TopEdge
                                 window.startSystemResize(e)
                             } else if (p.x >= window.width - b && p.y < b) {
                                 e |= Qt.RightEdge
                                 e |= Qt.TopEdge
                                 window.startSystemResize(e)
                             } else if (p.x < b) {
                                 e |= Qt.LeftEdge
                                 window.startSystemResize(e)
                             } else if (p.x >= window.width - b) {
                                 e |= Qt.RightEdge
                                 window.startSystemResize(e)
                             } else if (p.y < b) {
                                 e |= Qt.TopEdge
                                 window.startSystemResize(e)
                             }
                         }
    }

    TapHandler {
        onTapped: if (tapCount === 2)
                      toggleMaximized()
        gesturePolicy: TapHandler.DragThreshold
    }
}
