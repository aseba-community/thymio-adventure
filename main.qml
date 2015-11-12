import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtMultimedia 5.5
import "qrc:/thymio-ar" as AR

ApplicationWindow {
    title: qsTr("Thymio Adventure")
    visibility: Window.FullScreen
    visible: true

    Loader {
        id: loader
        source: "Screen0.qml"
        anchors.fill: parent
    }

    AR.Aseba {
        id: aseba
    }
    Component.onCompleted: {
        aseba.start("tcp:localhost;33333")
    }
}