#pragma once

#include <QObject>
#include <QDebug>
#include "../../../Mavlink/mavlink/ardupilotmega/mavlink.h"

class Vehicle : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(int gsm1    READ gsm1    NOTIFY gsm1changed)

    int gsm1() { return _gsm1; }

    explicit Vehicle(QObject *parent = 0);

    void set_mavid(int mavid);

    void initialize();

    bool initialized();

    void set_instance(int instance);

    int get_instance();

    int get_mavid();

    void process_message(mavlink_message_t msg);

signals:
    void gsm1changed();

public slots:

private:

    int _instancenumber = 0;
    bool _initialized = false;
    int _mavid = 0;
    int _gsm1 = 200;

};