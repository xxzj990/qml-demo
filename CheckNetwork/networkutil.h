#ifndef NETWORKUTIL_H
#define NETWORKUTIL_H

#include <QObject>

class NetworkUtil : public QObject
{
    Q_OBJECT
public:

    /**
     * Check network available
     *
     * Only check network is open, date is available, do not judge.
     */
    Q_INVOKABLE bool isAvailable();

};

#endif // NETWORKUTIL_H
