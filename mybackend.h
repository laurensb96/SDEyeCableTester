#ifndef MYBACKEND_H
#define MYBACKEND_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QString>
#include <QDebug>


class MyBackend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY(float val READ val WRITE setVal NOTIFY valChanged)
public:
    explicit MyBackend(QObject *parent = nullptr);

    QString userName();
    int val();
    void setUserName(const QString &userName);
    void setVal(float &val);

signals:
    void userNameChanged();
    void valChanged();

private:
    QString m_userName;
    float m_val;
};

#endif // MYBACKEND_H
