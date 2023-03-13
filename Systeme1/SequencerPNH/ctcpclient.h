#ifndef CTCPCLIENT_H
#define CTCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QAbstractSocket>
#include "common.h"

class CTcpClient  : public QObject
{
    Q_OBJECT
public:
    explicit CTcpClient(QObject *parent = nullptr);
    bool connect(QString ipAdress);
    bool disconnect();

private:
    QTcpSocket* m_tcpSocket;
    QString m_lastTcpRequest;

signals:
    void SocketStateChanged(bool status);

private slots:
    void connected();
    void disconnected();
    void bytesWritten(qint64 bytes);
    void readyRead();
};

#endif // CTCPCLIENT_H
