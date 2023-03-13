/**
 * @file CTestSoftware.h
 * @brief The declaration of the CTestSoftware class
 */

#ifndef CTESTSOFWARE_H
#define CTESTSOFWARE_H

#include <QObject>
#include "ctestinfo.h"
#include "csequencelist.h"
#include "crewardsystem.h"
#include "QDateTime"


/**
 * @class       CTestSoftware.h
 * @brief       The declaration of the class CTestSoftware
 * @details     The CTestSoftware class defines the test software
 */
class CTestSoftware : public QObject
{
    Q_OBJECT
public:
    explicit CTestSoftware(QObject *parent = nullptr);
    CSequenceList* getSequenceList();
    void setSequenceList(CSequenceList* sequenceList);
    CTestInfo* getCurrentTestInfo();
    void setCurrentTestInfo(CTestInfo* testInfo);
    bool getOngoingTest() const;
    void setOngoingTest(bool ongoingTest);

public slots:
    void nextTest();
    void newSession(const QString sessionName, const QString sessionComment);

private:
    CSequenceList m_sequenceList;       //!< m_sequenceList the list of sequencies
    CTestInfo m_currentTestInfo;        //!< m_currentTestInfo the current test infos to send to QML
    CRewardSystem m_rewardSystem;       //!< m_rewardSystem to give a reward to the primate if test is ok

    int m_indexSequence = 0;                                        //!< m_indexSequence the current index of the sequence
    int m_indexTest = -1;                                           //!< m_indexTest the current index of the test
    bool m_ongoingTest = true;                                      //!< m_ongoingTest TRUE if we are currently in a test phase
    QString m_sessionName = "Session1"; // TODO                     //!< m_sessionName name of the current session
    QString m_sessionComment = "commentaire Session1"; // TODO;     //!< m_sessionComment decription of the current session
    QDateTime m_sessionDate;                                        //!< m_sessionDate date and time of the current session
    QString m_primateName = "Monkey1";                              //!< m_primateName name of the primate who use the system

signals:
    void changeTestToQml(QString testUrl);
    void saveResultsToDataBase(CTestInfo & testInfo, QString sessionName, QString sequenceName, QString testName, QString testResultName, QString primateName);

public slots:
    void testEnd();
    void giveReward();
    void setPrimateName(QString primateName);
    void saveResults();


};

#endif // CTESTSOFWARE_H
