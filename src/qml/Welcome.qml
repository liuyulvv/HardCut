import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "./utils/" as Utils

Rectangle {
    property int rectangleRadius: 15
    property int leftBarWidth: 213
    property int topTitleBarHeight: 30

    signal startWork

    id: mask
    anchors.fill: parent
    radius: rectangleRadius

    Component.onCompleted: {
        window.visibility = Window.Windowed
        window.width = 850
        window.height = 564
        window.x = Screen.width / 2 - window.width / 2
        window.y = Screen.height / 2 - window.height / 2
    }

    Rectangle {
        anchors.fill: mask
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }

        // 欢迎页面左侧
        Rectangle {
            id: leftWelcome
            width: leftBarWidth
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: "#1b1b1c"

            // 左标题栏
            Utils.FramelessTitleBar {
                id: leftTitleBar
                barHeight: topTitleBarHeight
                anchors.left: parent.left
                anchors.top: parent.top
            }

            // 欢迎页面左侧内容
            Rectangle {
                id: leftWelcomeContent
                anchors.top: leftTitleBar.bottom
                anchors.left: parent.left
                anchors.topMargin: topTitleBarHeight
                width: parent.width
                height: parent.height - leftTitleBar.height
                color: "transparent"
            }
        }

        // 欢迎页面右侧
        Rectangle {
            id: rightWelcome
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: leftWelcome.right
            color: "#121212"

            // 右标题栏
            Utils.FramelessTitleBar {
                id: rightTitleBar
                barHeight: topTitleBarHeight
                anchors.left: parent.left
                anchors.top: parent.top
            }

            // 欢迎页面右侧内容
            Rectangle {
                id: rightWelcomeContent
                anchors.top: rightTitleBar.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.topMargin: topTitleBarHeight
                color: "transparent"

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
                            startWork()
                        }
                    }

                    HoverHandler {
                        id: startHoverHandler
                    }
                }
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
                        source: "qrc:/images/close.png"
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
                        source: "qrc:/images/minimize.png"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            window.visibility = Window.Minimized
                        }
                    }
                }

                // 分隔图标
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
                        source: "qrc:/images/setting.png"
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
    }
}
