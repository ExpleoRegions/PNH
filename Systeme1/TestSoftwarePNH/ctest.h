/**
 * @file CTest.h
 * @brief The declaration of the CTest class
 */

#ifndef CTEST_H
#define CTEST_H

#include <QObject>
#include <QString>
#include "ctestinfo.h"


/**
 * @class       CRewardSystem.h
 * @brief       The declaration of the class CRewardSystem
 * @details     The CRewardSystem class allows to use the primate reward system
 */
class CTest : public QObject
{
    Q_OBJECT
public:
    explicit CTest(QObject *parent = nullptr);
    CTest(const QString &name, QString &comment, QObject *parent=0);

    const QString &getTestName() const;
    void setTestName(const QString &testName);
    const QString &getComment() const;
    void setComment(const QString &comment);


    CTestInfo *getTestInfo() ;
    void setTestInfo(CTestInfo *testInfo);

private:
    QString m_testName;         //!< m_testName the name of the test
    QString m_comment;          //!< m_testName the text to describe the test
    CTestInfo* m_testInfo;      //!< m_testInfo contains test parameters and results

signals:

};

#endif // CTEST_H
