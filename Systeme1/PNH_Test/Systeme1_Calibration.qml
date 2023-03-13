import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtMultimedia

Rectangle {
    id: root
    color: testInfo.getValue("color_back")
    anchors.fill: parent
    property int count: 1
    property double startTime: 0
    property string endTime
    property int timing_pic: 0

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
            animation.source= "file:" + "./PNH_Test/img/sad.png"
            playSound.source= "file:" + "./PNH_Test/sound/Wrong_Answer.wav"
            playSound.play()
            animation.visible=true
            square.visible = false
            timing_pic=2000
            timer1.start()
            root.color="#f44336"
        }
    }

    SoundEffect {
        id: playSound
        source: ""
    }
    Rectangle {
        x: 100
        y: 100
        id : square
        radius: 20
        color: testInfo.getValue("color_object")
        //anchors.centerIn: parent
        width: testInfo.getValue("square_size_start")
        height: width

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: {
                //console.log("click!")
                testInfo.setValue("reward_every_time", "true")
                if (count <= testInfo.getValue("nb_click"))
                {

                    if (testInfo.getValue("reward_every_time") === "true")
                    {
                        //console.log("if")
                        playSound.source= "file:" + "./PNH_Test/sound/Right_Answer.wav"
                        animation.source= "file:" + "./PNH_Test/img/SMILE.png"
                        playSound.play()
                        animation.visible=true
                        square.visible = false
                        timing_pic=5000
                        timer1.start()
                        root.color="#4caf50"

                        testSoftware.giveReward()
                    }
                }

                else
                {

                    endTime = new Date().getTime() - startTime
                    testInfo.setValue("test_time", endTime)
                    //testSoftware.saveResults() //todo reactiver
                    testInfo.setValue("reward_every_time", "false")
                }
                count++
            }
            onReleased: {
            testInfo.setValue("reward_every_time", "false")
            }
        }
    }
    Image {
        id: animation
        autoTransform :true
        //paintedWidth: 50 ; paintedHeight: 50
        //mirrorVertically: true
        fillMode: Image.Pad
        source: "file:" + "./PNH_Test/img/SMILE.png"
        width: 100 ; height: 100
        anchors.fill: parent
        visible: false
    }
    Timer  {
        id: timer1
        interval: timing_pic
        running: false
        repeat : false
        onTriggered: {
            //console.log("trigger")
            animation.visible=false
            square.visible=true
            playSound.stop()
            if (count <= testInfo.getValue("nb_click"))
            {moveSquare();
            }
            else
            {
                testSoftware.testEnd()
            }

            root.color="black"
       }
    }
    function moveSquare() {
        var posx = Math.random() * (root.width - square.width)
        var posy = Math.random() * (root.height - square.height)
        square.x = posx
        square.y = posy
        square.width = testInfo.getValue("square_size_factor")/100 * square.width
        square.height = square.width
        square.visible = true
    }

    Component.onCompleted: {
        //testSoftware.testEnd()//***********************************************
        startTime = new Date().getTime()
    }
}
