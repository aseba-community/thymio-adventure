import QtQuick 2.1
import QtQuick.Scene3D 2.0
import "qrc:/thymio-ar" as AR

Item {
    AR.Vision {
        id: vision
        anchors.fill: parent
    }
    Scene3D {
        anchors.fill: parent
        Screen1Scene {
            aspectRatio: parent.width / parent.height
        }
    }
    Screen0 {
        anchors.fill: parent
    }
}
