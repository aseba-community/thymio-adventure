import QtQuick 2.6
import QtQuick.Particles 2.0

ImageParticle {
	//source: "qrc:///particleresources/glowdot.png"
	source: "../images/map/vapor-particle.png"
	alpha: 0.8
	//color: "#586070" // "#606068"
	blueVariation: 0.02
	xVector: PointDirection {
		x: 1.2
		y: 0
		xVariation: 0.2
		yVariation: 0
	}
	yVector: PointDirection {
		x: 0
		y: 1.2
		xVariation: 0
		yVariation: 0.2
	}
	rotationVariation: 360
	rotationVelocity: 30
	rotationVelocityVariation: 30
}
