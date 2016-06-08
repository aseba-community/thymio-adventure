import QtQuick 2.6

Image  {
	id: image
	property real y1
	property real y2
	property real duration: 7000
	y: y1

	SequentialAnimation on y {
		loops: Animation.Infinite
		NumberAnimation {
			to: y2
			duration: image.duration
			easing.type: Easing.InOutSine
		}
		NumberAnimation {
			to: y1
			duration: image.duration
			easing.type: Easing.InOutSine
		}
	}
}
