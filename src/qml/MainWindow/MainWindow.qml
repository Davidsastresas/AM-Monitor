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

    minimumHeight:                  150
    minimumWidth:                   500

    color:                          "#212329"

    property var buttonradius:      6
    property var toolbarmargin:     width * 0.015

    property bool isontop:          true

    function toggleontop() {
        if (isontop) {
            moveresize()
        } else if (!isontop) {
            stayontop()
        } else {
            moveresize()
        }
    }

    function stayontop() {
        mainWindow.flags = Qt.WindowStaysOnTopHint
    }

    function moveresize() {
        mainWindow.flags ^= Qt.WindowStaysOnTopHint
    }

    Button {
        id:                 flagsButton
        anchors.left:       parent.left
        anchors.top:        parent.top
        anchors.margins:    height * 0.2

        width:              height
        height:             topBar.height * 0.3

        z:                  topBar.z + 2

        onClicked:          mainWindow.toggleontop()

    }

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
            width:                  parent.width * 0.2

            Rectangle {
                id:                     innerRectangleSettingsButton

                radius:                 parent.radius
                anchors.fill:           parent

                color:                  "#0E0F10"
            }

            Text {
                anchors.centerIn:               parent
                // anchors.margins:            mainWindow.toolbarmargin

                text: "Ground"
                color: "white"
            }
        }

        // Ground status indicator
        Rectangle {
            id:                     sroundStatusRectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           settingsButton.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.3

            radius:                 mainWindow.buttonradius

            color:                  "#363E46"

            border.width:           width * 0.1
            border.color:           if (vehiclemanagerobject.glowvolt || vehiclemanagerobject.gcurrentlythrot) { return "darkred" }
                                    else if (vehiclemanagerobject.glowvolthasocurred || vehiclemanagerobject.ghasbeenthrot) { return "darkorange" }
                                    else { return "darkgreen" }

            Text {
                anchors.top:               parent.top
                anchors.horizontalCenter:  parent.horizontalCenter
                // anchors.margins:            mainWindow.toolbarmargin
                visible: vehiclemanagerobject.glowvolt

                text: "Undervolt Now"
                color: "white"
            }

            Text {
                anchors.bottom:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                // anchors.margins:            mainWindow.toolbarmargin
                visible: vehiclemanagerobject.glowvolthasocurred

                text: "Undervolt ocurred"
                color: "white"
            }

            Text {
                anchors.top:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                // anchors.margins:            mainWindow.toolbarmargin
                visible: vehiclemanagerobject.ghasbeenthrot

                text: "Throttled ocurred"
                color: "white"
            }

            Text {
                anchors.bottom:               parent.bottom
                anchors.horizontalCenter:  parent.horizontalCenter
                // anchors.margins:            mainWindow.toolbarmargin
                visible: vehiclemanagerobject.gcurrentlythrot

                text: "Throttled now"
                color: "white"
            }
        }

        Rectangle {
            id:                     gsm1Rectangle

            anchors.top:            parent.top
            anchors.bottom:         parent.bottom
            anchors.left:           sroundStatusRectangle.right
            anchors.margins:        mainWindow.toolbarmargin
            width:                  parent.width * 0.1

            radius:                 mainWindow.buttonradius

            color:                  "#363E46"
            border.width:           width * 0.1
            border.color:           "#53585B"

            Text {
                anchors.bottom:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: "GSM 1"
                color: "white"
            }

            Text {
                anchors.top:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: vehiclemanagerobject.ggsm1
                color: "white"
            }
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

            Text {
                anchors.bottom:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: "GSM 2"
                color: "white"
            }

            Text {
                anchors.top:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: vehiclemanagerobject.ggsm2
                color: "white"
            }

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

            Text {
                anchors.bottom:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: "GSM 3"
                color: "white"
            }

            Text {
                anchors.top:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: vehiclemanagerobject.ggsm3
                color: "white"
            }

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

            Text {
                anchors.bottom:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: "SBD"
                color: "white"
            }

            Text {
                anchors.top:               parent.verticalCenter
                anchors.horizontalCenter:  parent.horizontalCenter
                anchors.margins:            mainWindow.toolbarmargin

                text: vehiclemanagerobject.gsbd
                color: "white"
            }

        }
    }


    

    ListView {
        id:                             aircraftslistview

        anchors.top:                    topBar.bottom
        anchors.left:                   parent.left
        anchors.right:                  parent.right
        anchors.bottom:                 parent.bottom

        // --------------------------------------- aircraft 1

        Item {
                id:                         aircraft1
                height:                     topBar.height
                width:                      mainWindow.width
                anchors.left:               mainWindow.left
                anchors.right:              mainWindow.right
            // settings button 
            RoundButton {
                id:                     settingsButton1

                anchors.left:           parent.left
                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.margins:        mainWindow.toolbarmargin

                radius:                 mainWindow.buttonradius
                width:                  parent.width * 0.2

                Rectangle {
                    id:                     innerRectangleSettingsButton1

                    radius:                 parent.radius
                    anchors.fill:           parent

                    color:                  "#0E0F10"
                }

                Text {
                    anchors.centerIn:               parent
                    // anchors.margins:            mainWindow.toolbarmargin

                    text: "UAV 1"
                    color: "white"
                }
            }

            // Ground status indicator
            Rectangle {
                id:                     statusRectangle1

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           settingsButton1.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.3

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"

                border.width:           width * 0.1
                border.color:           if (vehiclemanagerobject.v1lowvolt || vehiclemanagerobject.v1currentlythrot) { return "darkred" }
                                        else if (vehiclemanagerobject.v1lowvolthasocurred || vehiclemanagerobject.v1hasbeenthrot) { return "darkorange" }
                                        else { return "darkgreen" }

                Text {
                    anchors.top:               parent.top
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v1lowvolt

                    text: "Undervolt Now"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v1lowvolthasocurred

                    text: "Undervolt ocurred"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v1hasbeenthrot

                    text: "Throttled ocurred"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.bottom
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v1currentlythrot

                    text: "Throttled now"
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm1Rectangle1

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           statusRectangle1.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 1"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v1gsm1
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm2Rectangle1

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm1Rectangle1.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 2"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v1gsm2
                    color: "white"
                }

            }

            Rectangle {
                id:                     gsm3Rectangle1

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm2Rectangle1.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 3"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v1gsm3
                    color: "white"
                }

            }

            Rectangle {
                id:                     sbdRectangle1

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm3Rectangle1.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "SBD"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v1sbd
                    color: "white"
                }
            }
        }   

        // -------------------------------------------------UAV 2 
    
        Item {
                id:                         aircraft2
                height:                     topBar.height
                width:                      mainWindow.width
                anchors.left:               mainWindow.left
                anchors.right:              mainWindow.right
                anchors.top:                aircraft1.bottom
            // settings button 
            RoundButton {
                id:                     settingsButton2

                anchors.left:           parent.left
                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.margins:        mainWindow.toolbarmargin

                radius:                 mainWindow.buttonradius
                width:                  parent.width * 0.2

                Rectangle {
                    id:                     innerRectangleSettingsButton2

                    radius:                 parent.radius
                    anchors.fill:           parent

                    color:                  "#0E0F10"
                }

                Text {
                    anchors.centerIn:               parent
                    // anchors.margins:            mainWindow.toolbarmargin

                    text: "UAV 2"
                    color: "white"
                }
            }

            // Ground status indicator
            Rectangle {
                id:                     statusRectangle2

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           settingsButton2.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.3

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"

                border.width:           width * 0.1
                border.color:           if (vehiclemanagerobject.v2lowvolt || vehiclemanagerobject.v2currentlythrot) { return "darkred" }
                                        else if (vehiclemanagerobject.v2lowvolthasocurred || vehiclemanagerobject.v2hasbeenthrot) { return "darkorange" }
                                        else { return "darkgreen" }

                Text {
                    anchors.top:               parent.top
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v2lowvolt

                    text: "Undervolt Now"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v2lowvolthasocurred

                    text: "Undervolt ocurred"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v2hasbeenthrot

                    text: "Throttled ocurred"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.bottom
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v2currentlythrot

                    text: "Throttled now"
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm1Rectangle2

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           statusRectangle2.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 1"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v2gsm1
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm2Rectangle2

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm1Rectangle2.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 2"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v2gsm2
                    color: "white"
                }

            }

            Rectangle {
                id:                     gsm3Rectangle2

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm2Rectangle2.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 3"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v2gsm3
                    color: "white"
                }

            }

            Rectangle {
                id:                     sbdRectangle2

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm3Rectangle2.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "SBD"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v2sbd
                    color: "white"
                }
            }
        }   

        // -----------------------------------------------UAV 3
    
        Item {
                id:                         aircraft3
                height:                     topBar.height
                width:                      mainWindow.width
                anchors.left:               mainWindow.left
                anchors.right:              mainWindow.right
                anchors.top:                aircraft2.bottom
            // settings button 
            RoundButton {
                id:                     settingsButton3

                anchors.left:           parent.left
                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.margins:        mainWindow.toolbarmargin

                radius:                 mainWindow.buttonradius
                width:                  parent.width * 0.2

                Rectangle {
                    id:                     innerRectangleSettingsButton3

                    radius:                 parent.radius
                    anchors.fill:           parent

                    color:                  "#0E0F10"
                }

                Text {
                    anchors.centerIn:               parent
                    // anchors.margins:            mainWindow.toolbarmargin

                    text: "UAV 3"
                    color: "white"
                }
            }

            // Ground status indicator
            Rectangle {
                id:                     statusRectangle3

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           settingsButton3.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.3

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"

                border.width:           width * 0.1
                border.color:           if (vehiclemanagerobject.v3lowvolt || vehiclemanagerobject.v3currentlythrot) { return "darkred" }
                                        else if (vehiclemanagerobject.v3lowvolthasocurred || vehiclemanagerobject.v3hasbeenthrot) { return "darkorange" }
                                        else { return "darkgreen" }

                Text {
                    anchors.top:               parent.top
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v3lowvolt

                    text: "Undervolt Now"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v3lowvolthasocurred

                    text: "Undervolt ocurred"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v3hasbeenthrot

                    text: "Throttled ocurred"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.bottom
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v3currentlythrot

                    text: "Throttled now"
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm1Rectangle3

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           statusRectangle3.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 1"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v3gsm1
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm2Rectangle3

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm1Rectangle3.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 2"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v3gsm2
                    color: "white"
                }

            }

            Rectangle {
                id:                     gsm3Rectangle3

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm2Rectangle3.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 3"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v3gsm3
                    color: "white"
                }

            }

            Rectangle {
                id:                     sbdRectangle3

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm3Rectangle3.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "SBD"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v3sbd
                    color: "white"
                }
            }
        }   

        // -------------------------------------------------------UAV 4
    
        Item {
                id:                         aircraft4
                height:                     topBar.height
                width:                      mainWindow.width
                anchors.left:               mainWindow.left
                anchors.right:              mainWindow.right
                anchors.top:                aircraft3.bottom
            // settings button 
            RoundButton {
                id:                     settingsButton4

                anchors.left:           parent.left
                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.margins:        mainWindow.toolbarmargin

                radius:                 mainWindow.buttonradius
                width:                  parent.width * 0.2

                Rectangle {
                    id:                     innerRectangleSettingsButton4

                    radius:                 parent.radius
                    anchors.fill:           parent

                    color:                  "#0E0F10"
                }

                Text {
                    anchors.centerIn:               parent
                    // anchors.margins:            mainWindow.toolbarmargin

                    text: "UAV 4"
                    color: "white"
                }
            }

            // Ground status indicator
            Rectangle {
                id:                     statusRectangle4

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           settingsButton4.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.3

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"

                border.width:           width * 0.1
                border.color:           if (vehiclemanagerobject.v4lowvolt || vehiclemanagerobject.v4currentlythrot) { return "darkred" }
                                        else if (vehiclemanagerobject.v4lowvolthasocurred || vehiclemanagerobject.v4hasbeenthrot) { return "darkorange" }
                                        else { return "darkgreen" }

                Text {
                    anchors.top:               parent.top
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v4lowvolt

                    text: "Undervolt Now"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v4lowvolthasocurred

                    text: "Undervolt ocurred"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v4hasbeenthrot

                    text: "Throttled ocurred"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.bottom
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v4currentlythrot

                    text: "Throttled now"
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm1Rectangle4

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           statusRectangle4.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 1"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v4gsm1
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm2Rectangle4

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm1Rectangle4.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 2"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v4gsm2
                    color: "white"
                }

            }

            Rectangle {
                id:                     gsm3Rectangle4

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm2Rectangle4.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 3"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v4gsm3
                    color: "white"
                }

            }

            Rectangle {
                id:                     sbdRectangle4

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm3Rectangle4.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "SBD"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v4sbd
                    color: "white"
                }
            }
        }   

        // -------------------------------UAV 5
    
        Item {
                id:                         aircraft5
                height:                     topBar.height
                width:                      mainWindow.width
                anchors.left:               mainWindow.left
                anchors.right:              mainWindow.right
                anchors.top:                aircraft4.bottom
            // settings button 
            RoundButton {
                id:                     settingsButton5

                anchors.left:           parent.left
                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.margins:        mainWindow.toolbarmargin

                radius:                 mainWindow.buttonradius
                width:                  parent.width * 0.2

                Rectangle {
                    id:                     innerRectangleSettingsButton5

                    radius:                 parent.radius
                    anchors.fill:           parent

                    color:                  "#0E0F10"
                }

                Text {
                    anchors.centerIn:               parent
                    // anchors.margins:            mainWindow.toolbarmargin

                    text: "UAV 5"
                    color: "white"
                }
            }

            // Ground status indicator
            Rectangle {
                id:                     statusRectangle5

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           settingsButton5.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.3

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"

                border.width:           width * 0.1
                border.color:           if (vehiclemanagerobject.v5lowvolt || vehiclemanagerobject.v5currentlythrot) { return "darkred" }
                                        else if (vehiclemanagerobject.v5lowvolthasocurred || vehiclemanagerobject.v5hasbeenthrot) { return "darkorange" }
                                        else { return "darkgreen" }

                Text {
                    anchors.top:               parent.top
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v5lowvolt

                    text: "Undervolt Now"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v5lowvolthasocurred

                    text: "Undervolt ocurred"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v5hasbeenthrot

                    text: "Throttled ocurred"
                    color: "white"
                }

                Text {
                    anchors.bottom:               parent.bottom
                    anchors.horizontalCenter:  parent.horizontalCenter
                    // anchors.margins:            mainWindow.toolbarmargin
                    visible: vehiclemanagerobject.v5currentlythrot

                    text: "Throttled now"
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm1Rectangle5

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           statusRectangle5.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 1"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v5gsm1
                    color: "white"
                }
            }

            Rectangle {
                id:                     gsm2Rectangle5

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm1Rectangle5.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 2"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v5gsm2
                    color: "white"
                }

            }

            Rectangle {
                id:                     gsm3Rectangle5

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm2Rectangle5.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "GSM 3"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v5gsm3
                    color: "white"
                }

            }

            Rectangle {
                id:                     sbdRectangle5

                anchors.top:            parent.top
                anchors.bottom:         parent.bottom
                anchors.left:           gsm3Rectangle5.right
                anchors.margins:        mainWindow.toolbarmargin
                width:                  parent.width * 0.1

                radius:                 mainWindow.buttonradius

                color:                  "#363E46"
                border.width:           width * 0.1
                border.color:           "#53585B"

                Text {
                    anchors.bottom:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: "SBD"
                    color: "white"
                }

                Text {
                    anchors.top:               parent.verticalCenter
                    anchors.horizontalCenter:  parent.horizontalCenter
                    anchors.margins:            mainWindow.toolbarmargin

                    text: vehiclemanagerobject.v5sbd
                    color: "white"
                }
            }
        }   
    
    }
}
