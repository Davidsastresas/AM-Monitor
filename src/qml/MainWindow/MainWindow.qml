import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtLocation 5.6
import QtPositioning 5.6

Window {
    id:                             mainWindow

    visible:                        true
    width:                          640
    height:                         480

    minimumHeight:                  200
    minimumWidth:                   500

    color:                          "#212329"

    property var buttonradius:      6
    property var toolbarmargin:     width * 0.015
    Rectangle { 
        id:                 topBar

        anchors.left:       parent.left
        anchors.right:      parent.right
        height:             parent.width * 0.15

        color:              "#181A1D"

        border.width:       height * 0.01
        border.color:       "#36383E"

        // settings button 
        RoundButton {
            id:                     settingsButton

            anchors.left:           parent.left
            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.margins:        mainWindow.toolbarmargin

            radius:                 mainWindow.buttonradius
            width:                  parent.width * 0.1

            Rectangle {
                id:                     innerRectangleSettingsButton

                radius:                 parent.radius
                anchors.fill:           parent

                color:                  "#0E0F10"
            }
        }

        // Ground Connected indicator
        Rectangle {
            id:                     groundConnectedRectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           settingsButton.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.1
            radius:                 mainWindow.buttonradius

            color:                  "red"

            border.width:           width * 0.1
            border.color:           "darkred"
        }

        // Ground status indicator
        Rectangle {
            id:                     groundStatusRectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           groundConnectedRectangle.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.15

            radius:                 mainWindow.buttonradius

            color:                  "green"

            border.width:           width * 0.1
            border.color:           "darkgreen"
        }

        Rectangle {
            id:                     rfdRectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           groundStatusRectangle.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.1

            radius:                 mainWindow.buttonradius

            color:                  "#363E46"
            border.width:           width * 0.1
            border.color:           "#53585B"

        }
        Rectangle {
            id:                     gsm1Rectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           rfdRectangle.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.1

            radius:                 mainWindow.buttonradius

            color:                  "#363E46"
            border.width:           width * 0.1
            border.color:           "#53585B"

        }

        Rectangle {
            id:                     gsm2Rectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           gsm1Rectangle.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.1

            radius:                 mainWindow.buttonradius

            color:                  "#363E46"
            border.width:           width * 0.1
            border.color:           "#53585B"

        }

        Rectangle {
            id:                     gsm3Rectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           gsm2Rectangle.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.1

            radius:                 mainWindow.buttonradius

            color:                  "#363E46"
            border.width:           width * 0.1
            border.color:           "#53585B"

        }

        Rectangle {
            id:                     sbdRectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           gsm3Rectangle.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.1

            radius:                 mainWindow.buttonradius

            color:                  "#363E46"
            border.width:           width * 0.1
            border.color:           "#53585B"

        }
    }
}
