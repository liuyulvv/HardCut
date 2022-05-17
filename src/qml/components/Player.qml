import QtQuick
import QtMultimedia

Rectangle {
    id: preview
    width: parent.width - 2
    height: parent.height - 32
    color: "transparent"

    MediaPlayer {
        id: mediaplayer
        source: "D:/Code/HardCut/TBBT.mkv"
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: preview
    }

    MouseArea {
        anchors.fill: preview
        onPressed: mediaplayer.play()
    }
}
