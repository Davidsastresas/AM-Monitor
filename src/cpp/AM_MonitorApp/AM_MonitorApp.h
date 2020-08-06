#pragma once

#include <QGuiApplication>
#include <QTimer>
#include <QQmlApplicationEngine>
#include <QElapsedTimer>
// #include "../../../Mavlink/mavlink/ardupilotmega/mavlink.h"
#include "VehicleManager.h"

// #include "MAVLinkProtocol.h"

// #include "KmlController.h"

class AM_MonitorApp : public QGuiApplication
{
    Q_OBJECT
public:

    AM_MonitorApp(int &argc, char* argv[]);
    ~AM_MonitorApp();

    /// @brief Perform initialize which is common to both normal application running and unit tests.
    ///         Although public should only be called by main.
    void _initCommon();

    /// Shutdown the application object
    void _shutdown();

     /// Our own singleton
    static AM_MonitorApp*  _app;

private:

    QElapsedTimer           _msecsElapsedTime;

    VehicleManager*         _vehiclemanager;
};

/// @brief Returns the AM_MonitorApp object singleton.
AM_MonitorApp* qgcApp(void);
