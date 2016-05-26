import QtQuick 2.6

Item  {
	id: image
	property real y1
	property real y2
	property real duration: 7000
	y: y1

	property alias source: internalImage.source
	width: internalImage.width
	height: internalImage.height

	Image {
		id: internalImage
	}

	SequentialAnimation on y {
		loops: Animation.Infinite
		NumberAnimation {
			to: image.y2
			duration: image.duration
			easing.type: Easing.InOutSine
		}
		NumberAnimation {
			to: image.y1
			duration: image.duration
			easing.type: Easing.InOutSine
		}
	}
}
