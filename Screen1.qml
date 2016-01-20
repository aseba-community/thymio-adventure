import QtQuick 2.1
import QtQuick.Scene3D 2.0
import "qrc:/thymio-ar" as AR

Item {
	AR.Vision {
		id: vision
		anchors.fill: parent
	}
	Scene3D {
		id: scene
		anchors.fill: parent
		Screen1Scene {
			aspectRatio: scene.width / scene.height
		}
	}
	Screen0 {
		anchors.fill: parent
	}
}
