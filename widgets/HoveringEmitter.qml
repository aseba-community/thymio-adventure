import QtQuick 2.6
import QtQuick.Particles 2.0

Item {
	id: emitter

	property ParticleSystem system
	property real startDepth
	property real deltaWidth
	property real emitRate
	property int lifeSpan
	property real velocityMagnitude
	property real accelerationMagnitude
	property real endSize

	Emitter {
		system: emitter.system
		group: "hovering1"
		x: emitter.deltaWidth / 2
		y: emitter.startDepth + 3.0 * size
		width: emitter.width - deltaWidth
		emitRate: emitter.emitRate
		lifeSpan: emitter.lifeSpan
		lifeSpanVariation: 0
		size: (endSize * width) / emitter.width
		endSize: emitter.endSize
		startTime: lifeSpan
		velocity: AngleDirection {
			angle: -90
			angleVariation: 2
			magnitude: velocityMagnitude
			magnitudeVariation: 0
		}
		acceleration: AngleDirection {
			angle: 90
			angleVariation: 0
			magnitude: accelerationMagnitude
			magnitudeVariation: 0
		}
	}
	Emitter {
		system: emitter.system
		group: "hovering2"
		x: emitter.deltaWidth / 2
		y: emitter.startDepth + 3.0 * size
		width: emitter.width - deltaWidth
		emitRate: emitter.emitRate
		lifeSpan: emitter.lifeSpan
		lifeSpanVariation: 0
		size: (endSize * width) / emitter.width
		endSize: emitter.endSize
		startTime: lifeSpan
		velocity: AngleDirection {
			angle: -90
			angleVariation: 2
			magnitude: velocityMagnitude
			magnitudeVariation: 0
		}
		acceleration: AngleDirection {
			angle: 90
			angleVariation: 0
			magnitude: accelerationMagnitude
			magnitudeVariation: 0
		}
	}
}
