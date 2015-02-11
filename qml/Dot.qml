import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.private 1.0


GlassItem {
    id: dot
    width: Theme.paddingLarge*2
    height: width
    radius: 0.2
    falloffRadius: 0.25
    property int active: 0 // 0 = empty; 1 = active; 2 = inactive
}
