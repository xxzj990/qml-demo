#ifndef PHONEUTIL_H
#define PHONEUTIL_H

#include <QObject>
#include <QString>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif

class Contactor;

class PhoneUtil : public QObject
{
    Q_OBJECT
public:

    Q_INVOKABLE QString getPhoneNumber();
    Q_INVOKABLE QString getAddressbook();

private:

    QMap<QString, Contactor> jMap2QMap(QAndroidJniObject jMap);

};

#endif // PHONEUTIL_H
