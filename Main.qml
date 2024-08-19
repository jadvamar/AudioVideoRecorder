import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels
Window {
    id: mainWindow
    width: 640
    height: 380
    visible: true
    title: qsTr("Recorder")

    Rectangle {
        id: mainBox
        color: "#282b2a"
        width: mainWindow.width
        height: mainWindow.height

        Rectangle {
            id: header
            width: mainBox.width
            height: mainBox.height

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            anchors.bottomMargin: parent.height * 0.7

            Rectangle {
                id: leftHeader
                width: header.width * 0.65
                height: header.height

                Rectangle {
                    id: startButtonRect
                    color: "#181a19"
                    width: leftHeader.width * 0.33
                    height: leftHeader.height

                    Button {
                        id: startBtn
                        text: "Start"

                        background: Rectangle {
                            id: startBtnstyle
                            color: "#6e6e6e"
                            radius: 10
                        }

                        hoverEnabled: false
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 30
                        anchors.bottomMargin: 30
                        anchors.leftMargin: 30
                        anchors.rightMargin: 30

                        onPressed: startBtnstyle.color = "#f0f2f0"
                        onReleased: startBtnstyle.color = "#6e6e6e"

                        onClicked: {
                            if (!blinkTimer.running) {
                                notificationLight.color = "red"; // Ensure the rectangle starts as red
                                blinkTimer.start();
                            }

                        }
                    }
                }
                Rectangle {
                    id: stopButton
                    color: "#181a19"
                    width: leftHeader.width * 0.33
                    height: leftHeader.height

                    anchors.left: parent.left
                    anchors.leftMargin: leftHeader.width * 0.33

                    Button {
                        id: stopBtn
                        text: "Stop"
                        background: Rectangle {
                            id:stopBtnStyle
                            color: "#6e6e6e"
                            radius: 10
                        }
                        hoverEnabled: false

                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 30
                        anchors.bottomMargin: 30
                        anchors.leftMargin: 30
                        anchors.rightMargin: 30
                        onPressed: stopBtnStyle.color = "#f0f2f0"
                        onReleased: stopBtnStyle.color = "#6e6e6e"

                        onClicked: {
                            blinkTimer.stop();
                        }
                    }
                }
                Rectangle {
                    id: deleteButton
                    color: "#181a19"
                    width: leftHeader.width * 0.33
                    height: leftHeader.height

                    anchors.left: parent.left
                    anchors.leftMargin: leftHeader.width * 0.66

                    Button {
                        id: deleteBtn
                        text: "Delete"
                        background: Rectangle {
                            id:deleteBtnStyle
                            color: "#6e6e6e"
                            radius: 10
                        }
                        hoverEnabled: false

                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 30
                        anchors.bottomMargin: 30
                        anchors.leftMargin: 30
                        anchors.rightMargin: 30
                        onPressed: deleteBtnStyle.color = "#f0f2f0"
                        onReleased: deleteBtnStyle.color = "#6e6e6e"
                    }
                }
            }
            Rectangle{
                id:rightHeader
                color: "#486154" //"#181a19"
                width: header.width * 0.37
                height: header.height

                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.64

                GridLayout{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    anchors.leftMargin: 10
                    anchors.rightMargin: 30
                    columns: 3
                    rows: 1
                    columnSpacing: 10
                    RadioButton{
                        text: "Audio"
                    }
                    RadioButton{
                        text: "Video"
                    }
                    Rectangle{
                        id:notificationLight
                        radius: 10
                        height: 15
                        width: 15
                        //color: "red"
                        Timer{
                            id: blinkTimer
                            interval: 1000
                            running: false
                            repeat: true

                            onTriggered: {
                                if (notificationLight.color === "red") {
                                    notificationLight.color = "white";
                                    colorChangeTimer.interval = 500; // Set to half a second
                                } else if (notificationLight.color === "white") {
                                    notificationLight.color = "red";
                                    colorChangeTimer.interval = 1000; // Set back to one second
                                    colorChangeTimer.stop(); // Stop the timer after returning to red
                                }
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            id: footer
            width: mainBox.width
            height: mainBox.height * 0.7
            anchors.top: mainBox.top
            color: "yellow"
            anchors.topMargin: parent.height * 0.3
            ScrollView {
                id: scrollView
                width: footer.width  // Leave space for the slider
                height: footer.height
                anchors.fill: parent

                TableView {
                    id: tableView
                    width: scrollView.width
                    height: scrollView.height
                    model: TableModel {
                        TableModelColumn { display: "Item" }
                        rows:
                        [
                            { "Item": "Row 1"},
                            { "Item": "Row 2"},
                            { "Item": "Row 3"},
                            { "Item": "Row 4"},
                            { "Item": "Row 5"},
                            { "Item": "Row 6"},
                            { "Item": "Row 7"},
                            { "Item": "Row 8"},
                            { "Item": "Row 9"},
                            { "Item": "Row 10"}
                        ]
                    }
                    delegate: Item {
                        width: tableView.width * 0.5
                        height: 50
                        Rectangle {
                            width: tableView.width
                            height: 50
                            color: "lightgray"
                            border.color: "black"
                            Text {
                                anchors.centerIn: parent
                                text: model.display
                            }
                        }
                    }
                }
            }
        }
    }
}
