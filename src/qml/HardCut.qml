import QtQuick
import "qrc:/src/qml/utils/"

Rectangle {
    property int rectangleRadius: 15
    property int leftBarWidth: 213
    property int topTitleBarHeight: 30
    signal closeHardCut

    anchors.fill: parent
    color: "#1b1b1c"

    // 标题栏
    Rectangle {
        id: topTitleBar
        width: parent.width
        height: topTitleBarHeight
        anchors.left: parent.left
        anchors.top: parent.top

        FramelessTitleBar {
            backgroundColor: "#121212"
            anchors.left: parent.left
            anchors.top: parent.top
        }

        // 标题栏右侧按钮
        Row {
            anchors.top: topTitleBar.top
            anchors.right: topTitleBar.right
            layoutDirection: Qt.RightToLeft
            spacing: 0

            // 关闭按钮
            Rectangle {
                id: closeButton
                width: topTitleBarHeight
                height: topTitleBarHeight
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
                width: topTitleBarHeight
                height: topTitleBarHeight
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

                        //                        window.visibility = Window.Minimized
                    }
                }
            }

            // 最小化按钮
            Rectangle {
                id: minimizeButton
                width: topTitleBarHeight
                height: topTitleBarHeight
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
                        window.visibility = Window.Minimized
                    }
                }
            }

            // 分隔
            Rectangle {
                id: separateImage
                width: topTitleBarHeight
                height: topTitleBarHeight
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

    Component.onCompleted: {
        window.x = 0
        window.y = 0
        window.width = Screen.desktopAvailableWidth
        window.height = Screen.desktopAvailableHeight
        window.visibility = Window.Maximized
    }
}
