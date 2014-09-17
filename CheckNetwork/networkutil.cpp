#include <QList>
#include <QHostAddress>
#include <QNetworkInterface>
#include <QString>
#include "networkutil.h"

bool NetworkUtil::isAvailable() {
    QList<QNetworkInterface> ifaces = QNetworkInterface::allInterfaces();
    bool result = false;

    for (int i = 0; i < ifaces.count(); i++)
    {
        QNetworkInterface iface = ifaces.at(i);
        if ( iface.flags().testFlag(QNetworkInterface::IsUp)
             && !iface.flags().testFlag(QNetworkInterface::IsLoopBack) )
        {

            // details of connection
            qDebug() << "name:" << iface.name();
            qDebug() << " mac:" << iface.hardwareAddress();

            // this loop is important
            for (int j=0; j<iface.addressEntries().count(); j++)
            {
                qDebug() << iface.addressEntries().at(j).ip().toString()
                         << "/" << iface.addressEntries().at(j).netmask().toString();

                // we have an interface that is up, and has an ip address
                // therefore the link is present

                // we will only enable this check on first positive,
                // all later results are incorrect
                if (result == false)
                    result = true;
            }
        }
    }
    return result;
}
