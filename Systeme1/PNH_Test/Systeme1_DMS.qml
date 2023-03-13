import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtMultimedia

Rectangle {
    id: root
    anchors.fill: parent
    color: testInfo.getValue("color_back")
    property int nb_test: 1
    property int nb_ok: 0
    property int nb_fail: 0
    property double startTime: 0
    property int timer_interval: 1000
    property string endTime
    property int goodValue
    property int rightImage
    property int currentImage
    property string sound:""
    property string pic:""
    property int wrongImage: 0
    property int timing_pic: 0
    property int index_val: 1
    property var random5:[]


    SoundEffect {
        id: playSound
        source: sound
    }

    Image  {
        id: image1
        width: Screen.desktopAvailableWidth/4; height: Screen.desktopAvailableHeight/4
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }


    Repeater {
        id: rep
        model: [1, 2, 3, 4]
        property bool show: false
        visible: show

        delegate: Item {
            x: 900
            height: Screen.desktopAvailableHeight/2.5
            anchors.bottom: parent.verticalCenter
            anchors.left: parent.horizontalCenter
            transformOrigin: Item.BottomLeft
            rotation: 360 / rep.model.length * index
            property string imageUrl: ""


            Image  {
                id: image2
                width: Screen.desktopAvailableWidth/4; height: Screen.desktopAvailableHeight/4
                fillMode: Image.PreserveAspectFit
                source: imageUrl
                visible: rep.show

                MouseArea {

                    anchors.fill: parent
                    onPressed: {

                        switch(root.rightImage)
                        {
                            case modelData:
                            {
                                for(var i=0; i<4; i++)
                                {rep.itemAt(i).visible = false }
                                animation.visible=true
                                timing_pic=5000
                                root.pic="file:" + "./PNH_Test/img/SMILE.png"
                                root.sound= "file:" + "./PNH_Test/sound/Right_Answer.wav"
                                root.color="#4caf50"
                                playSound.play()
                                timer_pic.start()
                                root.nb_ok++;
                                testSoftware.giveReward();
                                console.log("gagner***************")
                                break;
                            }

                            default:
                            {
                                for(var i=0; i<4; i++)
                                {rep.itemAt(i).visible = false }
                                timing_pic=2000
                                root.pic="file:" + "./PNH_Test/img/sad.png"
                                animation.visible=true
                                root.sound= "file:" + "./PNH_Test/sound/Wrong_Answer.wav"
                                root.color="#f44336"
                                playSound.play()
                                timer_pic.start()

                                console.log("perdu*****************")
                                root.nb_fail++;
                                break;
                            }
                        }

                        switch(root.nb_ok)
                        {
                            case 3:
                            {
                                timer_interval=2000
                                console.log("3<<<<<<<<<<<<<<<<<<<<<<<<")
                                break;
                            }

                            case 6:
                            {
                                timer_interval=3000
                                console.log("6<<<<<<<<<<<<<<<<<<<<<<<<<")
                                break;
                            }

                            case 9:
                            {
                                timer_interval=5000
                                console.log("9<<<<<<<<<<<<<<<<<<<<<<<<<")
                                break;
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
        interval: testInfo.getValue("timer1")
        running: false;
        //repeat: true;
        onTriggered: time1()
    }

    Timer  {
        id: timer2
        interval: timer_interval
        running: false;
        //repeat: true;
        onTriggered: time2()
    }

    function time1()  {
        image1.visible = false
        // choosing the one that will have the right image
        root.rightImage = Math.random() * 4 + 1
        root.rightImage = Math.ceil(root.rightImage)

        rep.itemAt(0).imageUrl = getimage(1);
        rep.itemAt(1).imageUrl = getimage(2);
        rep.itemAt(2).imageUrl = getimage(3);
        rep.itemAt(3).imageUrl = getimage(4);

        timer2.start()
    }

    function time2()  {
        rep.show = true;
    }

    Component.onCompleted: {
        //testSoftware.testEnd()//***********************************************
        root.startTime = new Date().getTime()
        init()
    }

    /*function init() {
        root.goodValue = Math.random() * 7 + 1
        root.goodValue = Math.ceil(root.goodValue)
        root.currentImage = 0;
        console.log("goodValue " + root.goodValue)
        image1.source = "file:" + "./PNH_Test/img/DMS"+ root.goodValue + ".png"
        image1.visible = true;
        rep.show = false;

        timer1.start()
    }*/
    function init() {

        //root.goodValue = Math.random() * 9 + 1
        var x=0, tmp=0;

        for ( var i=1 ; i<6 ; i++ )
        {
            random5[i-1] = i;

        }

        /* Generation aleatoire */
        //srand(time(NULL));
        for ( var i=1 ; i<6 ; i++ )
        {
            x = i-1 + Math.floor(Math.random() * (5-i-1));

            /* On permute les valeurs du tableau */
            tmp = random5[i-1];
            random5[i-1] = random5[x];
            random5[x] = tmp;
        }

        root.goodValue = random5[0]//Math.ceil(root.goodValue)
        console.log("goodValue " + root.goodValue)

        image1.source = "file:" + "./PNH_Test/img/DMS"+ root.goodValue + ".png"
        image1.visible = true;
        rep.show = false;

        timer1.start()

    }

    function getimage(modelIndex){

        if (modelIndex == root.rightImage)
            return  "file:" + "./PNH_Test/img/DMS"+ root.goodValue + ".png"
        else
        {
//            root.wrongImage = (root.goodValue + root.currentImage + Math.ceil(Math.random() * 2)) % 7
//            if (wrongImage == 0)
//                wrongImage = 1
//            console.log("wrongImage " + wrongImage)
//            root.currentImage = root.currentImage + 2;
            root.wrongImage = random5[index_val]//(root.goodValue + root.currentImage + Math.ceil(Math.random() * 2)) % 9
            console.log("wrongImage ", wrongImage, modelIndex)
            index_val++
            if(index_val===5)
            {index_val=1}
            return  "file:" + "./PNH_Test/img/DMS"+ wrongImage + ".png"
        }
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
            //console.log("trigger")
            animation.visible=false
            root.color="black"
            playSound.stop()

            if (root.nb_fail < 3 && root.nb_ok<12)
            {
                init()
            }

            for(var i=0; i<4; i++)
            { rep.itemAt(i).visible = true}

            if(nb_fail==3 || root.nb_ok>=12)
            {

                root.endTime = new Date().getTime() - root.startTime
                testInfo.setValue("nb_ok", root.nb_ok)
                testInfo.setValue("test_time", root.endTime)
                //testSoftware.saveResults() //todo reactiver
                testSoftware.testEnd()
            }
       }
    }

}

