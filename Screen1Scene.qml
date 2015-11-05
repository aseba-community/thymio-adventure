import Qt3D 2.0
import Qt3D.Renderer 2.0

import QtQuick 2.1 as QQ2

Entity {
    id: sceneRoot
    property real aspectRatio

    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: sceneRoot.aspectRatio
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0.0, 0.0, -40.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    Configuration  {
        controlledCamera: camera
    }

    components: [
        FrameGraph {
            activeFrameGraph: Viewport {
                id: viewport
                rect: Qt.rect(0.0, 0.0, 1.0, 1.0) // From Top Left
                clearColor: Qt.rgba(0, 0, 0, 0)

                CameraSelector {
                    id : cameraSelector
                    camera: camera

                    ClearBuffer {
                        buffers : ClearBuffer.ColorDepthBuffer
                    }
                }
            }
        }
    ]

    PhongMaterial {
        id: material
    }

    SphereMesh {
        id: mesh
        radius: 10
    }

    TorusMesh {
        id: torusMesh
        radius: 5
        minorRadius: 1
        rings: 100
        slices: 20
    }

    Transform {
        id: torusTransform
        Scale { scale3D: Qt.vector3d(1.5, 1, 0.5) }
        Rotate {
            angle: 45
            axis: Qt.vector3d(1, 0, 0)
        }
    }

    Entity {
        components: [ torusMesh, material, torusTransform ]
    }

    Transform {
        id: fileTransform
        Scale {
            scale: 0.04
        }
        Translate {
            translation: Qt.vector3d(20, 0, 0)
        }
        Rotate {
            id: fileRotation
            axis: Qt.vector3d(0, 1, 0)
        }
    }
    QQ2.NumberAnimation {
        target: fileRotation
        property: "angle"
        duration: 10000
        from: 0
        to: 360

        loops: QQ2.Animation.Infinite
        running: true
    }

    Entity {
        components: [ mesh, material, fileTransform ]
    }
}
