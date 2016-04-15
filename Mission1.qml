import QtQuick 2.0
import Qt.labs.controls 1.0
import "qrc:/thymio-ar" as AR
import "qrc:/storytelling"

Item {
	AR.Vision {
		id: vision
		anchors.fill: parent

		landmarkFileNames: [
			":/assets/marker.xml"
		]
	}

	property string playerName

	Dialogue {
		SystemSays { message: "Connecting..." }
		SystemSays { message: "Waiting for answer from parallel world…" }
		SystemSays { message: "Connection established, code name LEVIGO" }
		ThymioSays { message: "Is someone there?" }
		Choice {
			ThymioSays { message: "Hello, can anyone hear me?" }
			choices: ["Who is talking?"]
		}
		Wait {
			ThymioSays { message: "My name is Thymio, what is your name?" }
			TextField {
				anchors.centerIn: parent
				width: parent.width / 4
				color: "white"
				font.weight: Font.Black
				onAccepted: playerName = text
			}
			until: playerName !== ""
		}
		ThymioSays { message: "Nice to meet you " + playerName }
		ThymioSays { message: "The connection is… unstable…" }
		ThymioSays { message: "Please… synchronise… tablet… with me…" }
		Wait {
			SystemSays { message: "Aim Thymio with the tablet" }
			onVisibleChanged: if (visible) {
				console.warn("Here, we could have some small game. A synchronisation gauge appears on the side and fills up as long as you stay focused on Thymio. As soon as you let Thymio leave the centre of the screen, the gauge goes down. When it reaches 100%, the image become clear (we can have an effect like the more the gauge is complete, the clearer the image.");
			}
			until: vision.robotPose !== vision.invalidPose
		}
		ThymioSays { message: "Much better, thank you." }
		Choice {
			ThymioSays { message: "Do you know what I am?" }
			choices: ["Not really", "I guess"]
		}
		ThymioSays { message: "I am an exploration robot, or at least I think." }
		ThymioSays { message: "It seems that I am running in safe mode." }
		ThymioSays { message: "I cannot control my motors and I don’t see anything." }
		ThymioSays { message: "Would you help me?" }
		Wait {
			SystemSays { message: "Place marker number 1 on the center of the table and aim to it with the tablet" }
			until: vision.landmarkPoses[0] !== vision.invalidPose
		}
		ThymioSays { message: "The last thing I remember is entering in a cave." }
		ThymioSays {
			onVisibleChanged: if (visible) {
				console.warn("The cave materialises around Thymio in AR while the message appears.");
			}
			text: "Oh yeah, that’s it. A cave. It seems cold."
		}
	}

}
