#include "cdatabasemanager.h"
#include <QDebug>
#include <QSqlQuery>
#include <QSqlRecord>
#include <qlist.h>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

/**
 * @brief CDataBaseManager class constructor
 * @overload
 * @param parent the initial value of the parent attribute
 */
CDataBaseManager::CDataBaseManager(QObject *parent)
    : QObject{parent}
{    
    m_dataBase = QSqlDatabase::addDatabase("QSQLITE");
    m_dataBase.setDatabaseName("./database/database.sqlite3");

    if (!m_dataBase.open())
    {
        qDebug() << "DataBase Open Error!";
    }

}

/**
 * @brief Provides the sequence list stored in the database
 * @overload
 * @param sequenceList The sequence list
 */
bool CDataBaseManager::getSequenceList(CSequenceList *sequenceList)
{
    sequenceList->getSequenceList()->clear();
    QSqlQuery querySL("SELECT * FROM Sequence_List");
    //QSqlRecord rec = querySL.record();
    int id_index = querySL.record().indexOf(ID);
    int name_index = querySL.record().indexOf(SEQUENCE_NAME);
    int comment_index = querySL.record().indexOf(COMMENT);
    int execute_index = querySL.record().indexOf(EXECUTE);

    int i_sequence = 0;
    while (querySL.next())
    {
        QString seqId = querySL.value(id_index).toString();
        QString seqName = querySL.value(name_index).toString();
        QString seqComment = querySL.value(comment_index).toString();
        bool seqExecute = false;
        if (querySL.value(execute_index).toString() == "TRUE")
            seqExecute = true;
        //QString test= sequenceList->getSequenceList().at(i_sequence).getSequenceName();

        CTestSequence* newSequence = new CTestSequence(seqName, seqComment, seqExecute);
        QSqlQuery queryS("SELECT * FROM " + newSequence->getSequenceName()); // TODO check if table exist
        int idSeq_index = queryS.record().indexOf(ID);
        int nameTestSeq_index = queryS.record().indexOf(TEST_NAME);
        int commentSeq_index = queryS.record().indexOf(COMMENT);


        while (queryS.next())
        {

//            QString param = queryS.value(nameTestSeq_index).toString();
//            QString value = queryS.value(commentSeq_index).toString();

            QString testId = queryS.value(idSeq_index).toString();
            QString testName = queryS.value(nameTestSeq_index).toString();
            QString testComment = queryS.value(commentSeq_index).toString();
            CTest* newTest = new CTest(testName, testComment);

            QSqlQuery queryT("SELECT * FROM " + testName); // TODO check if table exist

            int idTest_index = queryT.record().indexOf(ID);
            int param_index = queryT.record().indexOf(PARAM);
            int value_index = queryT.record().indexOf(VALUE);
            int type_index = queryT.record().indexOf(TYPE);

            CTestInfo* newTestInfo = new CTestInfo();
            while (queryT.next())
            {
                QString param = queryT.value(param_index).toString();
                QString value = queryT.value(value_index).toString();
                int type = queryT.value(execute_index).toInt();
                newTestInfo->appendVariable(param, value, type);
            }
            newTest->setTestInfo(newTestInfo);
            newSequence->getTestList().append(newTest);
        }
        bool test = newSequence->getExecute();
        sequenceList->getSequenceList()->append(newSequence);
        QString test2 =sequenceList->getSequenceList()->at(0)->getSequenceName();



        //sequenceList->getSequenceList()->append();
//        QSqlQuery query("SELECT * FROM " + name);
//        QSqlRecord rec = query.record();
//        int id_index = query.record().indexOf(ID);
//        int name_index = query.record().indexOf(SEQUENCE_NAME);
//        int comment_index = query.record().indexOf(COMMENT);
//        int execute_index = query.record().indexOf(EXECUTE);

    }
}




/**
 * @brief save a test results in the database
 * @overload
 * @param testInfo All parameters and results of the test
 * @param sessionName The name of the current session
 * @param sequenceName The name of the current sequence
 * @param testName The name of the current test
 * @param testResultName The name of the current test
 * @param primateName The name of the primate who did the test
 */
void CDataBaseManager::saveResults(CTestInfo &testInfo, QString sessionName, QString sequenceName, QString testName, QString testResultName, QString primateName)
{

//    primateName = "monkey8";
//    QString Sequence_Name = "Sequence8";
//    QString Test_Name = "Test7";
//    QString Test_Result_Name = "Test8_result";

    //INSERT INTO "main"."Session1" ("ID", "Date", "Primate_Name", "Sequence_Name", "Test_Name", "Test_Result_Name") VALUES ('3', '03/02/2022 20h00', 'monkey2', 'sequence1', 'Systeme1_Calibration', 'Systeme1_Calibration_030222_170025');
//    QSqlQuery queryAddActivity("INSERT INTO " + sessionName + " (ID, Date, Primate_Name, Sequence_Name, Test_Name, Test_Result_Name) VALUES ('4', '12/02/2022 20h00', 'monkey2', 'sequence1', 'Systeme1_Calibration', 'Systeme1_Calibration_030222_170025')");
//    QString res = queryAddActivity.executedQuery();

//    QSqlQuery query;
//    query.prepare("INSERT INTO Session1 (Date, Primate_Name, Sequence_Name, Test_Name, Test_Result_Name) "
//                   "VALUES ('" + QDateTime::currentDateTime().toString() + "', '" + primateName + "', '" + Sequence_Name + "', '" + Test_Name + "', '" + Test_Result_Name + "')");
//    query.exec();


    QSqlQuery queryInsert;
    queryInsert.prepare("INSERT INTO " + sessionName + " (Date, Primate_Name, Sequence_Name, Test_Name, Test_Result_Name) "
                   "VALUES (:Date, :Primate_Name, :Sequence_Name, :Test_Name, :Test_Result_Name)");
    queryInsert.bindValue(":Date", QDateTime::currentDateTime());
    queryInsert.bindValue(":Primate_Name", primateName);
    queryInsert.bindValue(":Sequence_Name", sequenceName);
    queryInsert.bindValue(":Test_Name", testName);
    queryInsert.bindValue(":Test_Result_Name", testResultName);
    queryInsert.exec();


    // create table test_result
    QSqlQuery queryCreate;
    queryCreate.prepare("CREATE TABLE " + testResultName + " ("
        "ID	INTEGER NOT NULL UNIQUE,"
        "Param	TEXT UNIQUE,"
        "Value	TEXT,"
        "Type	INTEGER,"
        "PRIMARY KEY(ID AUTOINCREMENT))");
    queryCreate.exec();

    // insert values
    for(int i=0; i <testInfo.getVariableName().count(); i++)
    {
            QString test = testInfo.getVariableValue().at(i).toString();
            QSqlQuery queryVar;
            queryVar.prepare("INSERT INTO " + testResultName + " (Param, Value, Type) "
                           "VALUES (:Param, :Value, :Type)");
            queryVar.bindValue(":Param", testInfo.getVariableName()[i]);
            queryVar.bindValue(":Value", testInfo.getVariableValue()[i]);
            queryVar.bindValue(":Type", testInfo.getVariableType()[i]);
            queryVar.exec();
    }

    for(int i=0; i <testInfo.getVariableName().count(); i++)
    {
        if (testInfo.getVariableType()[i] == 1) // type == result // todo use enum
        {
            QString test = testInfo.getVariableValue().at(i).toString();

        }
    }

//    QSqlQuery querySL("SELECT * FROM Sequence_List");
//    //QSqlRecord rec = querySL.record();
//    int id_index = querySL.record().indexOf(ID);
//    int name_index = querySL.record().indexOf(SEQUENCE_NAME);
//    int comment_index = querySL.record().indexOf(COMMENT);
//    int execute_index = querySL.record().indexOf(EXECUTE);

//    int i_sequence = 0;
//    while (querySL.next())
//    {


}

QString CDataBaseManager::SQLQuery(const QString &sqlquery)
{
    QSqlQuery query;
    query.setForwardOnly(true);
    if (!query.exec(sqlquery))
        return QString();

    QJsonDocument json;
    QJsonArray recordsArray;

    while (query.next()) {
        QJsonObject recordObject;
        for (int x = 0; x < query.record().count(); x++) {
            recordObject.insert(query.record().fieldName(x),
                                QJsonValue::fromVariant(query.value(x)));
        }
        recordsArray.push_back(recordObject);
    }
    json.setArray(recordsArray);

    return json.toJson();
}
