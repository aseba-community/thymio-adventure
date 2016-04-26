#include <QApplication>
#include <QQmlApplicationEngine>
#include "thymio-ar/thymio-ar.h"

int main(int argc, char* argv[]) {
    QApplication app(argc, argv);
	app.setOrganizationName("Thymio");
	app.setOrganizationDomain("thymio.org");
	app.setApplicationName("Thymio Adventure");

    thymioARInit();

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
