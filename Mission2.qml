import QtQuick 2.0
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
		// TODO: control bars appear
		ThymioSays { message: "These bars control the motor of each of my motors." }
		// TODO: stop button appears
		ThymioSays { message: "Just in case, the stop button will stop both of my motors immediately." }
		ThymioSays { message: "Try to use them and get me out of this cave." }
		ThymioSays { message: "And please, don’t crash me into a wall…" }
		Wait {
			SystemSays { message: "<u>Objective</u>: Help Thymio out of this cave by driving it." }
			// TODO: enable controls
			// TODO: prevent crashes
			// * Watch out!
			// * Please, don’t crash me into a wall…
			// * That was close!
			// * Emergency stop!
			until: false // TODO: detect victory
		}
	}

}
