#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "shareutil.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    // 将C++对象暴露给QML
    QQmlContext *contxet = engine.rootContext();
    ShareUtil util;
    contxet->setContextProperty("appData", &util);

    return app.exec();
}
