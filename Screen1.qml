import QtQuick 2.5
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import "qrc:/thymio-ar" as AR

Item {
	AR.Vision {
		id: vision
		anchors.fill: parent

		landmarkFileNames: [
			":/assets/marker.xml"
		]

		Entity {
			components: [
				CylinderMesh {
				},
				PhongMaterial {
					ambient: "red"
				},
				Transform {
					scale3D: Qt.vector3d(0.01, 0.1, 0.01)
					rotationY: 90
					translation: Qt.vector3d(0, 0.05, 0)
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
					translation: Qt.vector3d(0, 0, 0.05)
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
					translation: Qt.vector3d(0.05, 0, 0)
				}
			]
		}
		Entity {
			components: [
				SceneLoader {
					source: "/models/Grotte.qgltf"
				},
				Transform {
					scale: 0.0005
					rotationX: 90
				}
			]
		}
	}
}
