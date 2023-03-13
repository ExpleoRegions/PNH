#ifndef CSEQUENCER_H
#define CSEQUENCER_H

#include <QObject>
#include "ctcpclient.h"


class CSequencer : public QObject
{
    Q_OBJECT
public:
    explicit CSequencer(QObject *parent = nullptr);
    bool connection(QString ipAdress);
    bool disconnection();
    bool isConnected();


private:
     CTcpClient m_tcpClient;
     bool m_connected = false;

public slots:
     void onSocketStateChanged(bool status);

signals:
     void updateLabelConnectStatus(bool status);

};

#endif // CSEQUENCER_H
