import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    Connections {
        target: testSoftware
        function onChangeTestToQml(testUrl) {
            console.log(testUrl)
            loaderId.source = "file:" + testUrl
        }
    }
    //update width and height According to the size of the window
    width: Screen.desktopAvailableWidth ; height: Screen.desktopAvailableHeight
    //width: 640
    //height: 480
    visible: true
    title: qsTr("TestSoftwarePNH")
    //flags: Qt.FramelessWindowHint | Qt.Window
    visibility: "FullScreen"
    color: "black"


    Loader {
        id: loaderId
        anchors.fill: parent
        source: "file:" + "./PNH_Test/Foret_Tropical.qml"
    }


}
