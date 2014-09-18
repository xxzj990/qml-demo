#include "utils.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniObject>
#include <QtAndroid>
#include <QAndroidJniEnvironment>

QAndroidJniObject View;
QAndroidJniObject MIME;
QAndroidJniObject Subject;
QAndroidJniObject Text;
QAndroidJniObject Name;
QAndroidJniObject Str;
QAndroidJniObject intent("android/content/Intent");
QAndroidJniObject intent2;
#endif

void share(QString str)
{
#ifdef Q_OS_ANDROID
    View = QAndroidJniObject::fromString("android.intent.action.VIEW");
    MIME = QAndroidJniObject::fromString("text/plain");
    Subject = QAndroidJniObject::fromString("android.intent.extra.SUBJECT");
    Text = QAndroidJniObject::fromString("android.intent.extra.TEXT");
    Name = QAndroidJniObject::fromString("分享");
    Str = QAndroidJniObject::fromString(str);
    intent.callObjectMethod("addAction","(Ljava/lang/String;)Landroid/content/Intent;",View.object<jstring>());
    intent.callObjectMethod("setType","(Ljava/lang/String;)Landroid/content/Intent;",MIME.object<jstring>());
    intent.callObjectMethod("putExtra","(Ljava/lang/String;Ljava/lang/string;)Landroid/content/Intent;",Subject.object<jstring>(),
                            Name.object<jstring>());
    intent.callObjectMethod("putExtra","(Ljava/lang/String;Ljava/lang/string;)Landroid/content/Intent;",
                            Text.object<jstring>(),Str.object<jstring>());
    intent.callObjectMethod("setFlags","(I)Landroid/content/Intent;",268435456);
    intent2 = QAndroidJniObject::callStaticObjectMethod("android/content/Intent","createChooser",
                            "(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;",
                            intent.object<jobject>(),Name.object<jstring>());
    QtAndroid::startActivity(intent2,123456);
#else
    return;
#endif
}
