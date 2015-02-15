import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    SilicaFlickable {
        id: flickable
        anchors.fill: page
        contentHeight: column.height
        Column {
            id: column
            width: parent.width - Theme.paddingLarge*2
            spacing: 20
            anchors {
                left: parent.left
                leftMargin: Theme.paddingLarge
                //top: page.top
                //topMargin: Theme.paddingLarge
            }
            PageHeader { title: qsTr("SailTris") }

            Label {
                width: parent.width
                text: qsTr("Classic tetris game, in SailfishOS style!")
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("To play select 'New Game' in pulley menu!\nSwipe Left, Right or Down to move the block, click on the screen to Rotate it.\nSwipe Up to Pause the Game, to resume Pull Down to show the Pulley Menu")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("You gain 1 point for each step in the game and 10 points for each completed line! Multiple lines combo gives you 100 bonus points for each line completed! And 1000 points when four lines are cleared!!\nEvery 1000 point you proceed to the next level, and the speed is increased!")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }

            Row {
                spacing: Theme.paddingLarge
                Label {
                    id: imageText
                    width: column.width/2 - Theme.paddingMedium
                    textFormat: Text.RichText
                    text: "<style>a:link { color: " + Theme.highlightColor + "; }</style>" + qsTr("Follow the developement on ") + "<a href=https://openrepos.net/content/billyhalley/sailtris>OpenRepos.net</a>" + qsTr(" and check Warehouse for updates. This app is completely written by BillyHalley, if you like it, please consider making a small donation, I would really appreciate! Click on the pic to donate :)")
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeSmall - 6
                    horizontalAlignment: Text.AlignJustify
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally("https://openrepos.net/content/billyhalley/sailtris")
                }
                Item {
                    height: imageText.height
                    width: imageText.width
                    Image {
                        id: image
                        height: imageText.height
                        width: imageText.width
                        fillMode: Image.PreserveAspectFit
                        source: "Donation.png"
                    }
                    MouseArea {
                        width: image.width
                        height: image.height
                        anchors.fill: image
                        onClicked: {
                            console.log("Image Clicked")
                            Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=VKAXABNCGPHM6")
                        }
                    }
                }
            }

        }

        VerticalScrollDecorator {flickable: flickable }

    }

}
