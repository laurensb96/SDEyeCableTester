#include "mybackend.h"

MyBackend::MyBackend(QObject *parent)
    : QObject{parent}
{

}

QString MyBackend::userName()
{
    return m_userName;
}

void MyBackend::setUserName(const QString &userName)
{
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

int MyBackend::val()
{
    return m_val;
}

void MyBackend::setVal(float &val)
{
    if (val == m_val)
        return;

    m_val = val;
    emit valChanged();
    qDebug() << "Value of dial: " << m_val;
}
