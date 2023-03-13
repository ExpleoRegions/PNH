#include "ctcpserver.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

CTcpServer::CTcpServer(QObject *parent)
    : QObject{parent}
{

}

CTcpServer::CTcpServer(CDataBaseManager *dataBaseManager, QObject *parent)
    : QObject{parent}
{
    m_dataBaseManager = dataBaseManager;
}

bool CTcpServer::startServer()
{
    m_tcpServer.listen(QHostAddress::Any, TCP_PORT);
    connect(&m_tcpServer, SIGNAL(newConnection()), this, SLOT(onNewConnection()));
    qDebug() << "CTcpServer - server started ";
}


void CTcpServer::onNewConnection()
{
   m_tcpSocket = m_tcpServer.nextPendingConnection();
   connect(m_tcpSocket, SIGNAL(readyRead()), this, SLOT(onReadyRead()));
   connect(m_tcpSocket, SIGNAL(stateChanged(QAbstractSocket::SocketState)), this, SLOT(onSocketStateChanged(QAbstractSocket::SocketState)));
   //m_tcpSocket->write(QByteArray::fromStdString(m_tcpSocket->peerAddress().toString().toStdString() + " connected to server !\n"));
}

void CTcpServer::onSocketStateChanged(QAbstractSocket::SocketState socketState)
{
    if (socketState == QAbstractSocket::UnconnectedState)
    {
        m_tcpSocket = static_cast<QTcpSocket*>(QObject::sender());
        emit signalSocketStateChanged(false);
    }
    else if (socketState == QAbstractSocket::ConnectedState)
    {
        emit signalSocketStateChanged(true);
    }
}

void CTcpServer::onReadyRead()
{
    QTcpSocket* sender = static_cast<QTcpSocket*>(QObject::sender());
    QByteArray datas = sender->readAll();
    //m_tcpSocket->write(QByteArray::fromStdString(sender->peerAddress().toString().toStdString() + ": " + datas.toStdString()));
    QString request = QString::fromUtf8(datas.toStdString());
    qDebug() << "CTcpServer - onReadyRead: " + request;

    if (request == GET_PRIMATE_LIST)
    {
//        QJsonObject levan{
//            {"test",1},
//            {"test2","2"},
//            {"test3", 10},
//            {"test4",0},
//        };

//        QJsonArray jsarray {levan};
//        QJsonDocument jsDoc(jsarray);

//        QString jsString = QString::fromLatin1(jsDoc.toJson());
//        this->m_tcpSocket->write(jsString.toLatin1());

        QString response = m_dataBaseManager->SQLQuery("SELECT name,comment FROM Primate");
        this->m_tcpSocket->write(response.toLatin1());

    }
}
