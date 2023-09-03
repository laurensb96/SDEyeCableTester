#include "mythread.h"
#include "mybackend.h"

MyThread::MyThread(qintptr ID, QObject *parent) :
    QThread(parent)
{
    this->socketDescriptor = ID;
}

void MyThread::run()
{
    // thread starts here
    qDebug() << " Thread started";

    socket = new QTcpSocket();

    // set the ID
    if(!socket->setSocketDescriptor(this->socketDescriptor))
    {
        // something's wrong, we just emit a signal
        emit error(socket->error());
        return;
    }

    // connect socket and signal
    // note - Qt::DirectConnection is used because it's multithreaded
    //        This makes the slot to be invoked immediately, when the signal is emitted.

    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()), Qt::DirectConnection);
    connect(socket, SIGNAL(disconnected()), this, SLOT(disconnected()));

    // We'll have multiple clients, we want to know which is which
    qDebug() << socketDescriptor << " Client connected";

    // make this thread a loop,
    // thread will stay alive so that signal/slot to function properly
    // not dropped out in the middle when thread dies

    exec();
}

void MyThread::readyRead()
{
    // get the information
    QByteArray Data = socket->readAll();

    // will write on server side window
    qDebug() << socketDescriptor << " Data in: " << Data;

    QString s_data = QString(Data);
    QStringList sl_data, sl_tmp;
    qsizetype idx;

    QStringList alfabet = {"PWR1+","PWR1-","PWR2+","PWR2-","CTRL1","CTRL2","FIB1","FIB2"};
    QList<QStringList> sl_crossWiring;
    QList<QList<int>> crossWiring;
    QList<int> tmp;
    if(s_data.startsWith("CROSS"))
    {
        s_data = s_data.mid(5, s_data.length()-6);      // remove "CROSS" at start and "\n" at end, for further processing
        sl_data = s_data.split(",");                    // split at "," to create a list with wire pairs
        qDebug() << "Cross-wiring occurs between following pairs: " << sl_data;
        for (int i=0; i<sl_data.length();i++)
        {
            sl_tmp = sl_data[i].split("&");
            sl_crossWiring.append(sl_tmp);
        }
        qDebug() << "Cross-wiring occurs between following pairs: " << sl_crossWiring;
        for (int i=0; i<sl_crossWiring.length();i++)
        {
            tmp.append(alfabet.indexOf(sl_crossWiring[i][0]));
            tmp.append(alfabet.indexOf(sl_crossWiring[i][1]));
            if(tmp[0] > tmp[1])                         // swap so the first value is the lowest of the pair
            {
                tmp.swapItemsAt(0,1);
            }
            crossWiring.append(tmp);
            tmp = {};
        }
        qDebug() << "Cross-wiring occurs between following pair indices: " << crossWiring;
    }
    MyBackend *backend;
    backend = (MyBackend *) parent()->parent();
    backend->setArr(crossWiring);
    socket->write(Data);
}

void MyThread::disconnected()
{
    qDebug() << socketDescriptor << " Disconnected";


    socket->deleteLater();
    exit(0);
}
