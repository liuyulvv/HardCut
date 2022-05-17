import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "./utils/" as Utils
import "./components/" as Components

Rectangle {
    signal closeHardCut

    anchors.fill: parent
    color: "#121212"

    Component.onCompleted: {
        window.minimumWidth = 1136
        window.minimumHeight = 492
        window.width = Screen.desktopAvailableWidth
        window.height = Screen.desktopAvailableHeight
        window.x = 0
        window.y = 0
        window.showMaximized()
    }

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
    Utils.HardCutTitleBar {
        id: titleBar
    }

    property int splitMargin: 8

    // 内容区域
    SplitView {
        id: splitView
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        orientation: Qt.Vertical

        anchors.leftMargin: splitMargin
        anchors.rightMargin: splitMargin
        anchors.bottomMargin: splitMargin

        handle: Rectangle {
            implicitWidth: splitMargin
            implicitHeight: splitMargin
            color: "transparent"
        }

        // 操作区域
        Rectangle {
            SplitView.minimumHeight: 241
            SplitView.maximumHeight: 788
            SplitView.preferredHeight: 495

            color: "transparent"
            SplitView {
                anchors.fill: parent

                handle: Rectangle {
                    implicitWidth: splitMargin
                    implicitHeight: splitMargin
                    color: "#121212"
                }

                Rectangle {
                    color: "#1b1b1c"
                    SplitView.minimumWidth: 450
                    SplitView.maximumWidth: 1173
                    SplitView.preferredWidth: 746

                    SplitView.fillHeight: true

                    Components.OperationArea {}
                }

                // 播放器
                Rectangle {
                    color: "#1b1b1c"
                    SplitView.minimumWidth: 339
                    SplitView.maximumWidth: 1120
                    SplitView.preferredWidth: 762

                    SplitView.fillHeight: true
                    Components.Player {}
                }

                // 草稿参数
                Rectangle {
                    color: "#1b1b1c"
                    SplitView.minimumWidth: 318
                    SplitView.fillHeight: true
                    SplitView.fillWidth: true
                }
            }
        }

        // 轨道区域
        Rectangle {
            SplitView.minimumHeight: 202
            SplitView.fillWidth: true
            SplitView.fillHeight: true
            color: "#1b1b1c"
        }
    }
}
