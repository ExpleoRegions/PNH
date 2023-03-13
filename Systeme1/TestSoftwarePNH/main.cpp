#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "CTestSoftware.h"
#include "ctcpserver.h"
#include "ctestinfo.h"
#include "csequencelist.h"
#include "cdatabasemanager.h"

#include <QQmlComponent>
#include <QQmlProperty>


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    CDataBaseManager dataBaseManager;
    CTestSoftware testSoftware;
    CTcpServer tcpServer(&dataBaseManager);
    tcpServer.startServer();

    QObject::connect(&testSoftware, &CTestSoftware::saveResultsToDataBase, &dataBaseManager, &CDataBaseManager::saveResults);

    //QMap<QString, QString> mapTestInfo = dataBaseManager.getTestAllParam("Test1");

    //CSequenceList sequenceList;
    //dataBaseManager.getSequenceList(&sequenceList);
    dataBaseManager.getSequenceList(testSoftware.getSequenceList());
    bool test = testSoftware.getSequenceList()->getSequenceList()->at(0)->getExecute();

    QString test3 = testSoftware.getSequenceList()->getSequenceList()->at(0)->getTestList().at(0)->getTestInfo()->getVariableName().at(0).toString();
    //testSoftware.nextTest();
//    CTestInfo testInfo;
//    for(auto i : mapTestInfo.toStdMap())
//    {
//      qDebug() << i.first << "," << i.second << '\n';
//      testInfo.m_variableName.append(i.first);
//      testInfo.m_variableValue.append(i.second);
//    }
//    testSoftware.setCurrentTestInfo(&testInfo);


    QString test2 = testSoftware.getCurrentTestInfo()->getValue("Color");
    engine.rootContext()->setContextProperty("testInfo", testSoftware.getCurrentTestInfo());
    engine.rootContext()->setContextProperty("testSoftware", &testSoftware);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


// utiliser plutot un signal
//    QQmlContext* ctx0 = engine.rootContext();
//    ctx0.
//    QObject *childObject = ctx0->findChild<QObject*>("loaderId");
//    childObject->setProperty("source", "file:./PNH_Test/test3.qml");

    return app.exec();
}
