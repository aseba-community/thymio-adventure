import QtQuick 2.0
import QtGraphicalEffects 1.0
import Qt.labs.controls 1.0
import "qrc:/thymio-ar" as AR
import "qrc:/storytelling"

Item {

	property vector3d robotPosition3d: vision.robotPose.times(Qt.vector3d(0, 0, 0))
	property vector2d robotPosition2d: robotPosition3d.toVector2d().times(1 / robotPosition3d.z)
	property real robotDistance: robotPosition2d.length()

	AR.Scene3d {
		anchors.fill: parent
		camera: vision.landmarkPoses[0]
		Grotte {
			id: grotte
			enabled: false
		}
	}

	Rectangle {
		id: blackScreen
		color: "black"
		anchors.fill: parent
	}

	Dialogue {
		// TODO: aseba connection
		// TODO: black screen
		SystemSays { message: "Connecting..." }
		SystemSays { message: "Waiting for answer from parallel world…" }
		SystemSays { message: "Connection established, code name LEVIGO" }
		ThymioSays { message: "Is someone there?" }
		Choice {
			onEnabledChanged: if (enabled) {
				blackScreen.visible = false;
				// TODO: spot light, blurred image
			}
			ThymioSays { message: "Hello, can anyone hear me?" }
			choices: ["Who is talking?"]
		}
		ThymioSays { message: "My name is Thymio." }
		ThymioSays { message: "The connection is… unstable…" }
		// TODO: The screen could blink, blur a bit more, freeze…
		ThymioSays { message: "Please… synchronise… tablet… with me…" }
		Wait {
			FastBlur {
				anchors.fill: parent
				source: vision
				radius: robotDistance * 64
			}
			SystemSays { message: "Aim Thymio with the tablet" }
			until: vision.robotPose !== vision.invalidPose && robotDistance < 0.1
		}
		// TODO: the screen becomes clear
		ThymioSays { message: "Much better, thank you." }
		Choice {
			ThymioSays { message: "Do you know what I am?" }
			choices: ["Not really"]
		}
		ThymioSays { message: "I am an exploration robot, or at least I think." }
		ThymioSays { message: "It seems that I am running in safe mode." }
		ThymioSays { message: "I cannot control my motors and I don’t see anything." }
		ThymioSays { message: "Would you help me?" }
		Wait {
			onEnabledChanged: if (enabled) {
				vision.calibrationRunning = true;
			}
			SystemSays { message: "Place marker number 1 on the center of the table and aim to it with the tablet" }
			ProgressBar {
				width: parent.width / 3
				anchors.bottom: parent.bottom
				anchors.bottomMargin: parent.height / 3
				anchors.horizontalCenter: parent.horizontalCenter
				value: vision.calibrationProgress
			}
			until: vision.calibrationDone
		}
		ThymioSays { message: "The last thing I remember is entering in a cave." }
		ThymioSays {
			onEnabledChanged: if (enabled) {
				grotte.enabled = true;
			}
			message: "Oh yeah, that’s it. A cave. It seems cold."
		}
	}

}
