import QtQuick 2.6
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import "qrc:/thymio-ar"
import "qrc:/storytelling"

Item {
	readonly property Vision vision: vision

	property vector3d robotPosition3d: vision.robot.pose.times(Qt.vector3d(0, 0, 0))
	property vector2d robotPosition2d: robotPosition3d.toVector2d().times(1 / robotPosition3d.z)
	property real robotDistance: robotPosition2d.length()

	// FIXME: move this feature of starting/stopping camera in its own file

	Component.onCompleted: {
		camera.start();
	}

	Component.onDestruction: {
		camera.stop();
	}

	Vision {
		id: vision
		landmarks: Landmark {
			id: landmark
			fileName: ":/assets/marker.xml"
			property string icon: "images/marker-312.png"
		}
	}

	Scene3d {
		anchors.fill: parent
		camera: landmark.pose
		Cave {
			id: cave
			enabled: false
		}
	}

	Rectangle {
		id: blackScreen
		color: "black"
		anchors.fill: parent
	}

	Rectangle {
		visible: vision.calibrationRunning

		x: cameraRect.x  + (vision.calibrationRight ? cameraRect.width - cameraRect.height : 0)
		y: cameraRect.y
		height: cameraRect.height
		width: cameraRect.height
		opacity: 0.5

		transform: [
			Scale {
				xScale: 1 / cameraRect.height
				yScale: 1 / cameraRect.height
			},
			Matrix4x4 {
				matrix: vision.calibrationTransform
			},
			Scale {
				xScale: cameraRect.height
				yScale: cameraRect.height
			}
		]
	}

	Dialogue {
		// TODO: aseba connection
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
				source: videoOutput
				radius: vision.robot.found ? robotDistance * 64 : 128
			}
			SystemSays { message: "Aim Thymio with the tablet" }
			until: vision.robot.found && robotDistance < 0.1
		}
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
				cave.enabled = true;
			}
			message: "Oh yeah, that’s it. A cave. It seems cold."
		}
	}

}
