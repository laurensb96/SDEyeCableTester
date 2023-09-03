#include "mybackend.h"

MyBackend::MyBackend(QObject *parent)
    : QObject{parent}
{

}

QString MyBackend::userName()
{
    return m_userName;
}

int MyBackend::val()
{
    return m_val;
}

bool MyBackend::appState()
{
    return m_appState;
}

QList<QList<int>> MyBackend::arr()
{
    return m_arr;
}

void MyBackend::setUserName(const QString &userName)
{
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

void MyBackend::setVal(float &val)
{
    if (val == m_val)
        return;

    m_val = val;
    emit valChanged();
    qDebug() << "Value of dial: " << m_val;
}

void MyBackend::setAppState(bool &appState)
{
    if (appState == m_appState)
        return;

    m_appState = appState;
    emit appStateChanged();

    if (m_appState)
    {
        qDebug() << "Page has been rendered...";
        m_server.setParent(this);
        m_server.startServer();
    }
}

void MyBackend::setArr(QList<QList<int>> arr)
{
    if (arr == m_arr)
        return;

    m_arr = arr;
    emit arrChanged();
}
