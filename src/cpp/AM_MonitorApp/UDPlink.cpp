#include "UDPlink.h"

UDPlink::UDPlink(QObject *parent) :
    QObject(parent)
{

    socket = new QUdpSocket(this);
    
    socket->bind(QHostAddress::LocalHost, 14400);
    
    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()));
}

void UDPlink::readyRead()
{
    QByteArray buffer;

    buffer.resize(socket->pendingDatagramSize());

    QHostAddress sender;
    quint16 senderPort;

    socket->readDatagram(buffer.data(), buffer.size(),
                         &sender, &senderPort);

    if ( buffer.size() ) {
        emit readBytes(buffer);
    }
}