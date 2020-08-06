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
    explicit VehicleManager(QObject *parent = 0);

    Q_PROPERTY(int ggsmused  READ ggsmused   NOTIFY telemchanged);
    Q_PROPERTY(int ggsm1  READ ggsm1   NOTIFY telemchanged);
    Q_PROPERTY(int ggsm2  READ ggsm2   NOTIFY telemchanged);
    Q_PROPERTY(int ggsm3  READ ggsm3   NOTIFY telemchanged);
    Q_PROPERTY(int gsbd  READ gsbd   NOTIFY telemchanged);
    Q_PROPERTY(int grfd  READ grfd   NOTIFY telemchanged);
    Q_PROPERTY(bool grfdactive  READ grfdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool ggsmactive  READ ggsmactive   NOTIFY telemchanged);
    Q_PROPERTY(bool gsbdactive  READ gsbdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool gcurrentlythrot  READ gcurrentlythrot   NOTIFY telemchanged);
    Q_PROPERTY(bool ghasbeenthrot  READ ghasbeenthrot   NOTIFY telemchanged);
    Q_PROPERTY(bool glowvolt  READ glowvolt   NOTIFY telemchanged);
    Q_PROPERTY(bool glowvolthasocurred  READ glowvolthasocurred   NOTIFY telemchanged);
    
    Q_PROPERTY(int v1gsmused  READ v1gsmused   NOTIFY telemchanged);
    Q_PROPERTY(int v1gsm1  READ v1gsm1   NOTIFY telemchanged);
    Q_PROPERTY(int v1gsm2  READ v1gsm2   NOTIFY telemchanged);
    Q_PROPERTY(int v1gsm3  READ v1gsm3   NOTIFY telemchanged);
    Q_PROPERTY(int v1sbd  READ v1sbd   NOTIFY telemchanged);
    Q_PROPERTY(int v1rfd  READ v1rfd   NOTIFY telemchanged);
    Q_PROPERTY(bool v1rfdactive  READ v1rfdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v1gsmactive  READ v1gsmactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v1sbdactive  READ v1sbdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v1currentlythrot  READ v1currentlythrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v1hasbeenthrot  READ v1hasbeenthrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v1lowvolt  READ v1lowvolt   NOTIFY telemchanged);
    Q_PROPERTY(bool v1lowvolthasocurred  READ v1lowvolthasocurred   NOTIFY telemchanged);
    
    Q_PROPERTY(int v2gsmused  READ v2gsmused   NOTIFY telemchanged);
    Q_PROPERTY(int v2gsm1  READ v2gsm1   NOTIFY telemchanged);
    Q_PROPERTY(int v2gsm2  READ v2gsm2   NOTIFY telemchanged);
    Q_PROPERTY(int v2gsm3  READ v2gsm3   NOTIFY telemchanged);
    Q_PROPERTY(int v2sbd  READ v2sbd   NOTIFY telemchanged);
    Q_PROPERTY(int v2rfd  READ v2rfd   NOTIFY telemchanged);
    Q_PROPERTY(bool v2rfdactive  READ v2rfdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v2gsmactive  READ v2gsmactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v2sbdactive  READ v2sbdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v2currentlythrot  READ v2currentlythrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v2hasbeenthrot  READ v2hasbeenthrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v2lowvolt  READ v2lowvolt   NOTIFY telemchanged);
    Q_PROPERTY(bool v2lowvolthasocurred  READ v2lowvolthasocurred   NOTIFY telemchanged);

    Q_PROPERTY(int v3gsmused  READ v3gsmused   NOTIFY telemchanged);
    Q_PROPERTY(int v3gsm1  READ v3gsm1   NOTIFY telemchanged);
    Q_PROPERTY(int v3gsm2  READ v3gsm2   NOTIFY telemchanged);
    Q_PROPERTY(int v3gsm3  READ v3gsm3   NOTIFY telemchanged);
    Q_PROPERTY(int v3sbd  READ v3sbd   NOTIFY telemchanged);
    Q_PROPERTY(int v3rfd  READ v3rfd   NOTIFY telemchanged);
    Q_PROPERTY(bool v3rfdactive  READ v3rfdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v3gsmactive  READ v3gsmactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v3sbdactive  READ v3sbdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v3currentlythrot  READ v3currentlythrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v3hasbeenthrot  READ v3hasbeenthrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v3lowvolt  READ v3lowvolt   NOTIFY telemchanged);
    Q_PROPERTY(bool v3lowvolthasocurred  READ v3lowvolthasocurred   NOTIFY telemchanged);

    Q_PROPERTY(int v4gsmused  READ v4gsmused   NOTIFY telemchanged);
    Q_PROPERTY(int v4gsm1  READ v4gsm1   NOTIFY telemchanged);
    Q_PROPERTY(int v4gsm2  READ v4gsm2   NOTIFY telemchanged);
    Q_PROPERTY(int v4gsm3  READ v4gsm3   NOTIFY telemchanged);
    Q_PROPERTY(int v4sbd  READ v4sbd   NOTIFY telemchanged);
    Q_PROPERTY(int v4rfd  READ v4rfd   NOTIFY telemchanged);
    Q_PROPERTY(bool v4rfdactive  READ v4rfdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v4gsmactive  READ v4gsmactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v4sbdactive  READ v4sbdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v4currentlythrot  READ v4currentlythrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v4hasbeenthrot  READ v4hasbeenthrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v4lowvolt  READ v4lowvolt   NOTIFY telemchanged);
    Q_PROPERTY(bool v4lowvolthasocurred  READ v4lowvolthasocurred   NOTIFY telemchanged);

    Q_PROPERTY(int v5gsmused  READ v5gsmused   NOTIFY telemchanged);
    Q_PROPERTY(int v5gsm1  READ v5gsm1   NOTIFY telemchanged);
    Q_PROPERTY(int v5gsm2  READ v5gsm2   NOTIFY telemchanged);
    Q_PROPERTY(int v5gsm3  READ v5gsm3   NOTIFY telemchanged);
    Q_PROPERTY(int v5sbd  READ v5sbd   NOTIFY telemchanged);
    Q_PROPERTY(int v5rfd  READ v5rfd   NOTIFY telemchanged);
    Q_PROPERTY(bool v5rfdactive  READ v5rfdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v5gsmactive  READ v5gsmactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v5sbdactive  READ v5sbdactive   NOTIFY telemchanged);
    Q_PROPERTY(bool v5currentlythrot  READ v5currentlythrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v5hasbeenthrot  READ v5hasbeenthrot   NOTIFY telemchanged);
    Q_PROPERTY(bool v5lowvolt  READ v5lowvolt   NOTIFY telemchanged);
    Q_PROPERTY(bool v5lowvolthasocurred  READ v5lowvolthasocurred   NOTIFY telemchanged);

    Q_PROPERTY(bool activelink  READ activelink   NOTIFY activelinkchanged);

    int ggsmused() { return _ggsmused; }
    int ggsm1() { return _ggsm1; }
    int ggsm2() { return _ggsm2; }
    int ggsm3() { return _ggsm3; }
    int gsbd() { return _gsbd; }
    int grfd() { return _grfd; }
    bool grfdactive() { return _grfdactive;} 
    bool ggsmactive() { return _ggsmactive;} 
    bool gsbdactive() { return _gsbdactive;} 
    bool gcurrentlythrot() { return _gcurrentlythrot;} 
    bool ghasbeenthrot() { return _ghasbeenthrot;} 
    bool glowvolt() { return _glowvolt;} 
    bool glowvolthasocurred() { return _glowvolthasocurred;}

    int v1gsmused() { return _v1gsmused; }
    int v1gsm1() { return _v1gsm1; }
    int v1gsm2() { return _v1gsm2; }
    int v1gsm3() { return _v1gsm3; }
    int v1sbd() { return _v1sbd; }
    int v1rfd() { return _v1rfd; }
    bool v1rfdactive() { return _v1rfdactive;} 
    bool v1gsmactive() { return _v1gsmactive;} 
    bool v1sbdactive() { return _v1sbdactive;} 
    bool v1currentlythrot() { return _v1currentlythrot;} 
    bool v1hasbeenthrot() { return _v1hasbeenthrot;} 
    bool v1lowvolt() { return _v1lowvolt;} 
    bool v1lowvolthasocurred() { return _v1lowvolthasocurred;}

    int v2gsmused() { return _v2gsmused; }
    int v2gsm1() { return _v2gsm1; }
    int v2gsm2() { return _v2gsm2; }
    int v2gsm3() { return _v2gsm3; }
    int v2sbd() { return _v2sbd; }
    int v2rfd() { return _v2rfd; }
    bool v2rfdactive() { return _v2rfdactive;} 
    bool v2gsmactive() { return _v2gsmactive;} 
    bool v2sbdactive() { return _v2sbdactive;} 
    bool v2currentlythrot() { return _v2currentlythrot;} 
    bool v2hasbeenthrot() { return _v2hasbeenthrot;} 
    bool v2lowvolt() { return _v2lowvolt;} 
    bool v2lowvolthasocurred() { return _v2lowvolthasocurred;}

    int v3gsmused() { return _v3gsmused; }
    int v3gsm1() { return _v3gsm1; }
    int v3gsm2() { return _v3gsm2; }
    int v3gsm3() { return _v3gsm3; }
    int v3sbd() { return _v3sbd; }
    int v3rfd() { return _v3rfd; }
    bool v3rfdactive() { return _v3rfdactive;} 
    bool v3gsmactive() { return _v3gsmactive;} 
    bool v3sbdactive() { return _v3sbdactive;} 
    bool v3currentlythrot() { return _v3currentlythrot;} 
    bool v3hasbeenthrot() { return _v3hasbeenthrot;} 
    bool v3lowvolt() { return _v3lowvolt;} 
    bool v3lowvolthasocurred() { return _v3lowvolthasocurred;}

    int v4gsmused() { return _v4gsmused; }
    int v4gsm1() { return _v4gsm1; }
    int v4gsm2() { return _v4gsm2; }
    int v4gsm3() { return _v4gsm3; }
    int v4sbd() { return _v4sbd; }
    int v4rfd() { return _v4rfd; }
    bool v4rfdactive() { return _v4rfdactive;} 
    bool v4gsmactive() { return _v4gsmactive;} 
    bool v4sbdactive() { return _v4sbdactive;} 
    bool v4currentlythrot() { return _v4currentlythrot;} 
    bool v4hasbeenthrot() { return _v4hasbeenthrot;} 
    bool v4lowvolt() { return _v4lowvolt;} 
    bool v4lowvolthasocurred() { return _v4lowvolthasocurred;}

    int v5gsmused() { return _v5gsmused; }
    int v5gsm1() { return _v5gsm1; }
    int v5gsm2() { return _v5gsm2; }
    int v5gsm3() { return _v5gsm3; }
    int v5sbd() { return _v5sbd; }
    int v5rfd() { return _v5rfd; }
    bool v5rfdactive() { return _v5rfdactive;} 
    bool v5gsmactive() { return _v5gsmactive;} 
    bool v5sbdactive() { return _v5sbdactive;} 
    bool v5currentlythrot() { return _v5currentlythrot;} 
    bool v5hasbeenthrot() { return _v5hasbeenthrot;} 
    bool v5lowvolt() { return _v5lowvolt;} 
    bool v5lowvolthasocurred() { return _v5lowvolthasocurred;}

    bool activelink() { return _activelink;}

signals:
    void telemchanged();
    void activelinkchanged();

public slots:
    void processBytes(QByteArray bytes);
    void linkconnected() { _activelink = true; }
    void linkdisconnected() { _activelink = false; }

private:

    int _ggsmused = 0; 
    int _ggsm1 = 0; 
    int _ggsm2 = 0; 
    int _ggsm3 = 0; 
    int _gsbd = 0; 
    int _grfd = 0; 
    bool _grfdactive = false;
    bool _ggsmactive = false;
    bool _gsbdactive = false;
    bool _gcurrentlythrot = false;
    bool _ghasbeenthrot = false;
    bool _glowvolt = false;
    bool _glowvolthasocurred = false;

    int _v1gsmused = 0; 
    int _v1gsm1 = 0; 
    int _v1gsm2 = 0; 
    int _v1gsm3 = 0; 
    int _v1sbd = 0; 
    int _v1rfd = 0; 
    bool _v1rfdactive = false;
    bool _v1gsmactive = false;
    bool _v1sbdactive = false;
    bool _v1currentlythrot = false;
    bool _v1hasbeenthrot = false;
    bool _v1lowvolt = false;
    bool _v1lowvolthasocurred = false;

    int _v2gsmused = 0; 
    int _v2gsm1 = 0; 
    int _v2gsm2 = 0; 
    int _v2gsm3 = 0; 
    int _v2sbd = 0; 
    int _v2rfd = 0; 
    bool _v2rfdactive = false;
    bool _v2gsmactive = false;
    bool _v2sbdactive = false;
    bool _v2currentlythrot = false;
    bool _v2hasbeenthrot = false;
    bool _v2lowvolt = false;
    bool _v2lowvolthasocurred = false;

    int _v3gsmused = 0; 
    int _v3gsm1 = 0; 
    int _v3gsm2 = 0; 
    int _v3gsm3 = 0; 
    int _v3sbd = 0; 
    int _v3rfd = 0; 
    bool _v3rfdactive = false;
    bool _v3gsmactive = false;
    bool _v3sbdactive = false;
    bool _v3currentlythrot = false;
    bool _v3hasbeenthrot = false;
    bool _v3lowvolt = false;
    bool _v3lowvolthasocurred = false;

    int _v4gsmused = 0; 
    int _v4gsm1 = 0; 
    int _v4gsm2 = 0; 
    int _v4gsm3 = 0; 
    int _v4sbd = 0; 
    int _v4rfd = 0; 
    bool _v4rfdactive = false;
    bool _v4gsmactive = false;
    bool _v4sbdactive = false;
    bool _v4currentlythrot = false;
    bool _v4hasbeenthrot = false;
    bool _v4lowvolt = false;
    bool _v4lowvolthasocurred = false;

    int _v5gsmused = 0; 
    int _v5gsm1 = 0; 
    int _v5gsm2 = 0; 
    int _v5gsm3 = 0; 
    int _v5sbd = 0; 
    int _v5rfd = 0; 
    bool _v5rfdactive = false;
    bool _v5gsmactive = false;
    bool _v5sbdactive = false;
    bool _v5currentlythrot = false;
    bool _v5hasbeenthrot = false;
    bool _v5lowvolt = false;
    bool _v5lowvolthasocurred = false;

    void check_new_vehicle(int mavid);

    int vehicle_index_by_mavid(int mavid);

    void process_msg(mavlink_message_t &msg);

    bool                    _activelink = false;

    UDPlink*                _link = nullptr;

    QMap<int, Vehicle*>     _vehiclesmap;
    int                     _vehicleindex[10];
    int                     _activeVehicles = 1;
};