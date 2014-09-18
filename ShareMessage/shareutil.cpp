#include <QDebug>
#include <QString>
#include "shareutil.h"
#include "utils.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniObject>
#endif

void ShareUtil::shareText(QString message) {
    share(message);
}

bool ShareUtil::share2WeChat(QString message) {
    bool shareOK = false;

#ifdef Q_OS_ANDROID
    QAndroidJniObject javaMessage = QAndroidJniObject::fromString(message);
    jboolean result = QAndroidJniObject::callStaticMethod<jboolean>("org/qtproject/qt5/android/bindings/MyActivity",
                                                                    "share2WeChat",
                                                                    "(Ljava/lang/String;)Z",
                                                                    javaMessage.object<jstring>());
    qDebug() << "Call share2WeChat result=" << result;
    shareOK = result;
#else
    qDebug() << "Call share2WeChat only for Android.";
    shareOK = false;
#endif

    return shareOK;
}
