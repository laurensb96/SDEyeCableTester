#ifndef MYBACKEND_H
#define MYBACKEND_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QString>
#include <QDebug>
#include <QList>

#include "mytcpserver.h"

class MyBackend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY(float val READ val WRITE setVal NOTIFY valChanged)
    Q_PROPERTY(bool appState READ appState WRITE setAppState NOTIFY appStateChanged)
    Q_PROPERTY(QList<QList<int>> arr READ arr WRITE setArr NOTIFY arrChanged)
public:
    explicit MyBackend(QObject *parent = nullptr);

    QString userName();
    int val();
    bool appState();
    QList<QList<int>> arr();

    void setUserName(const QString &userName);
    void setVal(float &val);
    void setAppState(bool &appState);
    void setArr(QList<QList<int>> arr);

signals:
    void userNameChanged();
    void valChanged();
    void appStateChanged();
    void arrChanged();

private:
    QString m_userName;
    float m_val;
    bool m_appState;
    MyTcpServer m_server;
    QList<QList<int>> m_arr;
};

#endif // MYBACKEND_H
