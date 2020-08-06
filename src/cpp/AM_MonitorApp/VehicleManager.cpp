#include "VehicleManager.h"

VehicleManager::VehicleManager(QObject *parent) :
    QObject(parent)
{
    _link = new UDPlink();

    connect(_link, &UDPlink::readBytes, this, &VehicleManager::processBytes);
}

void VehicleManager::processBytes(QByteArray bytes) 
{
    mavlink_message_t msg;
    mavlink_status_t mavlink_status;

    for ( int i = 0; i < bytes.size(); i++ ) {
        if (mavlink_parse_char(MAVLINK_COMM_0, static_cast<uint8_t>(bytes.data()[i]), &msg,
                                   &mavlink_status)) {
        // call whatever and return
        } 
    }

    if ( msg.msgid == MAVLINK_MSG_ID_HEARTBEAT ) {
        qDebug() << "hearbeat";
    }
}