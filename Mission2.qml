import QtQuick 2.0
import QtQuick.Layouts 1.1
import Qt.labs.controls 1.0
import "qrc:/thymio-ar"
import "qrc:/storytelling"

Item {
	readonly property Vision vision: vision

	readonly property int motorMin: -500
	readonly property int motorMax: 500

	property vector3d robotPos: landmark.pose.inverted().times(vision.robot.pose).times(Qt.vector3d(0, 0, 0))
	property vector3d targetCenter: Qt.vector3d(0, -0.5, 0)
	property real targetRadius: 0.1

	Thymio {
		variables : ({
			"motor.left.target": motorLeftTarget.value,
			"motor.right.target": motorRightTarget.value
		})
	}

	Vision {
		id: vision
		anchors.fill: parent
		landmarks: Landmark {
			id: landmark
			fileName: ":/assets/marker.xml"
			property string icon: "images/marker-312.png"
		}
	}

	Scene3d {
		anchors.fill: parent
		camera: landmark.pose
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

		mouseEnabled: false

		height: parent.height / 2
		width: parent.width
		anchors.verticalCenter: parent.verticalCenter

		onTouchUpdated: {
			var left = undefined;
			var right = undefined;
			for (var i = 0; i < touchPoints.length; ++i) {
				var point = touchPoints[i];
				if (point.startX < width / 2) {
					if (left === undefined) {
						left = motorMax - (point.y * (motorMax - motorMin) / height);
					}
				} else {
					if (right === undefined) {
						right = motorMax - (point.y * (motorMax - motorMin) / height);
					}
				}
			}

			motorLeftTarget.value = left || 0;
			motorRightTarget.value = right || 0;
		}

		RowLayout {
			anchors.fill: parent
			Rectangle {
				width: parent.width / 5
			}
			Slider {
				id: motorLeftTarget
				Layout.fillHeight: true
				orientation: Qt.Vertical
				from: motorMin
				to: motorMax
			}
			Rectangle {
				Layout.fillWidth: true
			}
			Slider {
				id: motorRightTarget
				Layout.fillHeight: true
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
