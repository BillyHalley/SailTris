import QtQuick 2.0
import Sailfish.Silica 1.0

GlassItem {
    property int active: 0 // 0 = empty; 1 = active; 2 = inactive
    property bool ghost: false
    property bool glowing: false
    id: dot
    width: Theme.paddingLarge*2
    height: width
    radius: dots === 0 ? 0.2 : 0
    falloffRadius: dots === 0 ? 0.25 : 2
    color: Theme.secondaryColor
    opacity: 0.1
    Timer {
        property bool up
        id: glowingTimer
        running: glowing
        repeat: true
        interval: 30
        onTriggered: {
            if (opacity === 1){
                up = false
            } else if (opacity < 0.5) {
                up = true
            }
            if (up)
                opacity += 0.05
            else
                opacity -= 0.05
        }
    }
}
