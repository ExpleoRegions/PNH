/**
 * @file CRewardSystem.h
 * @brief The declaration of the CRewardSystem class
 */

#ifndef CTESTSEQUENCE_H
#define CTESTSEQUENCE_H

#include <QObject>
#include "ctest.h"


/**
 * @class       CTestSequence.h
 * @brief       The declaration of the class CTestSequence
 * @details     The CTestSequence class defines a list of test to execute
 */
class CTestSequence : public QObject
{
    Q_OBJECT
public:
    explicit CTestSequence(QObject *parent = nullptr);
    CTestSequence(const QString &name, QString &comment, const bool &execute, QObject *parent=0);

    const QString &getSequenceName() const;
    void setSequenceName(const QString &sequenceName);
    const QString &getComment() const;
    void setComment(const QString &comment);
    bool getExecute() const;
    void setExecute(bool execute);

    QList<CTest*> &getTestList();



private:
    QString m_sequenceName;         //!< m_sequenceName is the name of the sequence
    QString m_comment;              //!< m_comment the text to describe the sequence
    bool m_execute;                 //!< m_execute is TRUE if the sequence will be executed
    QList<CTest*> m_testList;       //!< m_testList is the list of tests

signals:

};

#endif // CTESTSEQUENCE_H
