import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml
import QtMultimedia


Rectangle {

    width: Screen.desktopAvailableWidth ; height: Screen.desktopAvailableHeight
    id: root
    anchors.fill: parent
    color: "black"
    property int nbTest: 1
    property int reward: 0
    property double startTime: 0
    property string endTime
    property double latencyStartTime: 0
    property string latencyEndTime
    property bool response: false // the monkey is allowed to click
    property bool replay: false
    property int nb_ok: 0
    property int nb_fail: 0
    property int timer_interval: 1000
    property int nb_test:1
    property int nb_circle:0
    property int random_prev: 0
    property string sound:""
    property string pic:""
    property int timing_pic: 0

    SoundEffect {
        id: playSound
        source: sound
    }
    Repeater {
        id: rep
        anchors.fill: parent
        model: [1, 2, 3, 4, 5]
        delegate: Item {
            x: 900
            height: Screen.desktopAvailableHeight/2.5
            anchors.bottom: parent.verticalCenter
            anchors.left: parent.horizontalCenter
            transformOrigin: Item.BottomLeft
            rotation: 360 / rep.model.length * index
            property string currentColor: "white"
            property bool illuminated:false

            //            Text {
            //                text: modelData
            //                anchors.horizontalCenter: parent.horizontalCenter
            //                rotation: -parent.rotation // If you want to have them upright
            //            }

            Rectangle  {
                id: circle
                width: Screen.desktopAvailableHeight/5//testInfo.getValue("circle_size")
                height: width
                //color: modelData != 4? "white":"blue"
                color : parent.currentColor
                border.color: parent.currentColor
                border.width: 5
                radius: width/2
                property bool illuminated: parent.illuminated

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        //playSound.play()
                        //loaderId.source = "file:" + "./PNH_Test/test4a.qml"
                        //index.row()

                        //console.log("entré  ",root.nb_circle, root.nb_test)

                        if(root.nb_circle<root.nb_test)
                        {
                            //console.log("for circle  ",root.nb_circle, root.nb_test)

                            if (root.response && nb_fail<3)
                            {
                                //console.log("if circle  ",circle.illuminated)

                                switch(circle.illuminated)
                                {
                                    case true:
                                    {
//                                        for(var i=0; i<5; i++)
//                                        {rep.itemAt(i).visible = false }
//                                        animation.visible=true
//                                        root.pic="file:" + "./PNH_Test/img/SMILE.png"
//                                        root.sound= "file:" + "./PNH_Test/sound/Right_Answer.wav"
//                                        root.color="#4caf50"
//                                        playSound.play()
//                                        timer_pic.start()
                                        //root.nb_ok++;
                                        reward++
                                        //testSoftware.giveReward();
                                        console.log("true ***************")
                                        break;
                                    }

                                    case false:
                                    {
                                        root.nb_fail++;
                                        break;
                                    }
                                }
                                //root.nb_circle++;
                                //console.log("root.nb_circle",root.nb_circle)

                                //console.log("sortie",circle.illuminated)

                                root.visible=true
                            }

                            //after 3 correct response timer is set to 500 ms
                            root.nb_circle++;
                            console.log("root.nb_circle<root.nb_test",root.nb_ok, root.nb_test)
                        }

                        if(root.nb_circle==root.nb_test)
                        {
                            console.log("root.nb_circle==root.nb_test  && nb_fail<3****",reward, root.nb_test)
                            root.nb_circle=0
                            if(reward==root.nb_test)
                            {
                                reward=0
                                root.nb_ok++;
                                for(var i=0; i<5; i++)
                                {rep.itemAt(i).visible = false }
                                animation.visible=true
                                timing_pic=2000
                                root.pic="file:" + "./PNH_Test/img/SMILE.png"
                                root.sound= "file:" + "./PNH_Test/sound/Right_Answer.wav"
                                root.color="#4caf50"
                                playSound.play()
                                timer_pic.start()
                                testSoftware.giveReward();
                                console.log("gagner***************")
                            }
                            else{

                                reward=0
                                for(var i=0; i<5; i++)
                                {rep.itemAt(i).visible = false }
                                timing_pic=5000
                                root.pic="file:" + "./PNH_Test/img/sad.png"
                                animation.visible=true
                                root.sound= "file:" + "./PNH_Test/sound/Wrong_Answer.wav"
                                root.color="#f44336"
                                playSound.play()
                                timer_pic.start()

                                console.log("perdu*****************")
                            }

//                            reset()
//                            timer1.restart()

                            //console.log("equal",root.nb_circle, root.nb_test)

                            if (root.nb_ok >= 3 && 15 > root.nb_ok)
                            {
                                console.log("root.nb_ok >= 3 && 26 > root.nb_ok****",root.nb_ok, root.nb_test)
                                //timer1.restart()

                                timer_interval=500
                                //console.log(root.nb_ok)
                                //root.response = false;
                                if(root.nb_ok==6)
                                {
                                    root.nb_test=2
                                }
                                if(root.nb_ok==9)
                                {
                                    root.nb_test=3
                                }
                                if(root.nb_ok==12)
                                {
                                    root.nb_test=5
                                }
                            }
                        }
                    }
                }

                anchors.horizontalCenter: parent.horizontalCenter
                rotation: -parent.rotation // If you want to have them upright
            }
        }
    }

    Timer  {
        id: timer1
        interval: 1000//testInfo.getValue("timer1"); // 1000
        running: true;
        //repeat: true;
        onTriggered: time1()
    }
    function reset()  {

            for(var i=0; i<5; i++)
            {
            rep.itemAt(i).illuminated = false;
            root.replay=false
            }

    }

    function time1()  {
        let random5 = [0,0, 0, 0, 0]
        var x=0, tmp=0;

        /* Initialise le tableau */
        for ( var i=0 ; i<5 ; i++ )
        {
            random5[i] = i;
        }

        /* Generation aleatoire */
        //srand(time(NULL));
        for ( var i=0 ; i<5 ; i++ )
        {
            x = i + Math.floor(Math.random() * (5-i));

            /* On permute les valeurs du tableau */
            tmp = random5[i];
            random5[i] = random5[x];
            random5[x] = tmp;
        }

        for(var i=0; i<root.nb_test; i++)
        {
            //console.log("random5 =========================================================== " + random5[i]);


        switch(random5[i]){
            case 0:{
                rep.itemAt(0).currentColor = "blue"
                rep.itemAt(0).illuminated = true;
                break ;
            }
            case 1:{
                rep.itemAt(1).currentColor = "red"
                rep.itemAt(1).illuminated = true;
                break ;
            }
            case 2:{
                rep.itemAt(2).currentColor = "green"
                rep.itemAt(2).illuminated = true;
                break ;
            }
            case 3:{
                rep.itemAt(3).currentColor = "cyan"
                rep.itemAt(3).illuminated = true;
                break ;
            }
            case 4:{
                rep.itemAt(4).currentColor = "magenta"
                rep.itemAt(4).illuminated = true;
                break ;
            }
        }

        //console.log("for time",rep.itemAt(random5[j]).illuminated)
        }
        root.sound="file:" + "./PNH_Test/sound/Display_circle.wav"
        playSound.play()
        //console.log("fonct",rep.itemAt(random5).illuminated)
        timer2.start()
    }

    Timer  {
        id: timer2
        interval: timer_interval; // 1000
        running: false;
        //repeat: true;
        onTriggered: time2()
    }

    function time2()  {
        for(var i=0; i<5; i++)
            rep.itemAt(i).currentColor = "white"
        root.response = true;
        //console.log("root.response = true;");
        latencyStartTime = new Date().getTime()
    }

    Component.onCompleted: {
        //testSoftware.testEnd()//****************************************
        startTime = new Date().getTime()
        //timer1.start()
    }
    Image {
        id: animation
        autoTransform :true
        fillMode: Image.Pad
        source: pic
        width: Screen.desktopAvailableWidth/4; height: Screen.desktopAvailableHeight/4
        anchors.fill: parent
        visible: false
    }
    Timer  {
        id: timer_pic
        interval: timing_pic
        running: false
        repeat : false
        onTriggered: {
            reset()
            timer1.restart()

            //console.log("trigger")
            animation.visible=false
            root.color="black"
            playSound.stop()

            for(var i=0; i<5; i++)
               { rep.itemAt(i).visible = true}

            if (nb_fail==3 || nb_ok>=15)//ou il a fini tout les tests juste
            {
                root.endTime = new Date().getTime() - root.startTime
                testInfo.setValue("nb_ok", root.nb_ok)
                testInfo.setValue("nb_fail", root.nb_fail)
                testInfo.setValue("test_time", root.endTime)
                root.latencyEndTime = new Date().getTime() - root.latencyStartTime
                testInfo.setValue("latency" + root.nbTest, root.latencyEndTime)
                testSoftware.testEnd()
            }
       }
    }
}

