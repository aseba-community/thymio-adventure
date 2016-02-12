import QtQuick 2.5
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import "qrc:/thymio-ar" as AR

Item {
	AR.Vision {
		id: vision
		anchors.fill: parent
		onRobotFoundChanged: console.warn(robotFound)

		Entity {
			components: [
				CylinderMesh {
				},
				PhongMaterial {
					ambient: "red"
				},
				Transform {
					scale3D: Qt.vector3d(0.01, 0.1, 0.01)
				}
			]
		}
		Entity {
			components: [
				CylinderMesh {
				},
				PhongMaterial {
					ambient: "green"
				},
				Transform {
					scale3D: Qt.vector3d(0.01, 0.1, 0.01)
					rotationX: 90
				}
			]
		}
		Entity {
			components: [
				CylinderMesh {
				},
				PhongMaterial {
					ambient: "blue"
				},
				Transform {
					scale3D: Qt.vector3d(0.01, 0.1, 0.01)
					rotationZ: 90
				}
			]
		}
	}

	Rectangle {
		color: "white"
		anchors.fill: grid
	}
	Grid {
		id: grid
		columns: 4
		Text { width: 300; text: vision.robotPose.m11 }
		Text { width: 300; text: vision.robotPose.m12 }
		Text { width: 300; text: vision.robotPose.m13 }
		Text { width: 300; text: vision.robotPose.m14 }
		Text { width: 300; text: vision.robotPose.m21 }
		Text { width: 300; text: vision.robotPose.m22 }
		Text { width: 300; text: vision.robotPose.m23 }
		Text { width: 300; text: vision.robotPose.m24 }
		Text { width: 300; text: vision.robotPose.m31 }
		Text { width: 300; text: vision.robotPose.m32 }
		Text { width: 300; text: vision.robotPose.m33 }
		Text { width: 300; text: vision.robotPose.m34 }
		Text { width: 300; text: vision.robotPose.m41 }
		Text { width: 300; text: vision.robotPose.m42 }
		Text { width: 300; text: vision.robotPose.m43 }
		Text { width: 300; text: vision.robotPose.m44 }
	}
}
