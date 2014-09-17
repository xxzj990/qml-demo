#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "phoneutil.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    QQmlContext *context = engine.rootContext();
    PhoneUtil util;
    context->setContextProperty("appData", &util);

    return app.exec();
}
