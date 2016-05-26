import QtQuick 2.6
import QtQuick.Particles 2.0
import "widgets"

Rectangle {
	color: "#808080"
	// the drawing of the map
	Item {
		anchors.centerIn: parent
		width: 2827
		height: 2050
		transformOrigin: Item.Center
		scale: Math.min(parent.width / width, parent.height / height)

		AnimatedImage {
			source: "images/map/island03.png"
			x: 1700
			duration: 4000
			y1: 40
			y2: 60
		}

		AnimatedImage {
			source: "images/map/island04.png"
			x: 200
			duration: 4000
			y1: 60
			y2: 40

			ParticleSystem {
				id: particleSystem
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
			Emitter {
				system: particleSystem
				group: "frontVapor"
				x: 274
				y: 536
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
				x: 580
				y: 526
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

		AnimatedImage {
			source: "images/map/island02.png"
			x: 1100
			duration: 5000
			y1: 780
			y2: 800

			ParticleSystem {
				VaporImageParticle {}
				Emitter {
					x: 390
					y: 15
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
					x: 263
					y: 138
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
					x: 643
					y: 131
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
					x: 652
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
					x: 840
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
					x: 1363
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
					x: 235
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
					x: 1520
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
			}
		}
	}
}
