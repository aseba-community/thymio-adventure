import QtQuick 2.6
import QtQuick.Particles 2.0

ImageParticle {
	source: "../images/map/vapor-particle.png"
	alpha: 0.8
	blueVariation: 0.02
	xVector: PointDirection {
		x: 1.6
		y: 0
		xVariation: 0.2
		yVariation: 0
	}
}
