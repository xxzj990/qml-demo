#include <QString>
#include <QDebug>
#include <QObject>
#include <QMap>
#include <QStringList>
#include <QMapIterator>
#include "phoneutil.h"
#include "Contactor.h"

QString PhoneUtil::getPhoneNumber() {
    QString phone;

#ifdef Q_OS_ANDROID
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod<jstring>("org/qtproject/qt5/android/bindings/MyActivity", "getPhoneNumber");
    phone = result.toString();
#endif

    return phone;
}

QString PhoneUtil::getAddressbook() {

    QString liststr;

#ifdef Q_OS_ANDROID
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/bindings/MyActivity", "getAddressbook", "()Ljava/util/Map;");
    qDebug() << "Get contact over.result=" + result.toString();

    QMap<QString, Contactor> pmap = jMap2QMap(result);
    QMapIterator<QString, Contactor> ite(pmap);

    liststr.append("[");
    while(ite.hasNext()) {
        ite.next();
        Contactor contactor = ite.value();
        QString item;
        item.append("{").append(contactor.name).append(": ").append(contactor.phone).append("},");
        liststr.append(item);
    }
    liststr.append("]");

#else
    qDebug() << "Not support for iOS contact.";
    liststr.append("Not support for iOS contact");
#endif

    return liststr;
}

QMap<QString, Contactor> PhoneUtil::jMap2QMap(QAndroidJniObject jMap) {
    QMap<QString, Contactor> myMap;

    // 拿到Collection
    QAndroidJniObject collection = jMap.callObjectMethod("values", "()Ljava/util/Collection;");

    // 拿到Iterator
    QAndroidJniObject iterator = collection.callObjectMethod("iterator", "()Ljava/util/Iterator;");

    // 取值
    while(iterator.callMethod<jboolean>("hasNext")==1 ? true : false) {
        QAndroidJniObject value = iterator.callObjectMethod("next", "()Ljava/lang/Object;");
        QAndroidJniObject name = value.callObjectMethod("getName", "()Ljava/lang/String;");
        QAndroidJniObject phone = value.callObjectMethod("getPhone", "()Ljava/lang/String;");
        qDebug() << "\n\rname:" << name.toString();
        qDebug() << "phone:" << phone.toString();

        Contactor *contactor = new Contactor();
        contactor->name = name.toString();
        contactor->phone = phone.toString();

        myMap.insert(contactor->phone, *contactor);
    }

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck()) {
        // Handle exception here.
        env->ExceptionClear();
    }

    return myMap;
}
