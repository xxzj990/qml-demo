#ifndef SHAREUTIL_H
#define SHAREUTIL_H

#include <QObject>
#include <QString>

class ShareUtil : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void shareText(QString message);

    Q_INVOKABLE bool share2WeChat(QString message);
};

#endif // SHAREUTIL_H
