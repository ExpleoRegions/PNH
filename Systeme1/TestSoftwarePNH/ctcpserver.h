#ifndef CTCPSERVER_H
#define CTCPSERVER_H

#include <QObject>
#include <QTcpSocket>
#include <QTcpServer>
#include <QAbstractSocket>
#include "cdatabasemanager.h"
#include "common.h"



class CTcpServer : public QObject
{
    Q_OBJECT
public:
    explicit CTcpServer(QObject *parent = nullptr);
    CTcpServer(CDataBaseManager *dataBaseManager, QObject *parent = nullptr);
    bool startServer();
    bool closeServer();

private:
    QTcpServer m_tcpServer;
    QTcpSocket* m_tcpSocket;
    CDataBaseManager *m_dataBaseManager;

signals:
    void startTestProcedure();
    void stopTestProcedure();
    void signalSocketStateChanged(bool status);


private slots:
    void onNewConnection();
    void onSocketStateChanged(QAbstractSocket::SocketState socketState);
    void onReadyRead();
};

#endif // CTCPSERVER_H
