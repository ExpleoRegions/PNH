#include "ctestinfo.h"

/**
 * @brief CTestInfo class constructor
 * @overload
 * @param parent the initial value of the parent attribute
 */
CTestInfo::CTestInfo(QObject *parent)
    : QObject{parent}
{

}

/**
 * @brief Accessor for attribute m_variableName
 * @callergraph
 * @return the value of attribute m_variableName
 * @retval QVariantList the value of attribute m_variableName
 */
QVariantList CTestInfo::getVariableName() const
{
    QVariantList list;
    for(auto v: m_variableName)
        list.append(QVariant::fromValue(v));
    return list;
}

/**
 * @brief Accessor for attribute m_variableValue
 * @callergraph
 * @return the value of attribute m_variableValue
 * @retval QVariantList the value of attribute m_variableValue
 */
QVariantList CTestInfo::getVariableValue() const
{
    QVariantList list;
    for(auto v: m_variableValue)
        list.append(QVariant::fromValue(v));
    return list;
}

/**
 * @brief Accessor for attribute m_variableValue
 * @callergraph
 * @return the value of attribute m_variableValue
 * @retval QVariantList the value of attribute m_variableValue
 */
QVariantList CTestInfo::getVariableType() const
{
    QVariantList list;
    for(auto v: m_variableType)
        list.append(QVariant::fromValue(v));
    return list;
}

/**
 * @brief Add a new variable
 * @overload
 * @param variableName the variable name
 * @param variableValue the variable value
 * @param variableType the variable type
 */
void CTestInfo::appendVariable(const QString variableName, const QString variableValue, const int variableType)
{
    m_variableName.append(variableName);
    m_variableValue.append(variableValue);
    m_variableType.append(variableType);
}

/**
 * @brief Copy a variable
 * @overload
 * @param testInfo the testInfo to copy
 */
void CTestInfo::copy(CTestInfo &testInfo)
{
    m_variableName.clear();
    m_variableValue.clear();
    m_variableType.clear();

    for(auto v: testInfo.getVariableName())
        m_variableName.append(v.toString());

    for(auto v: testInfo.getVariableValue())
        m_variableValue.append(v.toString());

    for(auto v: testInfo.getVariableType())
        m_variableType.append(v.toInt());
}

/**
 * @brief get the value of the variable named variableName
 * @overload
 * @param variableName the the name of the variable
 * @retval QString the value of the variable
 */
QString CTestInfo::getValue(const QString variableName)
{
    for(int i=0; i <m_variableName.count(); i++)
    {
        if (m_variableName[i] == variableName)
            return m_variableValue[i];
    }
    return "";
}

/**
 * @brief set the value of the variable named variableName
 * @overload
 * @param variableName the the name of the variable
 * @param variableValue the new value of the variable
 */
bool CTestInfo::setValue(const QString variableName, QString variableValue)
{
    for(int i=0; i <m_variableName.count(); i++)
    {
        if (m_variableName[i] == variableName)
        {
            m_variableValue[i]= variableValue;
            //emit variableValueChanged();
            return true;
        }
    }
    return false;
}


//QMap<QString, QString> CTestInfo::getVariables() const
//{
//    QVariantList list;
//    for(auto v: m_variables)
//        list.append(QVariant::fromValue(v));
//    return list;
//}
