/*****************************************************************************
**                                                                          **
** Created by Antonio Mancini                                               **
** Contact: <ziobilly94@gmail.com>                                          **
** This is a version of classic Tetris game for SailfishOS compiled         **
** entirely by me, no copyright infringement intended.                      **
**                                                                          **
*****************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

Page {
    id: page
    property int scoreValue
    property int speedValue
    property int speed
    property int interval
    property int activeBlock
    property int futureBlock
    property variant activeColor
    property real centerX
    property real centerY
    // 0 = l_normal; 1 = l_reverse;
    // 2 = s_normal; 3 = s_reverse;
    // 4 = t_normal; 5 = square;
    // 6 = line

    Functions {
        id: functions
    }
    Timer {
        id: downTimer
        interval: interval - speed
        repeat: true
        running: true
        onTriggered: functions.down()
    }

    SilicaFlickable {
        id: root
        anchors.fill: parent
        PullDownMenu {
            id: pullDownMenu
            MenuItem {
                text: qsTr("About Page")
                onClicked: pageStack.push("About.qml")
            }

            MenuItem {
                text: qsTr("New Game")
                onClicked: functions.newGame()
            }
            MenuItem {
                text: qsTr("Debug Settings")
                onClicked: {
                    var dialog = pageStack.push("DebugSettings.qml")
                    dialog.accepted.connect(function() {
                        interval = dialog.timerValue
                        values.opacity = dialog.gridOpacity
                        rect.color = dialog.gridOpacity ? "green" : "transparent"
                        debugLabel.opacity = dialog.gridOpacity
                        visible = dialog.gridOpacity ? true : false
                    })
                }
                visible: false

            }
            MenuItem {
                id: pauseMenuItem
                text: qsTr("Unpause")
                onClicked: functions.pause()
                visible: false
            }
        }

        Label {
            id: score
            text: qsTr("Score: ") + scoreValue
            anchors {
                top: parent.top
                left: parent.left
                topMargin: Theme.paddingLarge
                leftMargin: Theme.paddingLarge
            }
        }
        Label {
            id: debugLabel
            opacity: 0
            anchors {
                top: score.bottom
                left: parent.left
                topMargin: Theme.paddingLarge
                leftMargin: Theme.paddingLarge
            }
            text: "speedValue: " + speedValue + " speed: " + speed  + " Timer: " + downTimer.interval
        }

        Rectangle {
            // Dots grid
            Grid {
                id: grid
                columns: 12
                rows: 17
                Repeater {
                    id: repeater
                    model: 204
                    delegate: Dot {width: page.width/12 ;color: Theme.secondaryColor; opacity: 0.1}
                    onItemAdded: { // Bordi "muro"... seriamente, si può fare di meglio, 576 caratteri per una linea è più brutto di questo commento, da aggiungere a newGame() magari
                        if (index < 12 || index > 191 || index === 0 || index === 12 || index === 24 || index === 36 || index === 48 || index === 60 || index === 72 || index === 84 || index === 96 || index === 108 || index === 120 || index === 132 || index === 144 || index === 156 || index === 168 || index === 180 || index === 23 || index === 35 || index === 47 || index === 59 || index === 71 || index === 83 || index === 95 || index === 107 || index === 119 || index === 131 || index === 143 || index === 155 || index === 167 || index === 179 || index === 191) {
                            itemAt(index).active = 3
                            itemAt(index).color = Theme.highlightColor
                            itemAt(index).opacity = 1
                        }
                    }
                }
            }
            // Debug grid
            Grid {
                id: values
                columns: 12
                rows: 17
                opacity: 0
                Repeater {
                    model: 204
                    delegate: Label {
                        width: page.width/12;
                        height: width;
                        text: index;
                        opacity: 0.25;
                        horizontalAlignment: Text.AlignHCenter;
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            id: rect
            width: grid.width
            height: grid.height
            anchors {
                top: parent.top
                topMargin: Theme.paddingLarge * 7
            }
            border.color: "transparent"
            color: "transparent"
            opacity: 1

            MouseArea {
                id: mouseArea
                enabled: false
                anchors.fill: grid

                property real prevX
                property real prevY

                onPressed: {
                    prevX = mouseX
                    prevY = mouseY
                    console.log("pressed")
                }
                onReleased: {
                    if ( Math.abs(prevY-mouseY) < Theme.paddingLarge &&
                            Math.abs(prevX-mouseX) < Theme.paddingLarge){ // Click
                        functions.rotate()
                        console.log("Click")
                    }
                    else
                        if ( Math.abs(prevY-mouseY) > Math.abs(prevX-mouseX) )
                            if ( mouseY > prevY)        // Swipe Down
                                functions.down()
                            else                        // Swipe Up
                                functions.pause()
                        else
                            if ( mouseX > prevX)        // Swipe Right
                                functions.right()
                            else                        // Swipe Left
                                functions.left()
                }
            }
        }
    }
}