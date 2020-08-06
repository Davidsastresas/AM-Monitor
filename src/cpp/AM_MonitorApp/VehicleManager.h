#pragma once

#include <QObject>
#include <QByteArray>
#include <QMap>
#include "UDPlink.h"
#include "Vehicle.h"
#include "../../../Mavlink/mavlink/ardupilotmega/mavlink.h"

class VehicleManager : public QObject 
{
    Q_OBJECT
public:
    Q_PROPERTY(int example  READ example   NOTIFY examplechanged);

    int example() { return _example; }

    explicit VehicleManager(QObject *parent = 0);

signals:
    void examplechanged();

public slots:
    void processBytes(QByteArray bytes);

private:

    int _example = 0;

    void check_new_vehicle(int mavid);

    UDPlink*                _link = nullptr;

    QMap<int, Vehicle*>     _vehiclesmap;
    int                     _activeVehicles = 0;
};