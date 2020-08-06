#pragma once

#include <QObject>
#include <QByteArray>
#include "UDPlink.h"
#include "../../../Mavlink/mavlink/ardupilotmega/mavlink.h"

class VehicleManager : public QObject 
{
    Q_OBJECT
public:

    explicit VehicleManager(QObject *parent = 0);

signals:

public slots:
    void processBytes(QByteArray bytes);

private:

    UDPlink*                _link;
};