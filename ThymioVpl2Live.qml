import QtQuick 2.0
import QtQuick.Controls 2.0
import "qrc:/thymio-vpl2" as VPL2
import "qrc:/thymio-ar" as AR

Item {
	id: live
	property alias vplEditor: editor
	property alias vision: vision

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

	AR.Vision {
		id: vision
		landmarks: AR.Landmark {
			id: landmark
			fileName: ":/assets/marker.xml"
			property string icon: "images/marker-312.png"
		}
	}

	AR.Scene3d {
		anchors.fill: parent
		camera: landmark.pose
		Grotte {}
	}

	Connections {
		target: editor.compiler
		onSourceChanged: thymio.playing = false
	}

	VPL2.Editor {
		id: editor
		anchors.fill: parent
		onMinimizedChanged: {
			if (minimized)
				camera.start();
		}
		onMainContainerScaleChanged: {
			if (mainContainerScale === 1.0)
				camera.stop();
		}
	}
}
