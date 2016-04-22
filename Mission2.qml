import QtQuick 2.0
import QtQuick.Layouts 1.1
import Qt.labs.controls 1.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import "qrc:/thymio-ar" as AR
import "qrc:/storytelling"

Item {

	AR.Vision {
		id: vision
		anchors.fill: parent

		landmarkFileNames: [
			":/assets/marker.xml"
		]

		Entity {
			components: [
				SceneLoader {
					source: "/models/Grotte.qgltf"
				},
				Transform {
					scale: 0.001
					rotationX: 90
				}
			]
		}
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
			until: false // TODO: detect victory
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

			var left = leftY !== undefined ? 500 - (leftY * 1000 / height) : 0;
			var right = rightY !== undefined ? 500 - (rightY * 1000 / height) : 0;

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
				from: -500
				to: 500
			}
			Rectangle {
				Layout.fillWidth: true
			}
			Slider {
				id: motorRightTarget
				Layout.minimumHeight: parent.height / 2
				orientation: Qt.Vertical
				from: -500
				to: 500
			}
			Rectangle {
				width: parent.width / 5
			}
		}
	}

}
