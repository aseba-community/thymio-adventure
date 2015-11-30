import QtQuick 2.0
import QtQuick.Controls 1.4
import "qrc:/thymio-ar" as AR

Item {
    AR.Thymio {
        id: thymio
        program: text.text
    }

    TextArea {
        id: text
        anchors.fill: parent
        font.family: "Mono"
    }
}
