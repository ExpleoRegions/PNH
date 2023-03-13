/**
 * @file CDataBaseManager.h
 * @brief The declaration of the CDataBaseManager class
 */

#ifndef CDATABASEMANAGER_H
#define CDATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include "csequencelist.h"
#include <QDateTime>

#define ID              "ID"
#define SEQUENCE_NAME   "Sequence_Name"
#define COMMENT         "Comment"
#define EXECUTE         "Execute"
#define TEST_NAME       "Test_Name"
#define PARAM           "Param"
#define VALUE           "Value"
#define TYPE            "Type"

/**
 * @class       CDataBaseManager.h
 * @brief       The declaration of the class CDataBaseManager
 * @details     The CDataBaseManager class allows to use the SQLite database
 */
class CDataBaseManager : public QObject
{
    Q_OBJECT
public:
    explicit CDataBaseManager(QObject *parent = nullptr);
    bool getSequenceList(CSequenceList * sequenceList);
    QString SQLQuery(const QString &sqlquery);


public slots:
    void saveResults(CTestInfo &testInfo, QString sessionName, QString sequenceName, QString testName, QString testResultName, QString primateName);

private:
    QSqlDatabase m_dataBase;    //!< m_dataBase is the SQLite database


signals:

};

#endif // CDATABASEMANAGER_H
