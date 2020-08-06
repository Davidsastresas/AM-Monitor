#include "VehicleManager.h"

VehicleManager::VehicleManager(QObject *parent) :
    QObject(parent)
{
    _link = new UDPlink(parent);

    connect(_link, &UDPlink::readBytes, this, &VehicleManager::processBytes);
}

void VehicleManager::processBytes(QByteArray bytes) 
{
    mavlink_message_t msg;
    mavlink_status_t mavlink_status;

    for ( int i = 0; i < bytes.size(); i++ ) {
        if (mavlink_parse_char(MAVLINK_COMM_0, static_cast<uint8_t>(bytes.data()[i]), &msg,
                                   &mavlink_status)) {
            _example = msg.sysid;
            emit examplechanged();

            if ( msg.msgid == MAVLINK_MSG_ID_RADIO_STATUS ) {
                check_new_vehicle(msg.sysid);
                if ( _vehiclesmap.contains(msg.sysid) ) {
                    _vehiclesmap[msg.sysid]->process_message(msg);
                }
            }
        } 
    }
}

void VehicleManager::check_new_vehicle(int mavid) 
{
    if ( !_vehiclesmap.contains(mavid) ) {
        if ( ( mavid > 0 && mavid < 10 ) || mavid == 249 ) {

            Vehicle* vehicle = new Vehicle(this);
            vehicle->set_mavid(mavid);
            
            _vehiclesmap.insert(mavid, vehicle);
            _activeVehicles++;
            
            // qDebug() << "new vehicle: " << mavid;
            qDebug() << "new vehicle inserted: " << _vehiclesmap[mavid]->get_mavid();
        }
    }
}