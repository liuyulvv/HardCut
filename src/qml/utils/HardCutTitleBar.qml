import QtQuick

Rectangle {
    property int buttonSize: 26
    property int topTitleBarHeight: 30
    property int lastVisibility: 0
    property int lastWidth: 1536
    property int lastHeight: 873

    color: "transparent"

    id: topTitleBar
    width: parent.width
    height: topTitleBarHeight
    anchors.left: parent.left
    anchors.top: parent.top

    // 双击标题栏 切换最大化窗口和普通窗口
    Connections {
        ignoreUnknownSignals: true
        target: framelessTitleBar
        function onToggleMaximized() {
            if (window.visibility === Window.Maximized
                    || (window.width === Screen.desktopAvailableWidth
                        && window.height === Screen.desktopAvailableHeight)) {
                window.showNormal()
                window.width = lastWidth
                window.height = lastHeight
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

    FramelessTitleBar {
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
                        window.width = lastWidth
                        window.height = lastHeight
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
                    lastVisibility = window.visibility
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

    // 记录普通窗口的长、宽等状态
    Connections {
        ignoreUnknownSignals: true
        target: window
        function onWidthChanged(newWidth) {
            if (newWidth !== Screen.desktopAvailableWidth) {
                lastWidth = newWidth
            }
        }
        function onHeightChanged(newHeight) {
            if (newHeight !== Screen.desktopAvailableHeight) {
                lastHeight = newHeight
            }
        }
        function onWindowStateChanged(newState) {
            if (newState === Qt.WindowNoState
                    && window.visibility === Window.Minimized
                    && lastVisibility === Window.Maximized) {
                window.showMaximized()
            }
        }
    }
}
