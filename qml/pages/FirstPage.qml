/*****************************************************************************
**                                                                          **
** Created by Antonio Mancini                                               **
** Contact: <ziobilly94@gmail.com>                                          **
** This is a version of classic Tetris game for SailfishOS developed        **
** entirely by me, no copyright infringement intended.                      **
**                                                                          **
*****************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.sailtris.FileIO 1.0
import ".."

Page {

    FileIO {
        id: fileIO
    }

    Functions {
        id: functions
    }

    id: page
    property int dots: fileIO.read("dots") // 0 = dots; 1 = squares
    property bool ghostEnabled: fileIO.read("ghostEnabled")
    property int scoreValue
    property int speedValue
    property real difficulty: fileIO.read("difficulty") === '0' ? 1 : fileIO.read("difficulty")
    property int level
    property int highscoreValue: fileIO.read("highscore["+difficulty+"]")
    property int activeBlock
    property int futureBlock: -1
    property bool savedGame: fileIO.read("slot1") === '0' ? false : true
    property string difficultyText: difficulty === 0.5 ? qsTr("Very Hard") : difficulty === 0.75 ? qsTr("Hard") :difficulty === 1 ? qsTr("Normal") :difficulty === 1.5 ? qsTr("Easy") : qsTr("Very Easy")
    property int combo: 1
    property int gravityBreak: 1
    property bool pauseVal

    // 0 = l_normal; 1 = l_reverse;
    // 2 = s_normal; 3 = s_reverse;
    // 4 = t_normal; 5 = square;
    // 6 = line

    property variant activeColor
    property variant futureColor

    property real centerX
    property real centerY

    Timer {
        id: gameOverTimer
        property int i: 15
        property int j: 10
        property bool clear: true
        interval: 20
        repeat: true
        onTriggered : {
            if (clear) {
                if ( j === 0) {
                    i--
                    j = 10
                } else {
                    if ( i === 0) {
                        clear = false
                        j = 10
                        i = 15
                    } else {
                        var index = i*12+j
                        repeater.itemAt(index).color = Theme.secondaryColor
                        repeater.itemAt(index).opacity = 0.5
                        j--
                    }
                }
            } else {
                if ( j === 0) {
                    i--
                    j = 10
                } else {
                    if ( i === 0) {
                        running = false
                        clear = true
                        root.interactive = true
                        pullDownMenu.enabled = true
                        scoreValue = 0
                        level = 0
                        i = 15
                        j = 10
                    }
                    else {
                        index = i*12+j
                        repeater.itemAt(index).opacity = 0.1
                        j--
                    }
                }
            }
        }
    }


    Timer {
        id: downTimer
        interval: difficulty*(1338*Math.pow(Math.E,-0.26*level)+150)
        repeat: true
        running: false
        onTriggered: {
            functions.flow()
            scoreValue += 1
            speedValue += 1
        }
    }

    SilicaFlickable {
        id: root
        anchors.fill: page
        contentHeight : height
        PushUpMenu {
            id:pushUpMenu
            MenuItem {
                id: pauseMenuItem
                text: qsTr("Resume")
                onClicked: functions.pause()
            }
            MenuItem {
                id:saveMenuItem
                text: qsTr("Save Game")
                onClicked: functions.saveGame()
            }
            enabled: false
        }

        PullDownMenu {
            id: pullDownMenu
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push("About.qml")
            }

            MenuItem {
                text: qsTr("Settings")
                onClicked: {
                    var dialog = pageStack.push("Settings.qml", {"difficulty": difficulty, "dots": dots, "ghostEnabled": ghostEnabled})
                    dialog.accepted.connect(function() {
                        dots = dialog.dots
                        difficulty = dialog.difficulty
                        highscoreValue = dialog.highscoreValue
                        ghostEnabled = dialog.ghostEnabled
                    })
                }
            }

            MenuItem {
                text: qsTr("New Game")
                onClicked: functions.newGame()
            }

            MenuItem {
                id: loadMenuItem
                onClicked: functions.loadGame()
                text: savedGame ? qsTr("Load Game") : qsTr("No Game to Load")
                enabled: savedGame ? true : false
            }
        }

        Label {
            id: score
            text:  difficultyText + " \n" + qsTr("Level ") + "\n" + qsTr("Score ")  + "\n" + qsTr("Highscore ")
            anchors {
                bottom: futureGrid.bottom
                left: parent.left
                leftMargin: Theme.paddingLarge
            }
        }
        Label {
            id: scoreValues
            text:  level + "\n" + scoreValue + "\n" + highscoreValue
            anchors {
                left: score.right
                leftMargin: Theme.paddigMedium
                bottom: score.bottom
            }
        }
        Label {
            id: next
            anchors {
                bottom: futureGrid.top
                horizontalCenter: futureGrid.horizontalCenter
            }
            text: qsTr("Next")
            font.pixelSize: Theme.fontSizeSmall
        }

        Grid {
            id: futureGrid
            anchors {
                top: parent.top
                right: parent.right
                topMargin: Theme.paddingLarge*2
                rightMargin: Theme.paddingLarge
            }
            columns: 4
            rows: 3
            Repeater {
                id: futureRepeater
                model: 12
                delegate: Dot {width: Theme.paddingLarge*5/3 ;color: Theme.secondaryColor; opacity: 0.1}
            }
        }

        Rectangle {
            id: rect
            width: grid.width
            height: grid.height
            anchors {
                bottom: parent.bottom
                bottomMargin: Theme.paddingMedium
            }
            border.color: "transparent"
            color: "transparent"
            opacity: 1
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
                        if (index < 12 || index > 191 || index === 0 || index === 12 ||
                            index === 24 || index === 36 || index === 48 || index === 60 ||
                            index === 72 || index === 84 || index === 96 || index === 108 ||
                            index === 120 || index === 132 || index === 144 || index === 156 ||
                            index === 168 || index === 180 || index === 23 || index === 35 ||
                            index === 47 || index === 59 || index === 71 || index === 83 ||
                            index === 95 || index === 107 || index === 119 || index === 131 ||
                            index === 143 || index === 155 || index === 167 || index === 179 || index === 191)
                        {
                            itemAt(index).active = 3
                            itemAt(index).color = Theme.highlightColor
                            itemAt(index).opacity = 1
                        }
                     }
                }
            }
            MouseArea {
                id: mouseArea
                enabled: false
                anchors.fill: grid

                property real prevX
                property real prevY

                onPressed: {
                    prevX = mouseX
                    prevY = mouseY
                }
                onReleased: {
                    if ( Math.abs(prevY-mouseY) < Theme.paddingMedium &&
                         Math.abs(prevX-mouseX) < Theme.paddingMedium) { // Click
                        functions.rotate()
                        //console.log("Tap")
                    }
                    else
                        if ( Math.abs(prevY-mouseY) > Math.abs(prevX-mouseX) )
                            if ( mouseY > prevY) {        // Swipe Down
                                if ( !multiSwipe.running )
                                    multiSwipe.start()
                                else {
                                    multiSwipe.stop()
                                    functions.instantDown()
                                    //console.log("Double Down")
                                }

                            } else {                        // Swipe Up
                                functions.pause()
                                //console.log("Up")
                            }
                        else
                            if ( mouseX > prevX) {        // Swipe Right
                                functions.right()
                                //console.log("Right")
                            } else {                        // Swipe Left
                                functions.left()
                                //console.log("Left")
                            }
                }
                Timer {
                    id: multiSwipe
                    running: false
                    interval: 300
                    onTriggered: {
                        functions.down()
                    }
                }
            }
            Label {
                id: comboLabel
                anchors {
                    horizontalCenter: rect.horizontalCenter
                    verticalCenter: rect.verticalCenter
                }
                text: "Combo x " + combo
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeHuge
                opacity: 0
            }
            Label {
                id: comboEndLabel
                anchors {
                    horizontalCenter: rect.horizontalCenter
                    verticalCenter: rect.verticalCenter
                }
                text: qsTr("Lost Combo")
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeHuge
                opacity: 0
            }
            Label {
                id: gravityLabel
                anchors {
                    bottom: comboLabel.top
                    horizontalCenter: rect.horizontalCenter
                }
                text: "Gravity Bonus"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeHuge
                opacity: 0
            }
            Timer {
                id: comboTimer
                running: false
                repeat: true
                interval: 100
                onTriggered: {
                    if ( comboLabel.opacity === 0)
                        running = false
                    else
                        comboLabel.opacity -= 0.05
                }
            }
            Timer {
                id: gravityTimer
                running: false
                repeat: true
                interval: 100
                onTriggered: {
                    if ( gravityLabel.opacity === 0)
                        running = false
                    else
                        gravityLabel.opacity -= 0.05
                }
            }
            Timer {
                id: comboEndLabelTimer
                running: false
                repeat: true
                interval: 100
                onTriggered: {
                    if ( comboEndLabel.opacity === 0)
                        running = false
                    else
                        comboEndLabel.opacity -= 0.1
                }
            }
        }
    }
}
