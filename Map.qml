import QtQuick 2.6
import QtQuick.Particles 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/thymio-vpl2" as VPL2
import "widgets"

Rectangle {

	// background gradient
	gradient: Gradient {
		GradientStop {
			position: 0.00;
			color: "#0c0e57";
		}
		GradientStop {
			position: 0.66;
			color: "#17abbc";
		}
		GradientStop {
			position: 1.00;
			color: "#f7f8d1";
		}
	}

	// background clouds
	AnimatedImageX {
		x1: -30
		x2: 0
		y: 0
		width: parent.width + 30
		height: width * 0.310
		source: "images/map/clouds-back.png"
		duration: 7000
	}

	// the drawing of the map
	Item {
		width: 2827
		height: 2050
		transformOrigin: Item.BottomLeft
		// FIXME: cleanup computation of size of misison list at right-side of the screen
		scale: Math.min((parent.width - 200) / width, parent.height / height)
		anchors.bottom: parent.bottom

		// general particles

		ParticleSystem {
			id: particleSystem
		}

		HoveringImageParticle {
			source: "images/map/sustain-particle.png"
			system: particleSystem
			groups: "hovering1"
			z: -1
		}
		HoveringImageParticle {
			source: "images/map/sustain-particle-2.png"
			system: particleSystem
			groups: "hovering2"
			z: -1
		}
		HoveringVaporImageParticle {
			system: particleSystem
			groups: "hoveringVapor"
			z: 2
		}
		VaporImageParticle {
			system: particleSystem
			groups: "backVapor"
			z: -1
		}
		VaporImageParticle {
			system: particleSystem
			groups: "frontVapor"
			z: 2
		}
		VaporImageParticle {
			system: particleSystem
			groups: "volcanoVapor"
			source: "../images/map/vapor-particle-volcano.png"
			z: 2
		}
		ImageParticle {
			source: "images/map/snow-particle.png"
			system: particleSystem
			groups: "snow"
			z: 2
		}

		// islands

		AnimatedImageY {
			source: "images/map/island03.png"
			x: 1700
			duration: 4000
			y1: 40
			y2: 60

			HoveringEmitter {
				system: particleSystem
				x: 60
				y: 635
				width: 60
				deltaWidth: 40
				startDepth: 180
				emitRate: 14
				endSize: 80
				lifeSpan: 1000
				velocityMagnitude: 380
				accelerationMagnitude: 33
			}

			HoveringEmitter {
				system: particleSystem
				x: 610
				y: 560
				width: 60
				deltaWidth: 40
				startDepth: 190
				emitRate: 14
				endSize: 80
				lifeSpan: 1000
				velocityMagnitude: 380
				accelerationMagnitude: 33
			}

			HoveringEmitter {
				system: particleSystem
				x: 225
				y: 450
				width: 60
				deltaWidth: 40
				startDepth: 190
				emitRate: 14
				endSize: 80
				lifeSpan: 1000
				velocityMagnitude: 380
				accelerationMagnitude: 33
			}
		}

		AnimatedImageY {
			source: "images/map/island04.png"
			x: 300
			duration: 4000
			y1: 130
			y2: 110

			AnimatedImageX {
				x1: -78
				x2: -58
				y: 208
				source: "images/map/island04-blocks-left.png"
				duration: 4000
			}

			AnimatedImageX {
				x1: 640
				x2: 615
				y: 450
				source: "images/map/island04-blocks-right.png"
				duration: 4000
			}

			Emitter {
				system: particleSystem
				group: "snow"
				x: 70
				y: -160
				width: 770
				height: 200
				shape: EllipseShape {}
				emitRate: 9
				lifeSpan: 10500
				lifeSpanVariation: 500
				size: 6
				velocity: AngleDirection {
					angle: 90
					angleVariation: 5
					magnitude: 40
					magnitudeVariation: 5
				}
				acceleration: AngleDirection {
					angle: -180
					angleVariation: 5
					magnitude: 5
					magnitudeVariation: 2
				}
			}
			HoveringEmitter {
				system: particleSystem
				x: 180
				y: 774
				width: 230
				startDepth: 330
				deltaWidth: 140
				emitRate: 16
				endSize: 170
				lifeSpan: 2200
				velocityMagnitude: 430
				accelerationMagnitude: 40
			}
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 174
				y: 494
				width: 8
				height: 18
				shape: EllipseShape {}
				emitRate: 2
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 55
				endSize: 100
				sizeVariation: 16
				velocity: AngleDirection {
					angle: -175
					angleVariation: 10
					magnitude: 32
					magnitudeVariation: 9
				}
				acceleration: AngleDirection {
					angle: -155
					angleVariation: 9
					magnitude: 10
					magnitudeVariation: 3
				}
			}
			Emitter {
				system: particleSystem
				group: "backVapor"
				x: 482
				y: 484
				width: 8
				height: 18
				shape: EllipseShape {}
				emitRate: 2
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 70
				endSize: 140
				sizeVariation: 16
				velocity: AngleDirection {
					angle: 0
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -60
					angleVariation: 11
					magnitude: 9
					magnitudeVariation: 2
				}
			}
		}

		// middle clouds
		AnimatedImageX {
			x1: 0.1 * parent.width
			x2: -0.1 * parent.width
			y: 0.2 * parent.height
			width: parent.width * 1.2
			height: width * 0.346
			source: "images/map/clouds-middle.png"
			duration: 7000
		}

		AnimatedImageY {
			source: "images/map/island02.png"
			x: 1152
			duration: 5000
			y1: 780
			y2: 800

			Image {
				source: "images/map/island02-cascade-bottom-left.png"
				x: 299
				y: 1081
				z: -2
			}

			HoveringEmitter {
				system: particleSystem
				x: 238
				y: 1075
				width: 100
				deltaWidth: 60
				startDepth: 160
				emitRate: 20
				endSize: 100
				lifeSpan: 800
				velocityMagnitude: 600
				accelerationMagnitude: 60
			}

			HoveringEmitter {
				system: particleSystem
				x: 410
				y: 1062
				width: 290
				deltaWidth: 140
				startDepth: 150
				emitRate: 20
				endSize: 180
				lifeSpan: 1300
				velocityMagnitude: 600
				accelerationMagnitude: 60
			}

			HoveringEmitter {
				system: particleSystem
				x: 978
				y: 1004
				width: 250
				deltaWidth: 130
				startDepth: 200
				emitRate: 20
				endSize: 180
				lifeSpan: 1400
				velocityMagnitude: 600
				accelerationMagnitude: 60
			}

			Emitter {
				system: particleSystem
				group: "volcanoVapor"
				x: 338
				y: 13
				width: 140
				height: 30
				shape: EllipseShape {}
				emitRate: 9
				lifeSpan: 7000
				lifeSpanVariation: 2000
				size: 90
				endSize: 320
				sizeVariation: 60
				velocity: AngleDirection {
					angle: -90
					angleVariation: 15
					magnitude: 50
					magnitudeVariation: 15
				}
				acceleration: AngleDirection {
					angle: -155
					angleVariation: 13
					magnitude: 11
					magnitudeVariation: 3
				}
			}
			Emitter {
				system: particleSystem
				group: "volcanoVapor"
				x: 211
				y: 135
				width: 30
				height: 10
				shape: EllipseShape {}
				emitRate: 4
				lifeSpan: 7000
				lifeSpanVariation: 2000
				size: 50
				endSize: 160
				sizeVariation: 30
				velocity: AngleDirection {
					angle: -90
					angleVariation: 15
					magnitude: 25
					magnitudeVariation: 7
				}
				acceleration: AngleDirection {
					angle: -155
					angleVariation: 13
					magnitude: 6
					magnitudeVariation: 1
				}
			}
			Emitter {
				system: particleSystem
				group: "volcanoVapor"
				x: 591
				y: 128
				width: 20
				height: 10
				shape: EllipseShape {}
				emitRate: 3
				lifeSpan: 7000
				lifeSpanVariation: 2000
				size: 45
				endSize: 140
				sizeVariation: 26
				velocity: AngleDirection {
					angle: -90
					angleVariation: 15
					magnitude: 18
					magnitudeVariation: 6
				}
				acceleration: AngleDirection {
					angle: -152
					angleVariation: 13
					magnitude: 5
					magnitudeVariation: 1
				}
			}
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 600
				y: 917
				width: 30
				height: 30
				shape: EllipseShape {}
				emitRate: 3
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 60
				endSize: 130
				sizeVariation: 18
				velocity: AngleDirection {
					angle: 0
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -65
					angleVariation: 11
					magnitude: 8
					magnitudeVariation: 2
				}
			}
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 790
				y: 985
				width: 30
				height: 30
				shape: EllipseShape {}
				emitRate: 2
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 60
				endSize: 110
				sizeVariation: 16
				velocity: AngleDirection {
					angle: 0
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -35
					angleVariation: 11
					magnitude: 8
					magnitudeVariation: 2
				}
			}
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 1315
				y: 828
				width: 9
				height: 27
				shape: EllipseShape {}
				emitRate: 3
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 70
				endSize: 140
				sizeVariation: 16
				velocity: AngleDirection {
					angle: 0
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -35
					angleVariation: 11
					magnitude: 8
					magnitudeVariation: 2
				}
			}
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 183
				y: 1027
				width: 7
				height: 15
				shape: EllipseShape {}
				emitRate: 2
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 60
				endSize: 110
				sizeVariation: 16
				velocity: AngleDirection {
					angle: -175
					angleVariation: 10
					magnitude: 32
					magnitudeVariation: 9
				}
				acceleration: AngleDirection {
					angle: -160
					angleVariation: 9
					magnitude: 10
					magnitudeVariation: 3
				}
			}
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 1468
				y: 640
				width: 18
				height: 18
				shape: EllipseShape {}
				emitRate: 3
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 40
				endSize: 110
				sizeVariation: 16
				velocity: AngleDirection {
					angle: 0
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -65
					angleVariation: 11
					magnitude: 8
					magnitudeVariation: 2
				}
			}
			Emitter {
				system: particleSystem
				group: "backVapor"
				x: 1290
				y: 180
				width: 8
				height: 18
				shape: EllipseShape {}
				emitRate: 2
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 100
				endSize: 180
				sizeVariation: 16
				velocity: AngleDirection {
					angle: -20
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -60
					angleVariation: 11
					magnitude: 9
					magnitudeVariation: 2
				}
			}

			AnimatedSprite  {
				source: "images/map/island02-wave-volcano-left.png"
				frameCount: 23
				frameWidth: width
				frameHeight: height
				frameRate: 5
				x: 50
				y: 198
				width: 237
				height: 111
			}
			AnimatedSprite  {
				source: "images/map/island02-wave-center.png"
				frameCount: 23
				frameWidth: width
				frameHeight: height
				frameRate: 5
				x: 637
				y: 379
				width: 244
				height: 138
			}
			AnimatedSprite  {
				source: "images/map/island02-wave-volcano-right.png"
				frameCount: 23
				frameWidth: width
				frameHeight: height
				frameRate: 5
				x: 548
				y: 174
				width: 159
				height: 58
			}
			AnimatedSprite  {
				source: "images/map/island02-cascade-left.png"
				frameCount: 3
				frameWidth: width
				frameHeight: height
				frameRate: 10
				x: 0
				y: 305
				width: 111
				height: 115
			}
			AnimatedSprite  {
				source: "images/map/island02-cascade-volcano.png"
				frameCount: 3
				frameWidth: width
				frameHeight: height
				frameRate: 10
				x: 207
				y: 25
				width: 418
				height: 209
			}
		}

		AnimatedImageY {
			source: "images/map/island01.png"
			x: 151
			duration: 4000
			y1: 1020
			y2: 1040

			HoveringEmitter {
				system: particleSystem
				x: 325
				y: 836
				width: 310
				deltaWidth: 150
				startDepth: 150
				emitRate: 20
				endSize: 180
				lifeSpan: 1300
				velocityMagnitude: 600
				accelerationMagnitude: 60
			}

			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 243
				y: 687
				width: 9
				height: 27
				shape: EllipseShape {}
				emitRate: 3
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 70
				endSize: 140
				sizeVariation: 16
				velocity: AngleDirection {
					angle: -175
					angleVariation: 10
					magnitude: 32
					magnitudeVariation: 9
				}
				acceleration: AngleDirection {
					angle: -160
					angleVariation: 9
					magnitude: 10
					magnitudeVariation: 3
				}
			}
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 542
				y: 703
				width: 40
				height: 40
				shape: EllipseShape {}
				emitRate: 3
				lifeSpan: 5000
				lifeSpanVariation: 1000
				size: 60
				endSize: 130
				sizeVariation: 18
				velocity: AngleDirection {
					angle: 0
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -65
					angleVariation: 11
					magnitude: 8
					magnitudeVariation: 2
				}
			}
			Emitter {
				system: particleSystem
				group: "backVapor"
				x: 770
				y: 388
				width: 8
				height: 18
				shape: EllipseShape {}
				emitRate: 2
				lifeSpan: 4000
				lifeSpanVariation: 1000
				size: 70
				endSize: 140
				sizeVariation: 16
				velocity: AngleDirection {
					angle: -20
					angleVariation: 10
					magnitude: 30
					magnitudeVariation: 8
				}
				acceleration: AngleDirection {
					angle: -60
					angleVariation: 11
					magnitude: 9
					magnitudeVariation: 2
				}
			}
			Emitter {
				system: particleSystem
				group: "backVapor"
				x: 136
				y: 380
				width: 13
				height: 27
				shape: EllipseShape {}
				emitRate: 2
				lifeSpan: 4000
				lifeSpanVariation: 1000
				size: 90
				endSize: 140
				sizeVariation: 16
				velocity: AngleDirection {
					angle: -155
					angleVariation: 10
					magnitude: 32
					magnitudeVariation: 9
				}
				acceleration: AngleDirection {
					angle: -130
					angleVariation: 9
					magnitude: 10
					magnitudeVariation: 3
				}
			}

			AnimatedSprite  {
				source: "images/map/island01-wave-low.png"
				frameCount: 23
				frameWidth: width
				frameHeight: height
				frameRate: 5
				x: 90
				y: 500
				width: 523
				height: 112
			}
			AnimatedSprite  {
				source: "images/map/island01-wave-up.png"
				frameCount: 23
				frameWidth: width
				frameHeight: height
				frameRate: 5
				x: 423
				y: 327
				width: 154
				height: 147
			}
			AnimatedSprite  {
				source: "images/map/island01-cascade-low.png"
				frameCount: 3
				frameWidth: width
				frameHeight: height
				frameRate: 10
				x: 0
				y: 439
				width: 901
				height: 299
			}
			AnimatedSprite  {
				source: "images/map/island01-cascade-up.png"
				frameCount: 3
				frameWidth: width
				frameHeight: height
				frameRate: 10
				x: 514
				y: 299
				width: 64
				height: 65
			}
		}
	}

	// foreground clouds

	AnimatedImageX {
		x1: 0
		x2: -60
		anchors.bottom: parent.bottom
		width: parent.width + 60
		height: width * 0.234
		source: "images/map/clouds-front.png"
		duration: 7000
	}

	// list of missions

	ListModel {
		id: missionsList

		ListElement {
			name: qsTr("Hello, anyone?");
			source: "Mission1.qml";
			locked: false
			successRate: 2
		}
		ListElement {
			name: qsTr("Out of the cave");
			source: "Mission2.qml";
			locked: false
			successRate: 1
		}
		ListElement {
			name: qsTr("The platforms");
			source: "Mission3.qml";
			locked: false
			successRate: 0
		}
		ListElement {
			name: qsTr("lorem");
			source: "Mission2.qml";
			locked: true
			successRate: 0
		}
	}

	// view of liste of missions

	ListView {
		id: missionsView
		anchors.right: parent.right
		anchors.rightMargin: 20
		anchors.top: parent.top
		anchors.topMargin: 20
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 130
		width: 180
		spacing: 12

		model: missionsList
		delegate: Row {
			id: row
			spacing: 8
			padding: 0
			Button {
				id: control
				implicitWidth: 160
				text: missionsList.get(index).locked ? "<img src=\"qrc:/images/ic_lock_white_24px.svg\" />" :  index + '. ' + name
				background: Rectangle {
					color: control.highlighted ? "#30efff16" : "#30ffffff"
					border.color: control.highlighted ? "#a0efff16" : "#50ffffff"
					radius: 5
				}
				contentItem: Text {
					text: control.text
					font: control.font
					color: control.highlighted ? "#efff16" : Material.primaryTextColor
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					elide: Text.ElideRight
				}
				onClicked: missionsView.currentIndex = index;
				highlighted: row.ListView.isCurrentItem
			}
		}
	}

	// mission summary

	Pane {
		id: missionSummary
		anchors.right: parent.right
		anchors.rightMargin: 20
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20
		height: 70
		width: missionsView.width
		visible: missionsView.currentIndex !== -1

		background: Rectangle {
			color: "#30ffffff"
			border.color: "#50ffffff"
			radius: 5
		}
		Row {
			Repeater {
				model: 3
				VPL2.HDPIImage {
					source: (missionsView.currentIndex !== -1 && missionsList.get(missionsView.currentIndex).successRate > index) ?
						"images/ic_star_rate_yellow_18px.svg" :
						"images/ic_star_rate_white_18px.svg"
					width: 24
					height: 24
				}
			}
		}

		Button {
			anchors.right: parent.right
			width: 44
			height: 44
			background: Rectangle {
				color: "white"
				width: 44
				height: 44
				radius: 22
			}
			contentItem: VPL2.HDPIImage {
				source: "images/ic_play_arrow_black_24px.svg"
				width: 24
				height: 24
			}
			padding: 10
			leftPadding: padding
			rightPadding: padding
			onClicked: {
				if (missionsView.currentIndex !== -1) {
					loader.source = missionsList.get(missionsView.currentIndex).source;
				}
			}
		}
	}
}
