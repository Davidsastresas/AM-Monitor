import QtQuick 2.15
import QtQuick.Window 2.15
import QtLocation 5.6
import QtPositioning 5.6

Window {
    visible: true
    width: 640
    height: 480

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id:             mainMap
        anchors.fill:   parent
        plugin:         mapPlugin
    }
}
