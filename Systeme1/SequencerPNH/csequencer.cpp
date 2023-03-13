#include "csequencer.h"

CSequencer::CSequencer(QObject *parent)
    : QObject{parent}
{
    connect(&m_tcpClient, SIGNAL(SocketStateChanged(bool)),this, SLOT(onSocketStateChanged(bool)));

}

bool CSequencer::connection(QString ipAdress)
{
    bool ret = m_tcpClient.connect(ipAdress);
    if (ret)
        updateLabelConnectStatus(ret);

    m_connected = ret;
    return ret;
}

bool CSequencer::disconnection()
{
    bool ret = m_tcpClient.disconnect();
    m_connected = !ret;
    return ret;
}

bool CSequencer::isConnected()
{
    return m_connected;
}

void CSequencer::onSocketStateChanged(bool status)
{
    m_connected = status;
    updateLabelConnectStatus(status);
}
