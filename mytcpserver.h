#ifndef MYTCPSERVER_H
#define MYTCPSERVER_H

#include <QTcpServer>

#define TCP_PORT 2399

class MyTcpServer : public QTcpServer
{
    Q_OBJECT
public:
    explicit MyTcpServer(QObject *parent = 0);
    void startServer();
signals:

public slots:

protected:
    void incomingConnection(qintptr socketDescriptor);

};

#endif // MYTCPSERVER_H
