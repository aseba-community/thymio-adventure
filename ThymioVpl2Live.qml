import QtQuick 2.0
import "qrc:/thymio-vpl2" as VPL2
import "qrc:/thymio-ar" as AR

Item {
    AR.Thymio {
		id: thymio
		program: editor.compiler.source
		onProgramChanged: console.warn(program)
    }

    VPL2.FullEditor {
		id: editor
        anchors.fill: parent
    }
}
