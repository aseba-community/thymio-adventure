import QtQuick 2.0
import Qt.labs.controls 1.0
import "qrc:/thymio-vpl2" as VPL2
import "qrc:/thymio-ar" as AR

Item {
	id: live
	property alias vplEditor: editor

	Connections {
		target: aseba
		onUserMessage: {
			if (type === 0) {
				editor.execBlock(data[0], !!data[1]);
			} else if (type === 1) {
				editor.execLink(data[0], data[1]);
			}
		}
	}

	Connections {
		target: editor.compiler
		onSourceChanged: thymio.playing = false
	}

	VPL2.Editor {
		id: editor
		camera: vision.camera
		anchors.fill: parent
	}
}
