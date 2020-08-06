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


    int get_mavid();

    void process_message(mavlink_message_t msg);

signals:
    void gsm1changed();

public slots:

private:

    int _mavid = 0;
    int _gsm1 = 200;

};