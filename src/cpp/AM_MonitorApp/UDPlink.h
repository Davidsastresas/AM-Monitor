#ifndef UDPLINK_H
#define UDPLINK_H

#include <QObject>
#include <QUdpSocket>

class UDPlink : public QObject
{
    Q_OBJECT
public:
    explicit UDPlink(QObject *parent = 0);
    void HelloUDP();
signals:
    
public slots:
    void readyRead();

private:
    QUdpSocket *socket;
    
};

#endif // UDPLINK_H