import QtQuick 2.0
import QtQuick.Controls 2.0
import "qrc:/thymio-vpl2" as VPL2
import "qrc:/thymio-ar" as AR

Item {
	id: live
	property alias vplEditor: editor
	property alias vision: _vision

	Component.onDestruction: {
		camera.stop();
	}

	AR.Vision {
		id: _vision
		landmarks: AR.Landmark {
			id: landmark
			fileName: ":/assets/marker.xml"
			property string icon: "images/marker-312.png"
		}
	}

	AR.Scene3d {
		anchors.fill: parent
		camera: landmark.pose
		lens: vision.lens
		robotPose: vision.robotPose
		Cave {}
		// TODO: add AR objects here for free play
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
