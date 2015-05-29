#include <QApplication>
#include <QQmlApplicationEngine>
#include "QZXing.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QZXing::registerQMLTypes();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
