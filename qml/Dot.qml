import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.private 1.0



GlassItem {
    property int active: 0 // 0 = empty; 1 = active; 2 = inactive
    id: dot
    width: Theme.paddingLarge*2
    height: width
    radius: page.dots ? 0.2 : 0
    falloffRadius: page.dots ? 0.25 : 2
    color: color
}
