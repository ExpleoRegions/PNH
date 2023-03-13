#include "ctest.h"

/**
 * @brief CTest class constructor
 * @overload
 * @param parent the initial value of the parent attribute
 */
CTest::CTest(QObject *parent)
    : QObject{parent}
{
    m_testInfo = new CTestInfo();
}

/**
 * @brief CTest class constructor
 * @overload
 * @param name the name of the test
 * @param comment the text to describe the test
 * @param parent the initial value of the parent attribute
 */
CTest::CTest(const QString &name, QString &comment, QObject *parent)
    : QObject(parent), m_testName(name), m_comment(comment)
{
    m_testInfo = new CTestInfo();
}

/**
 * @brief Accessor for attribute m_testName
 * @callergraph
 * @return the value of attribute m_testName
 * @retval QString& the value of attribute m_testName
 */
const QString &CTest::getTestName() const
{
    return m_testName;
}

/**
 * @brief Mutator for attribute testName
 * @callergraph
 * @param testName the new value of attribute testName
 */
void CTest::setTestName(const QString &testName)
{
    m_testName = testName;
}

/**
 * @brief Accessor for attribute m_comment
 * @callergraph
 * @return the value of attribute m_comment
 * @retval QString& the value of attribute m_comment
 */
const QString &CTest::getComment() const
{
    return m_comment;
}

/**
 * @brief Mutator for attribute m_comment
 * @callergraph
 * @param comment the new value of attribute m_comment
 */
void CTest::setComment(const QString &comment)
{
    m_comment = comment;
}

/**
 * @brief Accessor for attribute m_testInfo
 * @callergraph
 * @return the value of attribute m_testInfo
 * @retval CTestInfo* the value of attribute m_testInfo
 */
CTestInfo *CTest::getTestInfo()
{
    return m_testInfo;
}

/**
 * @brief Mutator for attribute m_testInfo
 * @callergraph
 * @param *testInfo the new value of attribute m_testInfo
 */
void CTest::setTestInfo(CTestInfo *testInfo)
{
    m_testInfo = testInfo;
}

