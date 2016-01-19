import QtQuick 2.0
import "qrc:/thymio-vpl2" as VPL2
import "qrc:/thymio-ar" as AR

Item {
	id: live

	AR.Thymio {
		id: thymio
		program: playing ? editor.compiler.source : ""
		onNodeChanged: playing = false
	}

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

	property bool playing: false

	Connections {
		target: editor.compiler
		onSourceChanged: playing = false
	}

	VPL2.FullEditor {
		id: editor
		anchors.fill: parent

		// run and stop
		Image {
			id: stateButton
			source: {
				if (editor.compiler.error !== "") {
					return "images/compilerError.svg";
				} else if (thymio.node === undefined) {
					return "images/connectingStatus.svg";
				} else if (playing) {
					return "images/stopButton.svg";
				} else {
					return "images/playButton.svg"
				}
			}

			width: 128
			height: 128
			anchors.top: parent.top
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.topMargin: 20

			MouseArea {
				anchors.fill: parent
				enabled: thymio.node !== undefined && editor.compiler.error === ""
				onClicked: playing = !playing
			}
		}
	}
}
