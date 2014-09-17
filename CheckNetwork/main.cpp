#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "networkutil.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    QQmlContext *context = engine.rootContext();
    NetworkUtil util;
    context->setContextProperty("appData", &util);

    return app.exec();
}
