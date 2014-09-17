#ifndef PHONEUTIL_H
#define PHONEUTIL_H

#include <QObject>
#include <QString>

class PhoneUtil : public QObject
{
    Q_OBJECT
public:

    Q_INVOKABLE QString getPhoneNumber();

};

#endif // PHONEUTIL_H
