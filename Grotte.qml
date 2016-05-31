import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {
	components: [
		SceneLoader {
			source: "/models/Grotte.qgltf"
		},
		Transform {
			scale: 0.002
			rotationX: 90
		}
	]
}
