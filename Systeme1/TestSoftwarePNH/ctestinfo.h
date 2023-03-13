/**
 * @file CDataBaseManager.h
 * @brief The declaration of the CDataBaseManager class
 */

#ifndef CTESTINFO_H
#define CTESTINFO_H

#include <QObject>
#include <QMap>
#include <QVariant>

/**
 * @class       CTestInfo.h
 * @brief       The declaration of the class CTestInfo
 * @details     The CTestInfo contains all variables and results for a test
 */
class CTestInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList variableName READ getVariableName NOTIFY variableNameChanged)
    Q_PROPERTY(QVariantList variableValue READ getVariableValue NOTIFY variableValueChanged)
    Q_PROPERTY(QVariantList variableType READ getVariableType NOTIFY variableTypeChanged)

public:
    explicit CTestInfo(QObject *parent = nullptr);
    QVariantList getVariableName() const;
    QVariantList getVariableValue() const;
    QVariantList getVariableType() const;

    void appendVariable(const QString variableName, const QString variableValue, const int variableType);
    void copy(CTestInfo &testInfo);

public slots:
    QString getValue(const QString variableName);
    bool setValue(const QString variableName, QString variableValue);

private:
    QList<QString> m_variableName;      //!< m_variableName is the list of variables (or results) names
    QList<QString> m_variableValue;     //!< m_variableValue is the list of variables (or results) values
    QList<int> m_variableType;          //!< m_variableType is the type (variable == 0, result = 1)

signals:
    void variableNameChanged();         //!< variableNameChanged signals that a variable name changed
    void variableValueChanged();        //!< variableValueChanged signals that a variable value changed
    void variableTypeChanged();         //!< variableTypeChanged signals that a variable type changed
    void nextTest();                    //!< nextTest when the software pass to the next test



};

#endif // CTESTINFO_H
