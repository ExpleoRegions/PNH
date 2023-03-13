#include "crewardsystem.h"
#include <QDebug>

/**
 * @brief CRewardSystem class constructor
 * @overload
 * @param parent the initial value of the parent attribute
 */
CRewardSystem::CRewardSystem(QObject *parent)
    : QObject{parent}
{
    // Serial port instanciation
    m_serialPort = new QSerialPort(SERIAL_PORT_NAME);

    // Serial port  configuration
    m_serialPort->setBaudRate(QSerialPort::Baud9600);
    m_serialPort->setDataBits(QSerialPort::Data8);
    m_serialPort->setParity(QSerialPort::NoParity);
    m_serialPort->setStopBits(QSerialPort::OneStop);
    m_serialPort->setFlowControl(QSerialPort::NoFlowControl);

    // Open Serial port
    m_serialPort->open(QIODevice::ReadWrite);
    // connect receive signal
    connect(m_serialPort, SIGNAL(readyRead()), this, SLOT(serialDataReceive()));
}


/**
 * @brief CRewardSystem class destructor
 */
CRewardSystem::~CRewardSystem()
{
    m_serialPort->close();
}

/**
 * @brief Send serial message to the reward system to give reward to the primate
 */
void CRewardSystem::giveReward()
{
    // use reward system
    //qDebug() << "CRewardSystem - giveReward"<<Qt::endl;
    m_serialPort->write(REWARD);
}

/**
 * @brief Triggered function when some data is received by the test sofware from the reward system
 */
void CRewardSystem::serialDataReceive()
{
    QByteArray data;
    while (m_serialPort->bytesAvailable())
    {
        data += m_serialPort->readAll();
        //_sleep(100000); // timeout
    }

    QString trame = QString(data.data());
    if (trame == ERROR)
    {
        qDebug()<< "CRewardSystem - ERROR";
    }
    else if (trame == EMPTY)
    {
        qDebug()<< "CRewardSystem - EMPTY";
    }
}
