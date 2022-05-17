import QtQuick
import "./utils/" as Utils

Rectangle {
    property int rectangleRadius: 15
    property int leftBarWidth: 213
    property int topTitleBarHeight: 30
    property int buttonSize: 26
    signal closeHardCut

    QtObject {
        id: internal
        property int lastVisibility: 0
        property int lastWidth: 1536
        property int lastHeight: 873
    }

    anchors.fill: parent
    color: "#1b1b1c"

    // 修改鼠标样式
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: {
            const p = Qt.point(mouseX, mouseY)
            const b = 5
            if (p.x < b && p.y < b)
                // 左上角
                return Qt.SizeFDiagCursor
            if (p.x >= width - b && p.y >= height - b)
                // 右下角
                return Qt.SizeFDiagCursor
            if (p.x >= width - b && p.y < b)
                // 右上角
                return Qt.SizeBDiagCursor
            if (p.x < b && p.y >= height - b)
                // 左下角
                return Qt.SizeBDiagCursor
            if (p.x < b || p.x >= width - b)
                // 左侧、右侧
                return Qt.SizeHorCursor
            if (p.y < b || p.y >= height - b)
                // 上侧、下侧
                return Qt.SizeVerCursor
        }
        acceptedButtons: Qt.NoButton
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
                             } else if (p.x < b && p.y >= window.height - b) {
                                 e |= Qt.LeftEdge
                                 e |= Qt.BottomEdge
                                 window.startSystemResize(e)
                             } else if (p.x >= window.width - b && p.y < b) {
                                 e |= Qt.RightEdge
                                 e |= Qt.TopEdge
                                 window.startSystemResize(e)
                             } else if (p.x >= window.width - b
                                        && p.y >= window.height - b) {
                                 e |= Qt.RightEdge
                                 e |= Qt.BottomEdge
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
                             } else if (p.y >= window.height - b) {
                                 e |= Qt.BottomEdge
                                 window.startSystemResize(e)
                             }
                         }
    }

    // 标题栏
    Rectangle {
        id: topTitleBar
        width: parent.width
        height: topTitleBarHeight
        anchors.left: parent.left
        anchors.top: parent.top

        Utils.FramelessTitleBar {
            id: framelessTitleBar
            backgroundColor: "#121212"
            anchors.left: parent.left
            anchors.top: parent.top
            resizable: true
        }

        // 标题栏右侧按钮
        Row {
            anchors.top: topTitleBar.top
            anchors.right: topTitleBar.right
            anchors.topMargin: 2
            anchors.rightMargin: 2
            layoutDirection: Qt.RightToLeft
            spacing: 0

            // 关闭按钮
            Rectangle {
                id: closeButton
                width: buttonSize
                height: buttonSize
                color: closeHoverHandler.hovered ? "#ae1c1c" : "transparent"

                HoverHandler {
                    id: closeHoverHandler
                }

                Image {
                    anchors.centerIn: parent
                    width: topTitleBarHeight / 2
                    height: topTitleBarHeight / 2
                    source: "qrc:/images/close.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        closeHardCut()
                    }
                }
            }

            // 最大化按钮
            Rectangle {
                id: maximizeButton
                width: buttonSize
                height: buttonSize
                color: maximizeHoverHandler.hovered ? "#202023" : "transparent"

                HoverHandler {
                    id: maximizeHoverHandler
                }

                Image {
                    anchors.centerIn: parent
                    width: topTitleBarHeight / 2
                    height: topTitleBarHeight / 2
                    source: "qrc:/images/maximize.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (window.visibility === Window.Maximized
                                || (window.width === Screen.desktopAvailableWidth
                                    && window.height === Screen.desktopAvailableHeight)) {
                            window.showNormal()
                            window.width = internal.lastWidth
                            window.height = internal.lastHeight
                            window.x = Screen.width / 2 - window.width / 2
                            window.y = Screen.height / 2 - window.height / 2
                        } else {
                            window.showMaximized()
                            window.x = 0
                            window.y = 0
                            window.width = Screen.desktopAvailableWidth
                            window.height = Screen.desktopAvailableHeight
                        }
                    }
                }
            }

            // 最小化按钮
            Rectangle {
                id: minimizeButton
                width: buttonSize
                height: buttonSize
                color: minimizeHoverHandler.hovered ? "#202023" : "transparent"

                HoverHandler {
                    id: minimizeHoverHandler
                }

                Image {
                    anchors.centerIn: parent
                    width: topTitleBarHeight / 2
                    height: topTitleBarHeight / 2
                    source: "qrc:/images/minimize.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        internal.lastVisibility = window.visibility
                        window.showMinimized()
                    }
                }
            }

            // 分隔图标
            Rectangle {
                id: separateImage
                width: buttonSize
                height: buttonSize
                color: "transparent"

                Image {
                    anchors.centerIn: parent
                    width: topTitleBarHeight / 2
                    height: topTitleBarHeight / 2
                    source: "qrc:/images/separate.png"
                }
            }
        }
    }

    // 记录普通窗口的长、宽等状态
    Connections {
        ignoreUnknownSignals: true
        target: window
        function onWidthChanged(newWidth) {
            if (newWidth !== Screen.desktopAvailableWidth) {
                internal.lastWidth = newWidth
            }
        }
        function onHeightChanged(newHeight) {
            if (newHeight !== Screen.desktopAvailableHeight) {
                internal.lastHeight = newHeight
            }
        }
        function onWindowStateChanged(newState) {
            if (newState === Qt.WindowNoState
                    && window.visibility === Window.Minimized
                    && internal.lastVisibility === Window.Maximized) {
                window.showMaximized()
            }
        }
    }

    // 双击标题栏 切换最大化窗口和普通窗口
    Connections {
        ignoreUnknownSignals: true
        target: framelessTitleBar
        function onToggleMaximized() {
            if (window.visibility === Window.Maximized
                    || (window.width === Screen.desktopAvailableWidth
                        && window.height === Screen.desktopAvailableHeight)) {
                window.showNormal()
                window.width = internal.lastWidth
                window.height = internal.lastHeight
                window.x = Screen.width / 2 - window.width / 2
                window.y = Screen.height / 2 - window.height / 2
            } else {
                window.showMaximized()
                window.x = 0
                window.y = 0
                window.width = Screen.desktopAvailableWidth
                window.height = Screen.desktopAvailableHeight
            }
        }
    }

    Component.onCompleted: {
        window.width = Screen.desktopAvailableWidth
        window.height = Screen.desktopAvailableHeight
        window.x = 0
        window.y = 0
        window.showMaximized()
    }
}
