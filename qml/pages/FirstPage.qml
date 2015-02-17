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
import QtQuick.LocalStorage 2.0
import "../storage.js" as Storage
import ".."


Page {
    id: page
    property int dots: Storage.get("dots") // 0 = dots; else = squares
    property int scoreValue
    property int speedValue
    property real difficulty: Storage.get("difficulty") === 0 ? 1 : Storage.get("difficulty")
    property int level
    property variant highscoreValue: Storage.get("highscore["+difficulty+"]")
    property int activeBlock
    property int futureBlock: -1
    property int savedGame: Storage.get("savedGame")

    // 0 = l_normal; 1 = l_reverse;
    // 2 = s_normal; 3 = s_reverse;
    // 4 = t_normal; 5 = square;
    // 6 = line

    property variant activeColor
    property variant futureColor

    property real centerX
    property real centerY

    Functions {
        id: functions
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
                text: qsTr("About Page")
                onClicked: pageStack.push("About.qml")
            }
            MenuItem {
                property string type: dots === 0 ? qsTr("Dots") : qsTr("Squares")
                text: qsTr("Block Type: ") + type
                onClicked: {
                    if (dots === 0) {
                        dots = 1
                        Storage.set("dots", 1)
                    }
                    else {
                        dots = 0
                        Storage.set("dots", 0)
                    }
                }
            }
            MenuItem {
                id: diffItem
                property string diff: difficulty === 0.5 ? qsTr("Very Hard") : difficulty === 0.75 ? qsTr("Hard") : difficulty === 1 ? qsTr("Normal") : difficulty === 1.5 ? qsTr("Easy") : qsTr("Very Easy")
                text: qsTr("Difficulty: ") + diff
                onClicked: functions.setDifficulty()
            }
            MenuItem {
                text: qsTr("New Game")
                onClicked: functions.newGame()
            }
            MenuItem {
                id: loadMenuItem
                onClicked: savedGame === 1 ? functions.loadGame() : savedGame +=0
                text: savedGame === 1 ? qsTr("Load Game") : qsTr("No Game to Load")
            }

        }

        Item {
            id: savingPage
            anchors.fill: parent
            visible: false
            z: 1
            property int progress
            property int total: 204

            Timer {
                id: savingTimer
                interval: 1
                running: false
                repeat: true
                property int index: 0
                onTriggered: {
                    if (index === 204) {
                        stop()
                        savingPage.visible = false
                        pullDownMenu.enabled = true
                        pushUpMenu.enabled = true
                        root.interactive = true
                    }  else {
                        console.log("saving " + index)
                        Storage.set("Dot["+index+"].active",repeater.itemAt(index).active)
                        Storage.set("Dot["+index+"].opacity",repeater.itemAt(index).opacity)
                        Storage.set("Dot["+index+"].color",repeater.itemAt(index).color)
                        index += 1
                        savingPage.progress += 1
                    }
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "black"
                opacity: 0.7
            }
            ProgressBar {
                minimumValue: 0
                maximumValue: savingPage.total
                value: savingPage.progress
                width: savingPage.width
                anchors.verticalCenter: savingPage.verticalCenter
                anchors.horizontalCenter: savingPage.horizontalCenter
                label: qsTr("Saving...")
            }

        }

        Label {
            id: score
            text:  diffItem.diff + " \n" + qsTr("Level ") + "\n" + qsTr("Score ")  + "\n" + qsTr("Highscore ")
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
                        console.log("Tap")
                    }
                    else
                        if ( Math.abs(prevY-mouseY) > Math.abs(prevX-mouseX) )
                            if ( mouseY > prevY) {        // Swipe Down
                                if ( !multiSwipe.running )
                                    multiSwipe.start()
                                else {
                                    multiSwipe.stop()
                                    functions.instantDown()
                                    console.log("Double Down")
                                }

                            } else {                        // Swipe Up
                                functions.pause()
                                console.log("Up")
                            }
                        else
                            if ( mouseX > prevX) {        // Swipe Right
                                functions.right()
                                console.log("Right")
                            } else {                        // Swipe Left
                                functions.left()
                                console.log("Left")
                            }
                }
                Timer {
                    id: multiSwipe
                    running: false
                    interval: 300
                    onTriggered: {
                        functions.down()
                        console.log("Down")
                    }
                }
            }
        }
    }
}
