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
    qDebug() << "Vehicle process msg: " << msg.msgid; 
    qDebug() << "sysid: " << msg.sysid;
}