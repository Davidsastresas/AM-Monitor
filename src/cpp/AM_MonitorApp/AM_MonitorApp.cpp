#include "AM_MonitorApp.h"

AM_MonitorApp* AM_MonitorApp::_app = nullptr;

AM_MonitorApp::AM_MonitorApp(int &argc, char* argv[])
    : QGuiApplication          (argc, argv)
{
    _app = this;
    _msecsElapsedTime.start();
}

AM_MonitorApp::~AM_MonitorApp()
{
    // Place shutdown code in _shutdown
    _app = nullptr;
}

void AM_MonitorApp::_shutdown()
{
    // Close out all Qml before we delete toolbox. This way we don't get all sorts of null reference complaints from Qml.
    // delete _qmlAppEngine;

    // delete _toolbox;
}

void AM_MonitorApp::_initCommon()
{
    // start objects here
    // _vehiclemanager = new VehicleManager();

    // now connect signals

}

AM_MonitorApp* am_monitorapp(void)
{
    return AM_MonitorApp::_app;
}