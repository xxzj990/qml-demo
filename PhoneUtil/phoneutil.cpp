#include <QString>
#include "phoneutil.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniObject>
#endif

QString PhoneUtil::getPhoneNumber() {
    QString phone;

#ifdef Q_OS_ANDROID
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod<jstring>("org.qtproject.qt5.android.bindings.MyActivity", "getPhoneNumber");
    phone = result.toString();
#endif

    return phone;
}
