#include "Vehicle.h"

Vehicle::Vehicle(QObject *parent) : 
    QObject(parent)
{

}

void Vehicle::set_mavid(int mavid) {
    _mavid = mavid;
}

int Vehicle::get_mavid() {
    return _mavid;
}

void Vehicle::process_message(mavlink_message_t msg) 
{
    _gsm1 = mavlink_msg_radio_status_get_rssi(&msg);
    qDebug() << "Vehicle process msg: " << msg.msgid; 
    qDebug() << "sysid: " << msg.sysid;
}

void Vehicle::initialize() {
    _initialized = true;
}

bool Vehicle::initialized() {
    return _initialized;
}

int Vehicle::get_instance() {
    return _instancenumber;
}

void Vehicle::set_instance(int instance) {
    _instancenumber = instance;
}