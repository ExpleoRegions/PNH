import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtMultimedia

Rectangle {
    anchors.fill: parent
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    Image {

        id: animation
        width: Screen.desktopAvailableWidth
        height: Screen.desktopAvailableHeight
        fillMode: Image.Stretch
        source: "file:" + "./PNH_Test/img/tropical_forest.jpg"
        anchors.fill: parent

        SoundEffect {
            id: playSound
            source: "file:" + "./PNH_Test/sound/JUNGLE_Sound.wav"

        }

        MouseArea {
            anchors.fill: parent
            Component.onCompleted: playSound.play()

            onPressed: {
                //loaderId.source = "file:" + "./PNH_Test/Systeme1_Test5.qml"
                testSoftware.testEnd()
            }
        }
    }
}

