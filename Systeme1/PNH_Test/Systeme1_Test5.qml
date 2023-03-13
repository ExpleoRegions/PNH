import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml
import QtMultimedia

Rectangle {
    id: root
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    anchors.fill: parent
    color: "white"
    property double startTime: 0
    property string endTime
    property double latencyStartTime: 0
    property string latencyEndTime
    property int nb_fail: 0
    property int nb_ok: 0
    property bool visu:true
    property string current:""
    property int indice:99
    property int nb_test:1
    property int reward:0
    property int nb_click:0
    property var random5:[]
    property var random6:[]
    property string sound:""
    property string pic:""
    property int timing_pic: 0


    SoundEffect {
        id: playSound
        source: sound
    }
    Image {
        id: animation
        autoTransform :true
        fillMode: Image.Pad
        source: pic
        width: Screen.desktopAvailableWidth/4; height: Screen.desktopAvailableHeight/4
        anchors.fill: parent
        visible: false
        z:1
    }
    Timer  {
        id: timer_pic
        interval: timing_pic
        running: false
        repeat : false
        onTriggered: {
            init()
            //console.log("trigger")
            animation.visible=false
            root.color="white"
            playSound.stop()
            for(var i=0; i<6; i++)
            {
                rep1.itemAt(i).visible = true
                rep2.itemAt(i).visible = true
            }
       }
    }
    GridLayout {
        id: grid
        //property alias rep: rep1
        anchors.left: root.left
        anchors.leftMargin: 50
        anchors.verticalCenter: root.verticalCenter
        columns: 2

        Repeater {
            id: rep1
            model: 6

            delegate:

                Rectangle {
                    id: img
                    parent: grid
                    property alias imag1: image1
                    property int illuminated:99
                    width: 280
                    height:280
                    visible: true
                    border.color: "blue"
                    property alias animation_color_alias: animation_color

                    PropertyAnimation {
                        id: animation_color
                        target: img
                        properties: "color"
                        duration: 1500
                        loops: Animation.Infinite
                        }

                    Image {
                        id: image1
                        visible: false
                        width: 250; height: 250
                        source: ""
                        anchors.centerIn: img
                        property int illuminated: img.illuminated
                    }

                    MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                if(nb_click<nb_test){

                                    if(rep1.itemAt(model.modelData).illuminated == current && rep2.itemAt(indice).imag2.visible==true)
                                    {
                                        if(nb_test<2)
                                        {
                                            rep1.itemAt(model.modelData).animation_color_alias.running =false
                                            rep1.itemAt(model.modelData).color="transparent"
                                        }
                                        visu=true
                                        rep2.itemAt(indice).imag2.visible=false
                                        reward++;
                                        console.log("gagner1***************", rep1.itemAt(model.modelData).illuminated, current, rep2.itemAt(indice).imag2.visible)
                                    }
                                    else{
                                        if(rep1.itemAt(model.modelData).illuminated != current)
                                        {
                                            nb_fail++;
                                            console.log("perdu1*****************", rep1.itemAt(model.modelData).illuminated, current, rep2.itemAt(indice).imag2.visible)}
                                        }
                                        nb_click++
                                    }

                                if(root.nb_click==nb_test  && nb_fail<3)
                                {
                                    //console.log("root.nb_circle==root.nb_test  && nb_fail<3****",reward, root.nb_test)
                                    nb_click=0
                                    if(reward==nb_test)
                                    {
                                        nb_ok++;
                                        for(var i=0; i<6; i++)
                                        {
                                            rep1.itemAt(i).visible = false
                                            rep2.itemAt(i).visible = false
                                        }
                                        timing_pic=5000
                                        animation.visible=true
                                        root.pic="file:" + "./PNH_Test/img/SMILE.png"
                                        root.sound= "file:" + "./PNH_Test/sound/Right_Answer.wav"
                                        root.color="#4caf50"
                                        playSound.play()
                                        timer_pic.start()
                                        testSoftware.giveReward();
                                        console.log("gagner2***************", nb_click)
                                    }
                                    else{

                                        //reward=0
                                        for(var i=0; i<6; i++)
                                        {
                                            rep1.itemAt(i).visible = false
                                            rep2.itemAt(i).visible = false
                                        }
                                        for(var i=0; i<6; i++)
                                        {
                                            rep1.itemAt(i).imag1.visible = false
                                            rep2.itemAt(i).imag2.visible = false
                                        }
                                        timing_pic=2000
                                        root.pic="file:" + "./PNH_Test/img/sad.png"
                                        animation.visible=true
                                        root.sound= "file:" + "./PNH_Test/sound/Wrong_Answer.wav"
                                        root.color="#f44336"
                                        playSound.play()
                                        timer_pic.start()

                                        console.log("perdu 2*****************")
                                    }
                                    reward=0

        //                            reset()
        //                            timer1.restart()


                                    if (root.nb_ok >= 2 && 15 > root.nb_ok)
                                    {
                                        console.log("root.nb_ok >= 3 && 26 > root.nb_ok****",root.nb_ok, root.nb_test)
                                        //timer1.restart()

                                        //console.log(root.nb_ok)
                                        //root.response = false;
                                        if(nb_ok==2)
                                        {
                                            nb_test=2
                                        }
                                        if(nb_ok==4)
                                        {
                                            nb_test=4
                                        }
                                        if(nb_ok==6)
                                        {
                                            nb_test=6
                                        }
                                    }
                                    if(15===nb_ok)
                                    {
                                        testSoftware.testEnd()
                                    }
                                }

                                if (nb_fail==3)//ou il a fini tout les tests juste
                                {
                                    root.endTime = new Date().getTime() - root.startTime
                                    //testInfo.setValue("nb_ok", nb_ok)
                                    //testInfo.setValue("nb_fail", nb_fail)
                                    //testInfo.setValue("test_time", root.endTime)
                                    //root.latencyEndTime = new Date().getTime() - root.latencyStartTime
                                    //testInfo.setValue("latency" + nbTest, root.latencyEndTime)
                                    testSoftware.testEnd()
                                }

                            }
                        }
                }
        }
    }
    GridLayout {
        id: grid2
        columns: 2
        anchors.right: root.right
        anchors.rightMargin: 50
        anchors.verticalCenter: root.verticalCenter

        // Column headers are direct children of the GridLayout

        Repeater {
            id: rep2
            model: 6

            delegate:

                Rectangle {
                    id: img2
                    parent: grid2
                    property alias imag2: image2
                    property alias animation_color_alias2: animation_color2
                    property int illuminated:99
                    width: 280
                    height:280
                    color: "transparent"
                    radius: 20
                    Image {
                        id: image2
                        visible: false
                        width: 250; height: 250
                        source: ""
                        anchors.centerIn: img2

                        property int illuminated: img2.illuminated
                        PropertyAnimation {
                            id: animation_color2
                            target: img2
                            properties: "color"
                            duration: 1500
                            loops: Animation.Infinite
                            }
                        }
                        //ColorAnimation on color { duration: 1000; from: "red"; to: "transparent"; loops: Animation.Infinite }
                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                if(nb_test<2)
                                {
                                rep1.itemAt(model.modelData).animation_color_alias.to= "blue"
                                rep2.itemAt(model.modelData).animation_color_alias2.running =false
                                rep2.itemAt(model.modelData).color="transparent"

                                rep1.itemAt(model.modelData).animation_color_alias.running =true

                                }
                                if(visu==true){
                                    current=rep2.itemAt(model.modelData).illuminated
                                    console.log(" ***************", rep1.itemAt(model.modelData).animation_color_alias.to)

                                    indice=model.modelData
                                    timer2.start()
                                    //console.log("00 ***************", visu)
                                }
                            }
                        }

                    }

        }
    }
    Timer  {
        id: timer1
        interval: 3000//testInfo.getValue("timer1")
        running: false;
        //repeat: true;
        onTriggered: {time1()}
    }
    Timer  {
        id: timer2
        interval: 200//testInfo.getValue("timer1")
        running: false;
        //repeat: true;
        onTriggered: {time2()}
    }
    Timer  {
        id: timer3
        interval: 3000//testInfo.getValue("timer1")
        running: false;
        //repeat: true;
        onTriggered: {
            for(var i=0; i<nb_test; i++){
                rep1.itemAt(i).imag1.visible = false
            }
            timer1.start()}
    }
    function time2() {
        visu=false
        //console.log("55 ***************", visu)
    }
    function init() {

        var x=0, tmp=0;

        for ( var i=1 ; i<7 ; i++ )
        {
            random5[i-1] = i;

        }

        /* Generation aleatoire */

        for ( var i=1 ; i<7 ; i++ )
        {
            x = i-1 + Math.floor(Math.random() * (6-(i-1)));

            /* On permute les valeurs du tableau */
            tmp = random5[i-1];
            random5[i-1] = random5[x];
            random5[x] = tmp;
        }
        var k=0

        for(var i=0; i<nb_test; i++){
            rep1.itemAt(i).imag1.source = "file:" + "./PNH_Test/img/RP"+ random5[k] + ".png"
            rep1.itemAt(i).illuminated=random5[k]
            console.log("55 ***************", random5[k])
            k++
        }
        k=0
        for(var i=0; i<nb_test; i++){
            rep1.itemAt(i).imag1.visible = true
        }

        timer3.start()

    }

    Component.onCompleted: {
        init()
    }

    function time1() {

        var x=0, tmp=0;

        for ( var i=0 ; i<nb_test ; i++ )
        {
            random6[i] = i;

        }

        /* Generation aleatoire */
        //srand(time(NULL));
        for ( var i=0 ; i<nb_test ; i++ )
        {
            x = i-1 + Math.floor(Math.random() * (nb_test-i));

            /* On permute les valeurs du tableau */
            tmp = random6[i];
            random6[i] = random6[x];
            random6[x] = tmp;
        }
        var k=0

        for(var i=0; i<nb_test; i++){
            rep2.itemAt(random6[i]).imag2.source = "file:" + "./PNH_Test/img/RP"+ random5[k] + ".png"
            rep2.itemAt(random6[i]).illuminated=random5[k]
            console.log("44 ***************", random5[k])
            k++
        }
        if(nb_test<2)
        {
            for(var i=0; i<nb_test; i++){
                rep2.itemAt(random6[i]).animation_color_alias2.to= "blue"
                rep2.itemAt(random6[i]).animation_color_alias2.running = true;
            }
        }

        k=0
        for(var i=0; i<nb_test; i++){
            rep2.itemAt(random6[i]).imag2.visible = true
        }

    }

    }
