#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "csequencer.h"

#define CONNECT     "Connect"
#define DISCONNECT  "Disconnect"


QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:
    void updateLabelConnectStatus(bool status);

private slots:
    void on_pushButtonServerIp_clicked();

    void on_pushButtonStartSession_clicked();

private:
    Ui::MainWindow *ui;
    CSequencer m_sequencer;

};
#endif // MAINWINDOW_H
