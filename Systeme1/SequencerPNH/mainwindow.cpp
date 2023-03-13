#include "mainwindow.h"
#include "./ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->labelConnectImage->setPixmap(QPixmap("./img/red.png"));

    // connect
    connect(&m_sequencer, SIGNAL(updateLabelConnectStatus(bool)),this, SLOT(updateLabelConnectStatus(bool)));

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::updateLabelConnectStatus(bool status)
{
    if (status)
    {
        ui->labelConnectImage->setPixmap(QPixmap("./img/green.png"));
        ui->pushButtonServerIp->setText(DISCONNECT);
    }
    else
    {
        ui->labelConnectImage->setPixmap(QPixmap("./img/red.png"));
        ui->pushButtonServerIp->setText(CONNECT);
    }

    ui->lineEditServerIp->setEnabled(!status);
}


void MainWindow::on_pushButtonServerIp_clicked()
{
    if (!m_sequencer.isConnected())
        m_sequencer.connection(ui->lineEditServerIp->text());
    else
    {
         bool ret = m_sequencer.disconnection();
         updateLabelConnectStatus(!ret);
    }
}


void MainWindow::on_pushButtonStartSession_clicked()
{

}

