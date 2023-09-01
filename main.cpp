#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDebug>

#include "mythread.h"
#include "mytcpserver.h"
#include "mybackend.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    qmlRegisterType<MyBackend>("laurens.mybackend", 1, 0, "MyBackend");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/CableTester/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    MyThread thread1("A"), thread2("B"), thread3("C");

    thread1.start();
    //thread2.start();
    //thread3.start();

    MyTcpServer server;

    qDebug() << "starting app...";

    return app.exec();
}
