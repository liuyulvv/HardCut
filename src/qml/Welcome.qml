import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    property int rectangleRadius: 15
    property int leftBarWidth: 213
    property int topTitleBarHeight: 30

    id: mask
    anchors.fill: parent
    radius: rectangleRadius

    Component.onCompleted: {
        parent.width = 850
        parent.height = 564
    }

    Rectangle {
        anchors.fill: mask
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }

        // 标题栏
        Rectangle {
            id: topTitleBar
            height: topTitleBarHeight
            anchors.left: parent.left
            anchors.top: parent.top

            // 左标题栏
            FramelessTitleBar {
                id: leftTitleBar
                backgroundColor: "#1b1b1c"
                barWidth: leftBarWidth
                anchors.left: parent.left
                anchors.top: parent.top
            }

            // 右标题栏
            FramelessTitleBar {
                id: rightTitleBar
                backgroundColor: "#121212"
                barWidth: mask.width - leftBarWidth
                anchors.left: leftTitleBar.right
                anchors.top: parent.top
            }

            // 右标题栏按钮
            Row {
                anchors.top: rightTitleBar.top
                anchors.right: rightTitleBar.right
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
                        source: "/HardCut/images/close.png"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Qt.quit()
                        }
                    }
                }

                // 最小化按钮
                Rectangle {
                    id: minimizeButton
                    width: topTitleBarHeight
                    height: topTitleBarHeight
                    color: minimizeHoverHandler.hovered ? "#1b1b1c" : "transparent"

                    HoverHandler {
                        id: minimizeHoverHandler
                    }

                    Image {
                        anchors.centerIn: parent
                        width: topTitleBarHeight / 2
                        height: topTitleBarHeight / 2
                        source: "/HardCut/images/minimize.png"
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
                        source: "/HardCut/images/separate.png"
                    }
                }

                // 设置按钮
                Rectangle {
                    id: settingButton
                    width: topTitleBarHeight
                    height: topTitleBarHeight
                    color: settingHoverHandler.hovered ? "#1b1b1c" : "transparent"

                    HoverHandler {
                        id: settingHoverHandler
                    }

                    Image {
                        anchors.centerIn: parent
                        width: topTitleBarHeight / 2
                        height: topTitleBarHeight / 2
                        source: "/HardCut/images/setting.png"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("clicked setting")
                        }
                    }
                }
            }
        }

        // 欢迎页面主要内容
        Rectangle {
            anchors.top: topTitleBar.bottom
            anchors.left: parent.left
            width: parent.width
            height: parent.height - topTitleBarHeight

            // 欢迎页面左侧主要内容
            Rectangle {
                id: leftWelcome
                anchors.top: parent.top
                anchors.left: parent.left
                width: leftBarWidth
                height: parent.height
                color: "#1b1b1c"
            }

            // 欢迎页面右侧主要内容
            Rectangle {
                id: rightWelcome
                anchors.top: parent.top
                anchors.left: leftWelcome.right
                width: parent.width - leftBarWidth
                height: parent.height
                color: "#121212"

                // 欢迎页面开始制作
                Rectangle {
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 588
                    height: 110
                    radius: rectangleRadius
                    color: startHoverHandler.hovered ? "#2e2e2e" : "#252525"

                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        anchors.centerIn: parent

                        Row {
                            anchors.centerIn: parent
                            spacing: 8

                            Rectangle {
                                width: 20
                                height: 20
                                radius: 10
                                color: "#00c1cd"

                                Text {
                                    text: qsTr("+")
                                    font.pointSize: 12
                                    anchors.centerIn: parent
                                    color: "white"
                                }
                            }

                            Text {
                                text: qsTr("开始制作")
                                font.pointSize: 10
                                color: "white"
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("clicked")
                        }
                    }

                    HoverHandler {
                        id: startHoverHandler
                    }
                }
            }
        }
    }
}
