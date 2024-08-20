import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import Qt.labs.qmlmodels
import QtMultimedia

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

                Video {
                    id: video
                    anchors.fill: parent
                    source: "file:///C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Video/" + vPath
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

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    anchors.leftMargin: bottomLeftRect.width * 0.95
                    anchors.topMargin: 5
                    anchors.rightMargin: 5
                    anchors.bottomMargin: bottomLeftRect.height * 0.9

                    color: "red"
                    Timer{
                        id: blinkTimer
                        interval: 1000
                        running: true
                        repeat: true

                        onTriggered: {
                            if(notificationLight.color === "red"){
                                notificationLight.color= "white";
                            }
                            else if(notificationLight.color === "white"){
                                notificationLight.color= "red";
                            }
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
                                blinkTimer.start();
                                video.source = "file:///C:/Qt_Applications/ProjectQt/AudioVideoRecorder/Video/video2.mp4"
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
                                text: "Audio"
                                checked: true
                                font.pointSize: 10
                            }
                            RadioButton{
                                text: "Video"
                                font.pointSize:10
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
                                blinkTimer.stop();
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
                    model: ListModel {
                        id:itemModel
                        ListElement { item: "video1" }
                        ListElement { item: "Row 2" }
                        ListElement { item: "Row 3" }
                        ListElement { item: "Row 4" }
                        ListElement { item: "Row 5" }
                        ListElement { item: "Row 6" }
                        ListElement { item: "Row 7" }
                        ListElement { item: "Row 8" }
                        ListElement { item: "Row 9" }
                        ListElement { item: "Row 10" }
                        ListElement { item: "Row 11" }
                        ListElement { item: "Row 12" }
                        ListElement { item: "Row 13" }
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
                                    console.log("Clicked on:", model.item);
                                    vPath = model.item + ".mp4"
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: model.item
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
                                MouseArea {
                                    id: mouseArea3
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onPressed: deleteBtnStyle.color = "#303030"
                                    onReleased: deleteBtnStyle.color = "#db2518"

                                    onClicked: {
                                        console.log("Deleted :", model.item);
                                        itemModel.remove(index);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
