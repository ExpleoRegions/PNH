#include "ctcpclient.h"



CTcpClient::CTcpClient(QObject *parent)
    : QObject{parent}
{
}

bool CTcpClient::connect(QString ipAdress)
{
    m_tcpSocket = new QTcpSocket(this);

    QAbstractSocket::connect(m_tcpSocket, SIGNAL(connected()),this, SLOT(connected()));
    QAbstractSocket::connect(m_tcpSocket, SIGNAL(disconnected()),this, SLOT(disconnected()));
    QAbstractSocket::connect(m_tcpSocket, SIGNAL(bytesWritten(qint64)),this, SLOT(bytesWritten(qint64)));
    QAbstractSocket::connect(m_tcpSocket, SIGNAL(readyRead()),this, SLOT(readyRead()));

    qDebug() << "connecting to " + ipAdress + " ...";
    m_tcpSocket->connectToHost(ipAdress, TCP_PORT);

    if(!m_tcpSocket->waitForConnected(3000))
    {
        qDebug() << "CtcpClient Error: " << m_tcpSocket->errorString();
        return false;
    }

    return true;
}

bool CTcpClient::disconnect()
{
    return m_tcpSocket->disconnect();
}


void CTcpClient::connected()
{
    emit SocketStateChanged(true);
    qDebug() << "connected...";

    //m_tcpSocket->write("HEAD / HTTP/1.0\r\n\r\n\r\n\r\n");
    m_tcpSocket->write(GET_PRIMATE_LIST);
    m_lastTcpRequest = GET_PRIMATE_LIST;
    //m_tcpSocket->write("TEST\n");
}

void CTcpClient::disconnected()
{
    qDebug() << "disconnected...";
    emit SocketStateChanged(false);
}

void CTcpClient::bytesWritten(qint64 bytes)
{
    qDebug() << bytes << " bytes written...";
}

void CTcpClient::readyRead()
{
    qDebug() << "reading...";

    // read the data from the socket
    QByteArray datas = m_tcpSocket->readAll();
    QString response = QString::fromUtf8(datas.toStdString());
    qDebug() << "CTcpServer - onReadyRead: " + response;
}
