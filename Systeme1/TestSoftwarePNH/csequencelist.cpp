#include "csequencelist.h"


/**
 * @brief CSequenceList class constructor
 * @overload
 * @param parent the initial value of the parent attribute
 */
CSequenceList::CSequenceList(QObject *parent)
    : QObject(parent)
{

}

/**
 * @brief Accessor for attribute m_sequenceList
 * @callergraph
 * @return the value of attribute m_sequenceList
 * @retval QList<CTestSequence*> the value of attribute m_sequenceList
 */
QList<CTestSequence *> *CSequenceList::getSequenceList()
{
    return &m_sequenceList;
}
