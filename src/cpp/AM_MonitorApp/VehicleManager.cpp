#include "VehicleManager.h"

VehicleManager::VehicleManager(QObject *parent) :
    QObject(parent)
{
    _link = new UDPlink(parent);

    connect(_link, &UDPlink::readBytes, this, &VehicleManager::processBytes);
    connect(_link, &UDPlink::connected, this, &VehicleManager::linkconnected);
    connect(_link, &UDPlink::disconnected, this, &VehicleManager::linkdisconnected);
}

void VehicleManager::processBytes(QByteArray bytes) 
{
    mavlink_message_t msg;
    mavlink_status_t mavlink_status;

    for ( int i = 0; i < bytes.size(); i++ ) {
        if (mavlink_parse_char(MAVLINK_COMM_0, static_cast<uint8_t>(bytes.data()[i]), &msg,
                                   &mavlink_status)) {

            if ( msg.msgid == MAVLINK_MSG_ID_RADIO_STATUS ) {
                check_new_vehicle(msg.sysid);
                if ( _vehiclesmap.contains(msg.sysid) ) {
                    if ( _vehiclesmap[msg.sysid]->initialized() ) {
                        process_msg(msg);
                    }
                }
            }
        } 
    }
}

void VehicleManager::check_new_vehicle(int mavid) 
{
    if ( !_vehiclesmap.contains(mavid) ) {
        if ( mavid > 0 && mavid < 10 ) {

            Vehicle* vehicle = new Vehicle(this);
            vehicle->set_mavid(mavid);
            vehicle->initialize();
            vehicle->set_instance(_activeVehicles);
            
            _vehiclesmap.insert(mavid, vehicle);
            _activeVehicles++;
            
            // qDebug() << "new vehicle: " << mavid;
            qDebug() << "new vehicle inserted: " << _vehiclesmap[mavid]->get_mavid();
        }

        if ( mavid == 249 ) {
            Vehicle* vehicle = new Vehicle(this);
            vehicle->set_mavid(mavid);
            vehicle->initialize();
            vehicle->set_instance(0);
            
            _vehiclesmap.insert(mavid, vehicle);
            
            // qDebug() << "new vehicle: " << mavid;
            qDebug() << "new groundpi inserted: " << _vehiclesmap[mavid]->get_mavid();
        }
    }
}

int VehicleManager::vehicle_index_by_mavid(int mavid) 
{
    if ( _vehiclesmap.contains(mavid) ) {
        if ( _vehiclesmap[mavid]->initialized() ) {
            return _vehiclesmap[mavid]->get_instance();
        }
    }

    return 0;
}

void VehicleManager::process_msg(mavlink_message_t &msg) 
{
    // encode link_status on radio_status as follows
    //
    // rxerros - sbd rssi
    // fixed - not used
    // rssi - gsm 1 rssi
    // remrsssi - gsm 2 rssi
    // txbuf - gsm 3 rssi
    // noise - comp bitmask
    // remnoise - telemetry bitmask
    // 
    // compid is mav_id plus 10

    // get telemetry_bitmask, 
    //
    // bit 1 rfd active
    // bit 2 gsm active
    // bit 3 sbd active
    // bit 4 gsm1 active
    // bit 5 gsm2 active
    // bit 6 gsm3 active
    // bit 7,8 unused

    switch (vehicle_index_by_mavid(msg.sysid)) {
        case 0 : {
            _ggsm1 = mavlink_msg_radio_status_get_rssi(&msg); 
            _ggsm2 = mavlink_msg_radio_status_get_remrssi(&msg); 
            _ggsm3 = mavlink_msg_radio_status_get_txbuf(&msg);
            _gsbd = mavlink_msg_radio_status_get_rxerrors(&msg);
            _grfd = 0;

            uint8_t telembitmask = mavlink_msg_radio_status_get_remnoise(&msg);
            
            if ( telembitmask & (1 << 0) ) 
                _grfdactive = true;
            if ( telembitmask & (1 << 1) ) 
                _ggsmactive = true;
            if ( telembitmask & (1 << 2) ) 
                _gsbdactive = true;
            if ( telembitmask & (1 << 3) ) 
                _ggsmused = 1;
            if ( telembitmask & (1 << 4) ) 
                _ggsmused = 2;
            if ( telembitmask & (1 << 5) ) 
                _ggsmused = 3;

            uint8_t sysbitmask = mavlink_msg_radio_status_get_noise(&msg);

            if ( sysbitmask == 255 ) {
                _glowvolt = false;
                _gcurrentlythrot = false;
                _glowvolthasocurred = false;
                _ghasbeenthrot = false;

                break;
            }

            if ( sysbitmask & (1 << 0) ) 
                _glowvolt = true;
            else
                _glowvolt = false;
            if ( sysbitmask & (1 << 2) ) 
                _gcurrentlythrot = true;
            else
                _gcurrentlythrot = false;
            if ( sysbitmask & (1 << 4) ) 
                _glowvolthasocurred = true;
            else
                _glowvolthasocurred = false;
            if ( sysbitmask & (1 << 6) ) 
                _ghasbeenthrot = true;
            else
                _ghasbeenthrot = false;
            break;
        }

        case 1 : {
            _v1mavid = msg.sysid;
            _v1gsm1 = mavlink_msg_radio_status_get_rssi(&msg); 
            _v1gsm2 = mavlink_msg_radio_status_get_remrssi(&msg); 
            _v1gsm3 = mavlink_msg_radio_status_get_txbuf(&msg);
            _v1sbd = mavlink_msg_radio_status_get_rxerrors(&msg);
            _v1rfd = 0;

            uint8_t telembitmask = mavlink_msg_radio_status_get_remnoise(&msg);
            
            if ( telembitmask & (1 << 0) ) 
                _v1rfdactive = true;
            if ( telembitmask & (1 << 1) ) 
                _v1gsmactive = true;
            if ( telembitmask & (1 << 2) ) 
                _v1sbdactive = true;
            if ( telembitmask & (1 << 3) ) 
                _v1gsmused = 1;
            if ( telembitmask & (1 << 4) ) 
                _v1gsmused = 2;
            if ( telembitmask & (1 << 5) ) 
                _v1gsmused = 3;

            uint8_t sysbitmask = mavlink_msg_radio_status_get_noise(&msg);

            if ( sysbitmask == 255 ) {
                _v1lowvolt = false;
                _v1currentlythrot = false;
                _v1lowvolthasocurred = false;
                _v1hasbeenthrot = false;

                break;
            }

            if ( sysbitmask & (1 << 0) ) 
                _v1lowvolt = true;
            else
                _v1lowvolt = false;
            if ( sysbitmask & (1 << 2) ) 
                _v1currentlythrot = true;
            else
                _v1currentlythrot = false;
            if ( sysbitmask & (1 << 4) ) 
                _v1lowvolthasocurred = true;
            else
                _v1lowvolthasocurred = false;
            if ( sysbitmask & (1 << 6) ) 
                _v1hasbeenthrot = true;
            else
                _v1hasbeenthrot = false;
            break;
        }

        case 2 : {
            _v2mavid = msg.sysid;
            _v2gsm1 = mavlink_msg_radio_status_get_rssi(&msg); 
            _v2gsm2 = mavlink_msg_radio_status_get_remrssi(&msg); 
            _v2gsm3 = mavlink_msg_radio_status_get_txbuf(&msg);
            _v2sbd = mavlink_msg_radio_status_get_rxerrors(&msg);
            _v2rfd = 0;

            uint8_t telembitmask = mavlink_msg_radio_status_get_remnoise(&msg);
            
            if ( telembitmask & (1 << 0) ) 
                _v2rfdactive = true;
            if ( telembitmask & (1 << 1) ) 
                _v2gsmactive = true;
            if ( telembitmask & (1 << 2) ) 
                _v2sbdactive = true;
            if ( telembitmask & (1 << 3) ) 
                _v2gsmused = 1;
            if ( telembitmask & (1 << 4) ) 
                _v2gsmused = 2;
            if ( telembitmask & (1 << 5) ) 
                _v2gsmused = 3;

            uint8_t sysbitmask = mavlink_msg_radio_status_get_noise(&msg);

            if ( sysbitmask == 255 ) {
                _v2lowvolt = false;
                _v2currentlythrot = false;
                _v2lowvolthasocurred = false;
                _v2hasbeenthrot = false;

                break;
            }

            if ( sysbitmask & (1 << 0) ) 
                _v2lowvolt = true;
            else
                _v2lowvolt = false;
            if ( sysbitmask & (1 << 2) ) 
                _v2currentlythrot = true;
            else
                _v2currentlythrot = false;
            if ( sysbitmask & (1 << 4) ) 
                _v2lowvolthasocurred = true;
            else
                _v2lowvolthasocurred = false;
            if ( sysbitmask & (1 << 6) ) 
                _v2hasbeenthrot = true;
            else
                _v2hasbeenthrot = false;
            break;
        }

        case 3 : {
            _v3mavid = msg.sysid;
            _v3gsm1 = mavlink_msg_radio_status_get_rssi(&msg); 
            _v3gsm2 = mavlink_msg_radio_status_get_remrssi(&msg); 
            _v3gsm3 = mavlink_msg_radio_status_get_txbuf(&msg);
            _v3sbd = mavlink_msg_radio_status_get_rxerrors(&msg);
            _v3rfd = 0;

            uint8_t telembitmask = mavlink_msg_radio_status_get_remnoise(&msg);
            
            if ( telembitmask & (1 << 0) ) 
                _v3rfdactive = true;
            if ( telembitmask & (1 << 1) ) 
                _v3gsmactive = true;
            if ( telembitmask & (1 << 2) ) 
                _v3sbdactive = true;
            if ( telembitmask & (1 << 3) ) 
                _v3gsmused = 1;
            if ( telembitmask & (1 << 4) ) 
                _v3gsmused = 2;
            if ( telembitmask & (1 << 5) ) 
                _v3gsmused = 3;

            uint8_t sysbitmask = mavlink_msg_radio_status_get_noise(&msg);

            if ( sysbitmask == 255 ) {
                _v3lowvolt = false;
                _v3currentlythrot = false;
                _v3lowvolthasocurred = false;
                _v3hasbeenthrot = false;

                break;
            }

            if ( sysbitmask & (1 << 0) ) 
                _v3lowvolt = true;
            else
                _v3lowvolt = false;
            if ( sysbitmask & (1 << 2) ) 
                _v3currentlythrot = true;
            else
                _v3currentlythrot = false;
            if ( sysbitmask & (1 << 4) ) 
                _v3lowvolthasocurred = true;
            else
                _v3lowvolthasocurred = false;
            if ( sysbitmask & (1 << 6) ) 
                _v3hasbeenthrot = true;
            else
                _v3hasbeenthrot = false;
            break;
        }

        case 4 : {
            _v4mavid = msg.sysid;
            _v4gsm1 = mavlink_msg_radio_status_get_rssi(&msg); 
            _v4gsm2 = mavlink_msg_radio_status_get_remrssi(&msg); 
            _v4gsm3 = mavlink_msg_radio_status_get_txbuf(&msg);
            _v4sbd = mavlink_msg_radio_status_get_rxerrors(&msg);
            _v4rfd = 0;

            uint8_t telembitmask = mavlink_msg_radio_status_get_remnoise(&msg);
            
            if ( telembitmask & (1 << 0) ) 
                _v4rfdactive = true;
            if ( telembitmask & (1 << 1) ) 
                _v4gsmactive = true;
            if ( telembitmask & (1 << 2) ) 
                _v4sbdactive = true;
            if ( telembitmask & (1 << 3) ) 
                _v4gsmused = 1;
            if ( telembitmask & (1 << 4) ) 
                _v4gsmused = 2;
            if ( telembitmask & (1 << 5) ) 
                _v4gsmused = 3;

            uint8_t sysbitmask = mavlink_msg_radio_status_get_noise(&msg);

            if ( sysbitmask == 255 ) {
                _v4lowvolt = false;
                _v4currentlythrot = false;
                _v4lowvolthasocurred = false;
                _v4hasbeenthrot = false;

                break;
            }

            if ( sysbitmask & (1 << 0) ) 
                _v4lowvolt = true;
            else
                _v4lowvolt = false;
            if ( sysbitmask & (1 << 2) ) 
                _v4currentlythrot = true;
            else
                _v4currentlythrot = false;
            if ( sysbitmask & (1 << 4) ) 
                _v4lowvolthasocurred = true;
            else
                _v4lowvolthasocurred = false;
            if ( sysbitmask & (1 << 6) ) 
                _v4hasbeenthrot = true;
            else
                _v4hasbeenthrot = false;
            break;
        }

        case 5 : {
            _v5mavid = msg.sysid;
            _v5gsm1 = mavlink_msg_radio_status_get_rssi(&msg); 
            _v5gsm2 = mavlink_msg_radio_status_get_remrssi(&msg); 
            _v5gsm3 = mavlink_msg_radio_status_get_txbuf(&msg);
            _v5sbd = mavlink_msg_radio_status_get_rxerrors(&msg);
            _v5rfd = 0;

            uint8_t telembitmask = mavlink_msg_radio_status_get_remnoise(&msg);
            
            if ( telembitmask & (1 << 0) ) 
                _v5rfdactive = true;
            if ( telembitmask & (1 << 1) ) 
                _v5gsmactive = true;
            if ( telembitmask & (1 << 2) ) 
                _v5sbdactive = true;
            if ( telembitmask & (1 << 3) ) 
                _v5gsmused = 1;
            if ( telembitmask & (1 << 4) ) 
                _v5gsmused = 2;
            if ( telembitmask & (1 << 5) ) 
                _v5gsmused = 3;

            uint8_t sysbitmask = mavlink_msg_radio_status_get_noise(&msg);

            if ( sysbitmask == 255 ) {
                _v5lowvolt = false;
                _v5currentlythrot = false;
                _v5lowvolthasocurred = false;
                _v5hasbeenthrot = false;

                break;
            }

            if ( sysbitmask & (1 << 0) ) 
                _v5lowvolt = true;
            else
                _v5lowvolt = false;
            if ( sysbitmask & (1 << 2) ) 
                _v5currentlythrot = true;
            else
                _v5currentlythrot = false;
            if ( sysbitmask & (1 << 4) ) 
                _v5lowvolthasocurred = true;
            else
                _v5lowvolthasocurred = false;
            if ( sysbitmask & (1 << 6) ) 
                _v5hasbeenthrot = true;
            else
                _v5hasbeenthrot = false;
            break;
        }

        default :
            break;
    }
    emit telemchanged();
}