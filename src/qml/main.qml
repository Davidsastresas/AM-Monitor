import QtQuick 2.15
import MainWindow 1.0

MainWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("AM-Monitor")
    
    // all flags must be set at once! Check docs for
    // al the possibilities, some of them interesting 
    
    flags: Qt.WindowStaysOnTopHint
    // flags: Qt.FramelessWindowHint	
}
