/**
 * @file CDataBaseManager.h
 * @brief The declaration of the CDataBaseManager class
 */

#ifndef CSEQUENCELIST_H
#define CSEQUENCELIST_H

#include <QObject>
#include <ctestsequence.h>

/**
 * @class       CSequenceList.h
 * @brief       The declaration of the class CSequenceList
 * @details     The CSequenceList class allows to use the SQLite database
 */
class CSequenceList : public QObject
{
    Q_OBJECT
public:
    explicit CSequenceList(QObject *parent = nullptr);
    QList<CTestSequence*> *getSequenceList();
private:
    QList<CTestSequence*> m_sequenceList;   //!< m_sequenceList is the sequence containing the tests



private:

};

#endif // CSEQUENCELIST_H
