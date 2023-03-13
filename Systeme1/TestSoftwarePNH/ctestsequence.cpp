#include "ctestsequence.h"

/**
 * @brief CTestSequence class constructor
 * @overload
 * @param parent the initial value of the parent attribute
 */
CTestSequence::CTestSequence(QObject *parent)
    : QObject{parent}
{
    m_execute = false;
}

/**
 * @brief CTestSequence class constructor
 * @overload
 * @param name the name of the sequence
 * @param comment the text to describe the sequence
 * @param execute is the execution status
 * @param parent the initial value of the parent attribute
 */
CTestSequence::CTestSequence(const QString &name, QString &comment, const bool &execute, QObject *parent)
    : QObject(parent), m_sequenceName(name), m_comment(comment), m_execute(execute)
{

}

/**
 * @brief Accessor for attribute m_sequenceName
 * @callergraph
 * @return the value of attribute m_sequenceName
 * @retval QString& the value of attribute m_sequenceName
 */
const QString &CTestSequence::getSequenceName() const
{
    return m_sequenceName;
}

/**
 * @brief Mutator for attribute m_sequenceName
 * @callergraph
 * @param sequenceName the new value of attribute m_sequenceName
 */
void CTestSequence::setSequenceName(const QString &sequenceName)
{
    m_sequenceName = sequenceName;
}

/**
 * @brief Accessor for attribute m_comment
 * @callergraph
 * @return the value of attribute m_comment
 * @retval QString& the value of attribute m_comment
 */
const QString &CTestSequence::getComment() const
{
    return m_comment;
}

/**
 * @brief Mutator for attribute m_comment
 * @callergraph
 * @param comment the new value of attribute m_comment
 */
void CTestSequence::setComment(const QString &comment)
{
    m_comment = comment;
}

/**
 * @brief Accessor for attribute m_execute
 * @callergraph
 * @return the value of attribute m_execute
 * @retval QString& the value of attribute m_execute
 */
bool CTestSequence::getExecute() const
{
    return m_execute;
}

/**
 * @brief Mutator for attribute m_execute
 * @callergraph
 * @param comment the new value of attribute m_execute
 */
void CTestSequence::setExecute(bool execute)
{
    m_execute = execute;
}

/**
 * @brief Accessor for attribute m_testList
 * @callergraph
 * @return the value of attribute m_testList
 * @retval QList<CTest*> the value of attribute m_testList
 */
QList<CTest*> &CTestSequence::getTestList()
{
    return m_testList;
}
