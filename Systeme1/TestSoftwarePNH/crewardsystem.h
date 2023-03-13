/**
 * @file CRewardSystem.h
 * @brief The declaration of the CRewardSystem class
 */

#ifndef CREWARDSYSTEM_H
#define CREWARDSYSTEM_H

#include <QObject>
#include <QSerialPort>

#define SERIAL_PORT_NAME    "COM1"      //!< port name for the serial communication
#define REWARD              "REWARD"    //!< text send to the reward system for giving reward to the primate
#define EMPTY               "EMPTY"     //!< text received from the reward system to inform that the reservoir is empty
#define ERROR               "ERROR"     //!< text received from the reward system to inform that there is an error

/**
 * @class       CRewardSystem.h
 * @brief       The declaration of the class CRewardSystem
 * @details     The CRewardSystem class allows to use the primate reward system
 */
class CRewardSystem : public QObject
{
    Q_OBJECT
public:
    explicit CRewardSystem(QObject *parent = nullptr);
    ~CRewardSystem();
    void giveReward();

private:
    QSerialPort *m_serialPort;  //!< m_DataBase is the QSerialPort use for communication with the reward system

private slots:
    void serialDataReceive();

signals:
};

#endif // CREWARDSYSTEM_H
