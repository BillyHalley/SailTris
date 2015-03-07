import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.sailtris.FileIO 1.0

Dialog {
    id: page
    property real difficulty
    property int dots
    property int ghostEnabled
    property int highscoreValue
    FileIO {
        id: fileIO
    }


    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge
            DialogHeader {
                title: qsTr("Settings")
            }
            Slider {
                id: slider
                width: parent.width
                minimumValue: 1
                maximumValue: 5
                stepSize: 1
                value: difficulty === 0.5 ? 5 : difficulty === 0.75 ? 4 : difficulty === 1 ? 3 : difficulty === 1.5 ? 2 : 1
                label: qsTr("Difficulty")
                valueText: {
                    if (value === 5)
                        qsTr("Very Hard")
                    else if (value === 4)
                        qsTr("Hard")
                    else if (value === 3)
                        qsTr("Normal")
                    else if (value === 2)
                        qsTr("Easy")
                    else
                        qsTr("Very Easy")
                }
                onValueChanged: {
                    difficulty = value === 5 ? 0.5 : value === 4 ? 0.75 : value === 3 ? 1 : value === 2 ? 1.5 : 2
                    highscoreValue = fileIO.read("highscore["+difficulty+"]")
                    fileIO.write("difficulty", difficulty)
                }
            }
            TextSwitch {
                id: dotSwitch
                automaticCheck: false
                checked: dots === 1 ? true : false
                text: checked ? qsTr("Squares") : qsTr("Dots")
                description: qsTr("Changes the shape of the blocks")
                onClicked: {
                    if (dots === 0) {
                        dots = 1
                        fileIO.write("dots", 1)
                    }
                    else {
                        dots = 0
                        fileIO.write("dots", 0)
                    }
                }
            }
            TextSwitch {
                id: ghostSwitch
                automaticCheck: false
                checked: ghostEnabled === 1 ? true : false
                text: checked ? qsTr("Ghost Enabled") : qsTr("Ghost Disabled")
                description: qsTr("Display a hint of where the block will fall")
                onClicked: {
                    if (ghostEnabled === 0) {
                        ghostEnabled = 1
                        fileIO.write("ghostEnabled", 1)
                    }
                    else {
                        ghostEnabled = 0
                        fileIO.write("ghostEnabled", 0)
                    }
                }
            }
        }
    }

}
