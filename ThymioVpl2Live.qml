import QtQuick 2.0
import "qrc:/thymio-vpl2" as VPL2
import "qrc:/thymio-ar" as AR

Item {
    AR.Thymio {
		id: thymio
		program: editor.compiler.source
		onProgramChanged: console.warn(program)

		Connections {
			target: aseba
			onUserMessage: {
				if (type === 0) {
					editor.execBlock(data[0]);
				} else if (type === 1) {
					editor.execLink(data[0], data[1]);
				}
			}
		}
    }

    VPL2.FullEditor {
		id: editor
        anchors.fill: parent
    }
}
