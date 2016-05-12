import QtQuick 2.0
import Qt.labs.controls 1.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import "qrc:/thymio-ar" as AR
import "qrc:/storytelling"

Item {

//	AR.Vision {
//		id: vision
//		anchors.fill: parent

//		landmarkFileNames: [
//			":/assets/marker.xml"
//		]

//		Grotte {
//			id: grotte
//			enabled: false
//		}
//	}

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
			SystemSays { message: "Aim Thymio with the tablet" }
			// TODO: detect Thymio at the center of the screen, image is clearer when Thymio is at the center
			until: vision.robotPose !== vision.invalidPose
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
