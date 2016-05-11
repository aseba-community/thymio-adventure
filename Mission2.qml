import QtQuick 2.0
import QtQuick.Layouts 1.1
import Qt.labs.controls 1.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import "qrc:/thymio-ar" as AR
import "qrc:/storytelling"

Item {

	readonly property int motorMin: -500
	readonly property int motorMax: 500

	property vector3d robotPos: vision.landmarkPoses[0].inverted().times(vision.robotPose).times(Qt.vector3d(0, 0, 0))
	property vector3d targetCenter: Qt.vector3d(0, -0.5, 0)
	property real targetRadius: 0.1

	AR.Vision {
		id: vision
		anchors.fill: parent

		landmarkFileNames: [
			":/assets/marker.xml"
		]

		Grotte {}
	}

	Dialogue {
		// TODO: move erratically
		ThymioSays { message: "That’s a problem. It seems I don’t have a good control on my motors…" }
		ThymioSays { message: "… and I don’t see anything in here." }
		Choice {
			ThymioSays { message: "Could you lead me outside of this cave?" }
			choices: ["Yes, of course. What should I do?"]
		}
		ThymioSays { message: "It’s not hard for you." }
		ThymioSays {
			onEnabledChanged: if (enabled) {
				controls.visible = true
			}
			message: "These bars control the motors of each of my wheels."
		}
		ThymioSays { message: "Try to use them and get me out of this cave." }
		ThymioSays { message: "And please, don’t crash me into a wall…" }
		Wait {
			onEnabledChanged: if (enabled) {
				controls.enabled = true
			}
			SystemSays { message: "<u>Objective</u>: Help Thymio out of this cave by driving it." }
			// TODO: prevent crashes
			// * Watch out!
			// * Please, don’t crash me into a wall…
			// * That was close!
			// * Emergency stop!
			until: targetCenter.minus(robotPos).length() < targetRadius
		}
	}

	MultiPointTouchArea {
		id: controls
		visible: false
		enabled: false

		anchors.fill: parent
		mouseEnabled: false

		onTouchUpdated: {
			var leftY = undefined;
			var rightY = undefined;
			for (var i = 0; i < touchPoints.length; ++i) {
				var point = touchPoints[i];
				if (point.startX < width / 2) {
					if (leftY === undefined) {
						leftY = point.sceneY;
					}
				} else {
					if (rightY === undefined) {
						rightY = point.sceneY;
					}
				}
			}

			var left = leftY !== undefined ? motorMax - (leftY * (motorMax - motorMin) / height) : 0;
			var right = rightY !== undefined ? motorMax - (rightY * (motorMax - motorMin) / height) : 0;

			motorLeftTarget.value = left;
			motorRightTarget.value = right;
		}

		RowLayout {
			anchors.fill: parent
			Rectangle {
				width: parent.width / 5
			}
			Slider {
				id: motorLeftTarget
				Layout.minimumHeight: parent.height / 2
				orientation: Qt.Vertical
				from: motorMin
				to: motorMax
			}
			Rectangle {
				Layout.fillWidth: true
			}
			Slider {
				id: motorRightTarget
				Layout.minimumHeight: parent.height / 2
				orientation: Qt.Vertical
				from: motorMin
				to: motorMax
			}
			Rectangle {
				width: parent.width / 5
			}
		}
	}

}