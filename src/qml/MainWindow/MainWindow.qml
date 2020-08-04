import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtLocation 5.6
import QtPositioning 5.6

Window {
    id:             mainWindow

    visible:        true
    width:          640
    height:         480

    color:          "#212329"

    Rectangle { 
        id:                 topBar

        anchors.left:       parent.left
        anchors.right:      parent.right
        height:             parent.height * 0.15

        color:              "#181A1D"

        border.width:       height * 0.01
        border.color:       "#36383E"

        RoundButton {
            id:                 settingsButton

            anchors.left:       parent.left
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            anchors.margins:    width * 0.1

            radius:             width * 0.1
            width:              parent.width * 0.1

            Rectangle {
                id:                 innerRectangleSettingsButton

                radius:             parent.radius
                anchors.fill:       parent

                color:              "#0E0F10"
            }
        }
    }
}
