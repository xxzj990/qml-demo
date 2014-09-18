TEMPLATE = app

QT += qml quick widgets androidextras

SOURCES += main.cpp \
    utils.cpp \
    shareutil.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    utils.h \
    shareutil.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml \
    android/libs/libammsdk.jar \
    android/src/org/qtproject/qt5/android/bindings/MyActivity.java \
    android/src/org/qtproject/example/wxapi/WXEntryActivity.java
