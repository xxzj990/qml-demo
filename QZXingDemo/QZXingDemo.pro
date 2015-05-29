TEMPLATE = app

QT += qml quick widgets multimedia

SOURCES += main.cpp

RESOURCES += qml.qrc

DEFINES += NO_ICONV

CONFIG += qt warn_on debug_and_release

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

# QZXing
include(./QZXing/QZXing.pri)

