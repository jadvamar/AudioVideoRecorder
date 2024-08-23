import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels
import QtMultimedia
import Qt.labs.folderlistmodel
Window {
    id: mainWindow
    width: 650
    height: 450
    visible: true
    title: qsTr("Recorder")

    property string vPath: "video3.mp4"

    Rectangle {
        id: mainBox
        width: mainWindow.width
        height: mainWindow.height
        border.color: "black"
        color: "#202121"
        border.width: 1

        Rectangle{
            id:leftRect
            width: mainBox.width * 0.6
            height: mainBox.height
            border.color: "black"
            border.width: 1

            Rectangle{
                id:topLeftRect
                width: leftRect.width
                height: leftRect.height * 0.6
                color: "#202121"
                border.color: "black"
                border.width: 1

                StackView{
                    id: stackView
                    anchors.fill: parent
                    initialItem: videoRect
                }

                Rectangle{
                    id: videoRect
                    color: "#202121"
                    Video {
                        id: video
                        anchors.fill: parent
                        source: filePath + vPath
                        autoPlay: true
                        fillMode: Video.Stretch
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked: {
                                if (video.playing) {
                                    video.pause();
                                } else {
                                    video.play();
                                }
                            }
                        }
                    }
                    Row {
                        id:playPuseBtn
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10

                        Button {
                            text: "Play"
                            onClicked: video.play()
                        }

                        Button {
                            text: "Pause"
                            onClicked: video.pause()
                        }

                        Button {
                            text: "Stop"
                            onClicked: video.stop()
                        }
                    }
                }
                Rectangle{
                    id:audioRect
                    border.color: "#cccccc"
                    radius: 50

                    Text{
                        id:audioText
                        text: vPath
                        font.pixelSize: 20
                        anchors.centerIn: parent
                    }

                    MediaPlayer {
                        id: playMusic
                        source: filePath + vPath
                        autoPlay: false // Enable auto-play
                        audioOutput: AudioOutput {
                            id:audioOutput
                            volume: 0.4

                        }
                    }
                    // Timer {
                    //     id: updateTimer
                    //     interval: 1000 // Update every second
                    //     running: true
                    //     repeat: true
                    //     onTriggered: {
                    //         if (playMusic.status === playMusic.Playing) {
                    //             slider.value = playMusic.position / 1000; // Convert milliseconds to seconds
                    //         }
                    //     }
                    // }

                    Slider {
                        id: slider
                        from: 0
                        to: 1
                        value: 0.43
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.5
                        onValueChanged: {
                            audioOutput.volume = slider.value
                        }
                    }

                    Text {
                        text:Math.round(slider.value * 100) + "%"
                        //text: slider.values
                        anchors.left: slider.right
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.leftMargin: 10
                        anchors.bottom: audioRect.bottom
                        anchors.bottomMargin: 5
                    }


                    Button {
                        text: "Play"
                        anchors.left: parent.left
                        anchors.bottom: slider.top
                        anchors.leftMargin: parent.width * 0.52

                        anchors.bottomMargin: 10
                        onClicked: playMusic.play() // Start playback when clicked
                    }

                    // Define Pause Button
                    Button {
                        text: "Pause"
                        anchors.left: parent.left
                        anchors.bottom: slider.top
                        anchors.leftMargin: parent.width * 0.37
                        anchors.bottomMargin: 10
                        onClicked: playMusic.pause() // Pause playback when clicked
                    }
                }
                Rectangle{
                    id:cameraRect
                    color: "#314463"
                    border.color: "#cccccc"
                    radius: 50
                    Text{
                        text : "Video Recording..."
                        anchors.centerIn: parent
                    }
                    CaptureSession {
                            id: captureSession
                            camera: Camera {
                                id: camera
                                onErrorOccurred: {
                                    console.error("Camera error: " + errorString)
                                }
                            }
                            videoOutput: videoOutput
                            recorder: MediaRecorder {
                                id: mediaRecorderCamera
                                onErrorOccurred: {
                                    console.error("Recording error: " + error)
                                }
                                outputLocation: "file:///C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Storage/Rec_Video_1"
                            }
                            audioInput: AudioInput {
                                id:audioInputCamera
                            }
                        }
                }
                Rectangle{
                    id:micRect
                    color: "#315563"
                    border.color: "#cccccc"
                    radius: 50
                    Text{
                        text : "Audio Recording..."
                        anchors.centerIn: parent
                    }

                    CaptureSession {
                            id: captureSessionMic

                            audioInput: AudioInput {
                                id: audioInput
                            }

                            recorder: MediaRecorder {
                                id: mediaRecorderMic
                                outputLocation: "file:///C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Storage/Rec_Audio_1"
                            }
                        }
                }
            }
            Rectangle{
                id:bottomLeftRect

                color: "#202121"

                width: leftRect.width
                height: leftRect.height * 0.3

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                anchors.topMargin: leftRect.height * 0.6

                border.color: "black"
                border.width: 1

                Rectangle{
                    id:notificationLight
                    radius: 90
                    height: 5
                    width: 5
                    border.color: "black"
                    border.width: 1
                    color: "red"
                    visible: false
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    anchors.leftMargin: bottomLeftRect.width * 0.95
                    anchors.topMargin: 5
                    anchors.rightMargin: 5
                    anchors.bottomMargin: bottomLeftRect.height * 0.9


                    Timer{
                        id: blinkTimer
                        interval: 500
                        running: false
                        repeat: true

                        onTriggered: {
                            notificationLight.visible = !notificationLight.visible
                        }
                    }
                }
                GridLayout{
                    id:gridId

                    width: bottomLeftRect.width
                    height: bottomLeftRect.height

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    columns: 3
                    rows: 1
                    columnSpacing: 10

                    Rectangle {
                        id: startButtonRect
                        color: "#3c3d3d"
                        height: gridId.height
                        width: gridId.width * 0.3
                        // border.color: "black"
                        // border.width: 1
                        radius: 90

                        Button {
                            id: startBtn
                            text: "Start"

                            background: Rectangle {
                                id: startBtnstyle
                                color: "#6e6e6e"
                                radius: 90
                            }

                            hoverEnabled: false
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10

                            onPressed: startBtnstyle.color = "#f0f2f0"
                            onReleased: startBtnstyle.color = "#6e6e6e"

                            onClicked: {
                                if (audioRadio.checked) {
                                    while (stackView.depth > 1 && stackView.currentItem !== micRect) {
                                        stackView.pop();
                                    }
                                    if (stackView.currentItem !== micRect) {
                                        stackView.push(micRect);
                                    }
                                    if (mediaRecorderMic.recorderState === MediaRecorder.StoppedState) {
                                        console.log("Starting recording Audio...")
                                        mediaRecorderMic.record()
                                        startBtn.text = "Recording..."
                                        startBtn.enabled = false
                                        //stopBtn.text = "Stop Recording"
                                        stopBtn.enabled = true
                                        //notifi.visible = true
                                        blinkTimer.start()
                                    }

                                } else if (videoRadio.checked) {
                                    while (stackView.depth > 1 && stackView.currentItem !== cameraRect) {
                                        stackView.pop();
                                    }
                                    if (stackView.currentItem !== cameraRect) {
                                        stackView.push(cameraRect);
                                    }
                                    if (mediaRecorderCamera.recorderState === MediaRecorder.StoppedState) {
                                        console.log("Starting recording video...")
                                        mediaRecorderCamera.record()
                                        startBtn.text = "Recording..."
                                        startBtn.enabled = false
                                        stopBtn.enabled = true
                                        blinkTimer.start();
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: radioBtnRect
                        // border.color: "black"
                        // border.width: 1
                        color: "#202121"
                        height: parent.height
                        width: parent.width * 0.3

                        GridLayout{
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 10
                            anchors.bottomMargin: 50
                            anchors.leftMargin: 30
                            anchors.rightMargin: 10

                            columns: 1
                            rows: 2
                            RadioButton{
                                id:audioRadio
                                text: "Audio"
                                checked: true
                                font.pointSize: 10

                                // contentItem: Text{
                                //     text: audioRadio.text
                                //     color: "white"
                                // }
                            }
                            RadioButton{
                                id:videoRadio
                                text: "Video"
                                font.pointSize:10

                                // contentItem: Text{
                                //     text: videoRadio.text
                                //     color: "white"
                                // }
                            }
                        }
                    }
                    Rectangle {
                        id: stopButton
                        color: "#3c3d3d"
                        // border.color: "black"
                        // border.width: 1
                        radius: 90

                        height: parent.height
                        width: parent.width * 0.3

                        Button {
                            id: stopBtn
                            text: "Stop"
                            background: Rectangle {
                                id:stopBtnStyle
                                color: "#6e6e6e"
                                radius: 90
                            }
                            hoverEnabled: false

                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            onPressed: stopBtnStyle.color = "#f0f2f0"
                            onReleased: stopBtnStyle.color = "#6e6e6e"

                            onClicked: {
                                if (mediaRecorderMic.recorderState === MediaRecorder.RecordingState) {
                                    console.log("Stopping recording audio...")
                                    mediaRecorderMic.stop()
                                    startBtn.text = "Start"
                                    startBtn.enabled = true
                                    blinkTimer.stop();
                                }
                                else if(mediaRecorderCamera.recorderState === MediaRecorder.RecordingState)
                                {
                                    console.log("Stopping recording video...")
                                    mediaRecorderCamera.stop();
                                    startBtn.text = "Start"
                                    startBtn.enabled = true
                                    blinkTimer.stop();
                                }
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            id:rightRect
            width: mainBox.width * 0.4
            height: mainBox.height
            color: "#202121"
            anchors.left: parent.left
            anchors.leftMargin: mainBox.width * 0.6

            ScrollView {
                id: scrollView
                width: rightRect.width
                height: rightRect.height
                anchors.fill: parent

                ListView  {
                    id: listView
                    width: scrollView.width
                    height: scrollView.height

                    model: FolderListModel {
                       id: itemModel
                       folder: filePath
                       nameFilters: ["*.mp3" , "*.mp4" , "*.m4a"]
                    }
                    delegate: Item {
                        width: listView.width * 0.5
                        height: 50
                        Rectangle {
                            id:listRect
                            width: listView.width
                            height: 50
                            color: "#202121"
                            border.color: "black"

                            MouseArea {
                                id: mouseArea2
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onPressed: listRect.color = "#303030"
                                onReleased: listRect.color = "#202121"

                                onClicked: {
                                    console.log("Clicked on:", model.fileName);
                                    vPath = model.fileName
                                    var lastChar = fileName.slice(-1);
                                    var substring = fileName.slice(4, 9);
                                    console.log(substring);
                                    if (mediaRecorderMic.recorderState === MediaRecorder.RecordingState) {
                                        console.log("Stopping recording audio...")
                                        mediaRecorderMic.stop()
                                        startBtn.text = "Start"
                                        startBtn.enabled = true
                                        blinkTimer.stop();
                                    }
                                    if(mediaRecorderCamera.recorderState === MediaRecorder.RecordingState)
                                    {
                                        console.log("Stopping recording video...")
                                        mediaRecorderCamera.stop();
                                        startBtn.text = "Start"
                                        startBtn.enabled = true
                                        blinkTimer.stop();
                                    }

                                    if(lastChar === "4" || substring === "Video"){
                                        while (stackView.depth > 1 && stackView.currentItem !== videoRect) {
                                            stackView.pop();
                                        }
                                        if (stackView.currentItem !== videoRect) {
                                            stackView.push(videoRect);
                                        }
                                        video.play();
                                    }
                                    else{
                                        while (stackView.depth > 1 && stackView.currentItem !== audioRect) {
                                            stackView.pop();
                                        }
                                        if (stackView.currentItem !== audioRect) {
                                            stackView.push(audioRect);
                                        }
                                        playMusic.play();
                                    }
                                }
                            }
                            Text {
                                anchors.centerIn: parent
                                text: model.fileName
                                color: "#d9d9d9"
                            }
                            Button{
                                id:deleteBtn
                                text: "delete"

                                hoverEnabled: false

                                background: Rectangle {
                                    id:deleteBtnStyle
                                    color: "#db2518"
                                    radius: 10
                                }

                                anchors.left: parent.left
                                anchors.bottom: parent.bottom

                                anchors.leftMargin: parent.width * 0.7
                                anchors.bottomMargin: parent.height * 0.26
                                onClicked: {
                                    itemModel.removeRow();
                                    console.log("Deleted :", model.fileName);
                                }

                                // MouseArea {
                                //     id: mouseArea3
                                //     anchors.fill: parent
                                //     cursorShape: Qt.PointingHandCursor
                                //     onPressed: deleteBtnStyle.color = "#303030"
                                //     onReleased: deleteBtnStyle.color = "#db2518"

                                //     onClicked: {
                                //         console.log("Deleted :", model.fileName);
                                //         //itemModel.removeRow(index);
                                //         //itemModel.removeColumn(index)
                                //         //itemModel.remove(index);
                                //     }
                                // }
                            }
                        }
                    }
                }
            }
        }
    }
}
