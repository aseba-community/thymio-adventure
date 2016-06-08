import QtQuick 2.6

Image  {
	id: image
	property real x1
	property real x2
	property real duration: 7000
	x: x1

	SequentialAnimation on x {
		loops: Animation.Infinite
		NumberAnimation {
			to: x2
			duration: image.duration
			easing.type: Easing.InOutSine
		}
		NumberAnimation {
			to: x1
			duration: image.duration
			easing.type: Easing.InOutSine
		}
	}
}
