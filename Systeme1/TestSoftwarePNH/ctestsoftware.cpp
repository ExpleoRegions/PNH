#include "CTestSoftware.h"
#include <QDebug>

/**
 * @brief CTestSoftware class constructor
 * @overload
 * @param parent the initial value of the parent attribute
 */
CTestSoftware::CTestSoftware(QObject *parent)
    : QObject{parent}
{

}

/**
 * @brief Accessor for attribute m_sequenceList
 * @callergraph
 * @return the value of attribute m_sequenceList
 * @retval CSequenceList* the value of attribute m_sequenceList
 */
CSequenceList *CTestSoftware::getSequenceList()
{
    return &m_sequenceList;
}

/**
 * @brief Mutator for attribute m_sequenceList
 * @callergraph
 * @param sequenceList the new value of attribute m_sequenceList
 */
void CTestSoftware::setSequenceList(CSequenceList *sequenceList)
{
    // TODO
}

/**
 * @brief Accessor for attribute m_currentTestInfo (from QML)
 * @callergraph
 * @return the value of attribute m_currentTestInfo
 * @retval CTestInfo* the value of attribute m_currentTestInfo
 */
CTestInfo *CTestSoftware::getCurrentTestInfo()
{
    return &m_currentTestInfo;
}

/**
 * @brief Mutator for attribute m_currentTestInfo
 * @callergraph
 * @param testInfo the new value of attribute m_currentTestInfo
 */
void CTestSoftware::setCurrentTestInfo(CTestInfo *testInfo)
{
    m_currentTestInfo.copy(*testInfo);
}

/**
 * @brief go to next test of the sequence
 */
void CTestSoftware::nextTest()
{
    if (m_indexSequence <= m_sequenceList.getSequenceList()->count() - 1)
    {
        if (m_sequenceList.getSequenceList()->at(m_indexSequence)->getExecute() == false)
        {
            m_indexSequence++;
            m_indexTest = -1;
            nextTest();
            return;
        }
        else
        {
            if (m_indexTest < m_sequenceList.getSequenceList()->at(m_indexSequence)->getTestList().count() - 1)
            {
                // next test
                m_indexTest++;
                //m_currentTestInfo =  m_sequenceList.getSequenceList().at(m_indexSequence)->getTestList().at(m_indexTest)->getTestInfo();
                m_currentTestInfo.copy(*m_sequenceList.getSequenceList()->at(m_indexSequence)->getTestList().at(m_indexTest)->getTestInfo());
                // send change signal
                emit m_currentTestInfo.variableNameChanged();   // TODO maybe unuseful
                emit m_currentTestInfo.variableValueChanged();
                emit m_currentTestInfo.variableTypeChanged();
                return;
            }
            else
            {
                // next sequence
                m_indexSequence++;
                m_indexTest = -1;
                nextTest();
                return;
            }
        }
    }
    else
    {
        // restart
        m_indexSequence = 0;
        m_indexTest = -1;
        nextTest();
        return;
    }
}

/**
 * @brief start a new session
 * @overload
 * @param sessionName the name of the new session
 * @param sessionComment the description of the new session
 */
void CTestSoftware::newSession(const QString sessionName, const QString sessionComment)
{
    m_sessionName = sessionName;
    m_sessionComment = sessionComment;
    m_sessionDate = QDateTime::currentDateTime();
}

/**
 * @brief Accessor for attribute m_ongoingTest
 * @callergraph
 * @return the value of attribute m_ongoingTest
 * @retval bool the value of attribute m_ongoingTest
 */
bool CTestSoftware::getOngoingTest() const
{
    return m_ongoingTest;
}

/**
 * @brief Mutator for attribute m_ongoingTest
 * @callergraph
 * @param ongoingTest the new value of attribute m_ongoingTest
 */
void CTestSoftware::setOngoingTest(bool ongoingTest)
{
    m_ongoingTest = ongoingTest;
}

/**
 * @brief signal that the test is done (from QML)
 */
void CTestSoftware::testEnd()
{
    nextTest();
    QString testName = m_sequenceList.getSequenceList()->at(m_indexSequence)->getTestList().at(m_indexTest)->getTestName();
    emit changeTestToQml("./PNH_Test/" + testName + ".qml");
}

/**
 * @brief give a reward to the primate (from QML)
 */
void CTestSoftware::giveReward()
{
    //qDebug() << "CRewardSystem - giveReward";
    m_rewardSystem.giveReward();
}

/**
 * @brief change the primate name
 * @overload
 * @param primateName the new primate name
 */
void CTestSoftware::setPrimateName(QString primateName)
{
    m_primateName = primateName;
}

/**
 * @brief save all informations about a test on SQLite database
 */
void CTestSoftware::saveResults()
{
    QString sequenceName = m_sequenceList.getSequenceList()->at(m_indexSequence)->getSequenceName();
    QString testName = m_sequenceList.getSequenceList()->at(m_indexSequence)->getTestList().at(m_indexTest)->getTestName();
    QString testResultName = testName + QDateTime::currentDateTime().toString();
    testResultName = testResultName.replace(" ", "");
    testResultName = testResultName.replace(":", "");
    emit saveResultsToDataBase(m_currentTestInfo, m_sessionName, sequenceName, testName, testResultName, m_primateName);
}




