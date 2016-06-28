import QtQuick 2.6
import QtQuick.Controls 2.0
import "qrc:/thymio-ar"
import "qrc:/storytelling"

Item {
	readonly property Vision vision: _vision

	// FIXME: move this feature of starting/stopping camera in its own file

	Component.onCompleted: {
		camera.start();
	}

	Component.onDestruction: {
		camera.stop();
	}

	Vision {
		id: _vision
		landmarks: Landmark {
			id: landmark
			fileName: ":/assets/marker.xml"
			property string icon: "images/marker-312.png"
		}
	}

	Scene3d {
		anchors.fill: parent
		camera: landmark.pose
		lens: vision.lens
		robotPose: vision.robotPose
	}

	Dialogue {
		ThymioSays { message: "I think I can control my motors again. Thank you." }
		ThymioSays { message: "You can control them too if you want. Just use this motor block." }
		// The motor block appears, it look like the columns used to drive Thymio in the cavern.
		// The world around Thymio changes and we see two moving platforms floating in the air.
		// Around them there is just void. Thymio has to go through there to continue.
		ThymioSays { message: "Do you see that?" }
		// If it is not the case, Thymio turns to face the moving platform.
		ThymioSays { message: "I don’t think I will be able to go through on my own." }
		Choice {
			ThymioSays { message: "Can you help me again?" }
			choices: ["Of course! What can I do?"]
		}
		ThymioSays { message: "It is just a question of good timing." }
		// The timer block appears and shows time going
		ThymioSays { message: "If you press on this icon, I will start moving forward." }
		ThymioSays { message: "If you press again, I will stop." }
		ThymioSays { message: "Move and stop me at the right time to stay on the moving platforms." }
		ThymioSays { message: "Don’t let me fall off the platforms!" }
		// During this phase, we could add some text from Thymio such as “Moving through!” when it moves and “stop!” when it stops.
		// If the user fails to stay on the platform, s-he needs to try again. In this case, there is a SYSTEM message such as “Place Thymio back on the border of the table”. And the script goes back to “Do you see that?”.
	}

}
