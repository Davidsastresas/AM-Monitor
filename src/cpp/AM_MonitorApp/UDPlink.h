#ifndef UDPLINK_H
#define UDPLINK_H

#include <QObject>
#include <QUdpSocket>

class UDPlink : public QObject
{
    Q_OBJECT
public:
    explicit UDPlink(QObject *parent = 0);
signals:
    void readBytes(QByteArray bytes);
    void connected();
    void disconnected();
    
public slots:
    void readyRead();
    void sconnected() { emit connected(); }
    void sdisconnected() { emit disconnected(); }

private:
    QUdpSocket *socket;
    
};

#endif // UDPLINK_H