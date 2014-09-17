TEMPLATE = app

QT += qml quick widgets androidextras

SOURCES += main.cpp \
    phoneutil.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml \
    android/src/org/qtproject/qt5/android/bindings/MyActivity.java

HEADERS += \
    phoneutil.h
