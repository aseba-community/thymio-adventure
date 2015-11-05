#include <QApplication>
#include <QQmlApplicationEngine>
#include "thymio-ar/thymio-ar.h"

int main(int argc, char* argv[]) {
    QApplication app(argc, argv);

    thymioARInit();

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
