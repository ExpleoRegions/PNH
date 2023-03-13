import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtMultimedia
import QtQuick.Layouts 2.1

Rectangle {
    id: root
    anchors.fill: parent
    color: testInfo.getValue("color_back")
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    property int nbTest: 1
    property int nb_ok: 0
    property double startTime: 0
    property string endTime
    property int nb_total_image: 0      // total differents images in game
    property int nb_choice: 0           // nb displayed images
    property int nb_different_image: 0  // nb images will be different from the start
    property bool response: false       // the monkey is allowed to click
    property int nb_selected: 0         // nb images selected by the monkey
    property double latencyStartTime: 0
    property string latencyEndTime
    property int nb_clicked:0
    property int timing_pic:0
    property int nb_fail:0
    property string sound:""
    property string pic:""

    SoundEffect {
        id: playSound
        source: sound
    }

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        width: Screen.desktopAvailableWidth
        height: Screen.desktopAvailableHeight
        anchors.topMargin : Screen.desktopAvailableHeight/10
        anchors.bottomMargin : Screen.desktopAvailableHeight/10
        anchors.leftMargin : Screen.desktopAvailableWidth/10
        anchors.rightMargin : Screen.desktopAvailableWidth/10

        columnSpacing: 50
        rowSpacing : 50
        rows: 4
        columns: 4
        Image {
            id: image1
            visible: false

            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 2
            width: 280
            height:280
            //source: "file:" + "./PNH_Test/img/RO1.png"
            property bool isDifferent: false
            property int firstImage: 0
            property bool selected: false

            Rectangle {
                anchors.fill: parent
                anchors.margins: -border.width
                z: -1
                border.width: 10
                width: 280
                height:280
                color: 'blue'
                border{
                    id: border1
                    color: 'blue'
                }
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    if (response && !image1.selected){
                        nb_selected++
                        border1.color = testInfo.getValue("color_choice")
                        image1.selected = true;
                        if (nb_selected == 0){
                            root.latencyEndTime = new Date().getTime() - root.latencyStartTime
                            testInfo.setValue("latency" + root.nbTest, root.latencyEndTime)
                        }

                        if (nb_selected >= nb_different_image){
                            timer2.start()//checkResult()
                            response = false
                        }
                    }
                }
            }
            function changeRandomImage()
            {
                var random = (image1.firstImage + Math.ceil(Math.random() * (nb_total_image-2))) % (nb_total_image)
                if (random == 0)
                    random = 1
                console.log("changeRandomImage 1: random= " + random )
                image1.source = "file:" + "./PNH_Test/img/RO"+ random + ".png"
                image1.isDifferent = true
                //console.log("*********************************************" + random)
            }
        }

        Image {
            id: image2
            visible: false

            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 2
            Layout.column: 3
            width: 280
            height:280
            property bool isDifferent: false
            property int firstImage: 0
            property bool selected: false
            Rectangle {
                anchors.fill: parent
                anchors.margins: -border.width
                z: -1
                width: 280
                height:280
                border.width: 10
                color: 'blue'
                border{
                    id: border2
                    color: 'blue'
                }
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    if (response && !image2.selected){
                        nb_selected++
                        border2.color = testInfo.getValue("color_choice")
                        image2.selected = true;
                        if (nb_selected == 0){
                            root.latencyEndTime = new Date().getTime() - root.latencyStartTime
                            testInfo.setValue("latency" + root.nbTest, root.latencyEndTime)
                        }
                        if (nb_selected >= nb_different_image){
                            timer2.start()//checkResult()
                            response = false
                        }
                    }
                }
            }
            function changeRandomImage()
            {
                var random = (image2.firstImage + Math.ceil(Math.random() * (nb_total_image-2))) % nb_total_image
                if (random == 0)
                    random = 1
                console.log("changeRandomImage 2: random= " + random )
                image2.source = "file:" + "./PNH_Test/img/RO"+ random + ".png"
                image2.isDifferent = true
                //console.log("*********************************************" + random)
            }
        }

        Image {
            id: image3
            visible: false
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 3
            width: 280
            height:280
            //source : "file:" + "./PNH_Test/img/RO3.png"
            property bool isDifferent: false
            property int firstImage: 0
            property bool selected: false
            Rectangle {
                anchors.fill: parent
                anchors.margins: -border.width
                z: -1
                border.width: 10
                width: 280
                height:280
                color: 'blue'
                border{
                    id: border3
                    color: 'blue'
                }
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    if (response && !image3.selected){
                        nb_selected++
                        border3.color = testInfo.getValue("color_choice")
                        image3.selected = true;
                        if (nb_selected == 0){
                            root.latencyEndTime = new Date().getTime() - root.latencyStartTime
                            testInfo.setValue("latency" + root.nbTest, root.latencyEndTime)
                        }
                        if (nb_selected >= nb_different_image){
                            timer2.start()//checkResult()
                            response = false
                        }
                    }
                }
            }
            function changeRandomImage()
            {
                var random = (image3.firstImage + Math.ceil(Math.random() * (nb_total_image-2))) % nb_total_image
                if (random == 0)
                    random = 1
                console.log("changeRandomImage 3: random= " + random )
                image3.source = "file:" + "./PNH_Test/img/RO"+ random + ".png"
                image3.isDifferent = true
                //console.log("*********************************************" + random)
            }
        }

        Image {
            id: image4
            visible: false

            Layout.columnSpan: 1
            Layout.rowSpan: 1
            Layout.row: 3
            Layout.column: 2
            width: 280
            height:280
            property bool isDifferent: false
            property int firstImage: 0
            property bool selected: false
            Rectangle {
                anchors.fill: parent
                anchors.margins: -border.width
                z: -1
                border.width: 10
                width: 280
                height:280
                color: 'blue'
                border{
                    id: border4
                    color: 'blue'
                }
            }
            MouseArea {
                anchors.fill: parent
                onPressed: {
                    if (response && !image4.selected){
                        nb_selected++
                        border4.color = testInfo.getValue("color_choice")
                        image4.selected = true;
                        if (nb_selected == 0){
                            root.latencyEndTime = new Date().getTime() - root.latencyStartTime
                            testInfo.setValue("latency" + root.nbTest, root.latencyEndTime)
                        }
                        if (nb_selected >= nb_different_image){
                            timer2.start()//checkResult()
                            response = false
                        }
                    }
                }
            }
            function changeRandomImage()
            {
                var random = (image4.firstImage + Math.ceil(Math.random() * (nb_total_image-2))) % (nb_total_image)
                if (random == 0)
                    random = 1
                console.log("changeRandomImage 4: random= " + random )
                image4.source = "file:" + "./PNH_Test/img/RO"+ random + ".png"
                image4.isDifferent = true
                //console.log("*********************************************" + random)
            }
        }


    }
    Component.onCompleted: {
        //testSoftware.testEnd()
        startTime = new Date().getTime()
        nb_total_image = testInfo.getValue("nb_total_image")

        nb_choice = 2//testInfo.getValue("nb_choice")
//        if (nb_choice <2)
//            nb_choice = 2

        nb_different_image = 1//testInfo.getValue("nb_different_image")
        init()
    }

    function init() {
        response = false
        nb_selected = 0;
        image1.isDifferent = false
        image1.firstImage = 0
        image1.selected = false
        border1.color = 'black'

        image2.isDifferent = false
        image2.firstImage = 0
        image2.selected = false
        border2.color = 'black'

        image3.isDifferent = false
        image3.firstImage = 0
        image3.selected = false
        border3.color = 'black'

        image4.isDifferent = false
        image4.firstImage = 0
        image4.selected = false
        border4.color = 'black'
        var random1, random2, random3, random4


        if(root.nb_clicked<2){
            random1 = Math.random() * nb_total_image
            random1 = Math.ceil(random1)
            console.log("init: random1= " + random1 )
            random4=random3=random2=random1
        }
        if(root.nb_clicked==2){
            random4=2
            random3=4
            random2=1
            random1=3
            console.log("================================nb_clicked 1 =" + root.nb_clicked )
        }
        if (nb_choice >= 2){
            console.log("================================nb_clicked 2 =" + root.nb_clicked )

            image2.source = "file:" + "./PNH_Test/img/RO"+ random2 + ".png"
            image2.visible = true
            image2.firstImage = random2
            image1.source = "file:" + "./PNH_Test/img/RO"+ random1 + ".png"
            image1.visible = true
            image1.firstImage = random1
        }
        if (nb_choice >= 3){
            image3.source = "file:" + "./PNH_Test/img/RO"+ random3 + ".png"
            image3.visible = true
            image3.firstImage = random3
        }
        if (nb_choice >= 4){
            image4.source = "file:" + "./PNH_Test/img/RO"+ random4 + ".png"
            image4.visible = true
            image4.firstImage = random4
        }
        timerBlackScreen.start()
        console.log("init **********************************************")
    }

    Timer {
        id: timerBlackScreen
        interval: 2000;
        running: true;
        onTriggered: hideAllImages()
    }

    function hideAllImages() {
        image1.visible = false
        image2.visible = false
        image3.visible = false
        image4.visible = false
        timer1.start()
        console.log("BlackScreen")
    }

    Timer  {
        id: timer1
        interval: 2000//testInfo.getValue("timer1");
        running: true;
        //repeat: true;
        onTriggered: time1()
    }

    function time1()  {
        // choose image to change
        //TODO do multiple image change not only 2

        let random5 = [0,0, 0, 0]
        var x=0, tmp=0;

        /* Initialise le tableau */
        for ( var i=1 ; i<5 ; i++ )
        {
            random5[i-1] = i;
        }

        /* Generation aleatoire */
        //srand(time(NULL));
        for ( var i=1 ; i<5 ; i++ )
        {
            x = i + Math.floor(Math.random() * (nb_choice-i));

            /* On permute les valeurs du tableau */
            tmp = random5[i-1];
            random5[i-1] = random5[x-1];
            random5[x-1] = tmp;
        }

        if (nb_choice >= 2){
            image2.visible = true
            image1.visible = true
        }
        if (nb_choice >= 3){
            image3.visible = true
        }
        if (nb_choice >= 4){
            image4.visible = true
        }

        for(var i=0; i<nb_different_image; i++)
        {
        console.log("random5 =========================================================== " + random5[i]);


         switch(random5[i]){
            case 1:{
                image1.changeRandomImage();
                break ;
            }
            case 2:{
                image2.changeRandomImage();
                break ;
            }
            case 3:{
                image3.changeRandomImage();
                break ;
            }
            case 4:{
                image4.changeRandomImage();
                break ;
            }
        }

        //console.log("for time",rep.itemAt(random5[j]).illuminated)
        }

        response = true
        latencyStartTime = new Date().getTime()

    }
    Timer  {
        id: timer2
        interval: 800
        running: false;
        //repeat: true;
        onTriggered: checkResult()
    }

    function checkResult()
    {
        var result = true;
        if (image1.selected != image1.isDifferent || image2.selected != image2.isDifferent || image3.selected != image3.isDifferent || image4.selected != image4.isDifferent && root.nb_fail<3)
        {
            image1.visible = false
            image2.visible = false
            image3.visible = false
            image4.visible = false
            root.pic="file:" + "./PNH_Test/img/sad.png"
            animation.visible=true
            root.sound= "file:" + "./PNH_Test/sound/Wrong_Answer.wav"
            root.color="#f44336"
            playSound.play()
            timer_pic.start()
            //init();
            result = false;
            root.nb_fail++
            console.log("nb_fail++ ************************************************", root.nb_fail)
            console.log("************************************************nb_ok", root.nb_ok)

        }
//        if (image2.selected != image2.isDifferent)
//            result = false;
//        if (image3.selected != image3.isDifferent)
//            result = false;checkResult
//        if (image4.selected != image4.isDifferent)
//            result = false;

        if (result === true && root.nb_fail < 3)
        {
            image1.visible = false
            image2.visible = false
            image3.visible = false
            image4.visible = false
            animation.visible=true
            root.pic= "file:" + "./PNH_Test/img/SMILE.png"
            root.sound= "file:" + "./PNH_Test/sound/Right_Answer.wav"
            root.color= "#4caf50"
            playSound.play()
            timer_pic.start()
            //init();
            root.nb_ok++;
            console.log("************************************************nb_ok", root.nb_ok)
            console.log("checkResult************************************************")

        }

        if(root.nb_fail==3 || (root.nb_fail<3 && root.nb_clicked>2))
        {
            console.log("fail **********************************************")

            root.endTime = new Date().getTime() - root.startTime
            testInfo.setValue("nb_ok", root.nb_ok)
            testInfo.setValue("test_time", root.endTime)
            testSoftware.saveResults() // todo reactiver
            testSoftware.testEnd()
        }



    }

    Timer  {
        id: timer_Level
        interval: 15000
        running: true;
        //repeat: true;
        onTriggered: {
            nextLevel()

        }
    }

    function nextLevel(){
       if( (root.nb_ok/(root.nb_ok+root.nb_fail)) >= 0.9){

//           image1.visible = false
//           image2.visible = false
//           image3.visible = false
//           image4.visible = false
//           animation.visible=true
//           timing_pic=5000
//           root.pic= "file:" + "./PNH_Test/img/SMILE.png"
//           root.sound= "file:" + "./PNH_Test/sound/Right_Answer.wav"
//           root.color= "#4caf50"
//           playSound.play()
//           timer_pic.start()

           nb_choice=4
           console.log("next level **********************************************")

           if(root.nb_clicked==1 && nb_different_image < 3){
               nb_different_image++
               console.log("**********************************************AA nb_different_image", nb_different_image)
            }
           else{
               root.nb_clicked++
            }
       }
       else{
//           image1.visible = false
//           image2.visible = false
//           image3.visible = false
//           image4.visible = false
//           timing_pic=2000
//           root.pic="file:" + "./PNH_Test/img/sad.png"
//           animation.visible=true
//           root.sound= "file:" + "./PNH_Test/sound/Wrong_Answer.wav"
//           root.color="#f44336"
//           playSound.play()
//           timer_pic.start()
//           console.log("fail Level **********************************************")
       }
       timer_Level.start()
    }

    Image {
        id: animation
        autoTransform :true
        fillMode: Image.Pad
        source: root.pic
        width: Screen.desktopAvailableWidth/4; height: Screen.desktopAvailableHeight/4
        anchors.fill: parent
        visible: false
    }
    Timer  {
        id: timer_pic
        interval: 800
        running: false
        repeat : false
        onTriggered: {
            //console.log("trigger")
            animation.visible=false
            root.color="black"
            playSound.stop()
            init();

            if (nb_fail==3)//ou il a fini tout les tests juste
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

