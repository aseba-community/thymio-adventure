import QtQuick 2.5
import "qrc:/thymio-ar" as AR

Item {
	AR.Vision {
		id: vision
		anchors.fill: parent

		landmarkFileNames: [
			":/assets/marker.xml"
		]

		Grotte {}
	}
}
