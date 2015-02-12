import QtQuick 2.0
import Sailfish.Silica 1.0
import "pics"

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        ScrollDecorator { }
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
                text: qsTr("You gain 10 points for each completed line! Multiple lines combo gives you 100 bonus points for each line completed! And 1000 points when four lines are cleared!!\nEvery 1000 point the speed of the game will increase, to increase the challange!")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                textFormat: Text.RichText
                text: "<style>a:link { color: " + Theme.highlightColor +"; }</style>" + qsTr("Follow the developement on  <a href=Qt.openUrlExternally(\"https://openrepos.net/content/billyhalley/\")>OpenRepos.net</a>, and check Wharehouse for updates. ") + qsTr("This app is completely written by BillyHalley, if you like it, please consider making a small donation, i would really appreciate! Click on the pic below to donate :)")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Image {
                id: image
                anchors.horizontalCenter: column.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "pics/donation.gif"
            }
        }
    }
    MouseArea {
        width: image.width
        height: image.height
        x: image.x
        y: image.y
        onClicked: {
            console.log("Image Clicked")
            Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=VKAXABNCGPHM6")

        }
    }
}
