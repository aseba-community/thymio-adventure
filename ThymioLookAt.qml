import QtQuick 2.0
import "qrc:/storytelling"
import "qrc:/thymio-vpl2"

Wait {
	property bool poseOk
	property matrix4x4 pose
	property vector2d eye
	property vector2d center
	property vector2d direction: center.minus(eye)

	onEnabledChanged: if (enabled) {
		thymio.events = {
			"setMotorTarget": 2,
		};
		thymio.source =
		    "onevent setMotorTarget" + "\n" +
		    "motor.left.target = event.args[0]" + "\n" +
		    "motor.right.target = event.args[1]" + "\n";
	}

	Timer {
		interval: 100
		running: enabled
		repeat: true
		onTriggered: {
			if (!poseOk) {
				aseba.emit(0, [0, 0]);
				return;
			}

			// adapted from LonelyBuilder::descentGradient

			var currentEye = pose.times(Qt.vector4d(0, 0, 0, 1)).toVector2d();
			var currentDirection = pose.times(Qt.vector4d(0, 1, 0, 0)).toVector2d();
			var currentAngle = Math.atan2(currentDirection.y, currentDirection.x);

			var diffEye = eye.minus(currentEye);
			var distance = diffEye.length();
			var okPosition = distance < 0.01;

			var targetDirection = okPosition ? direction : diffEye;
			var targetAngle = Math.atan2(targetDirection.y, targetDirection.x);

			var diffAngle = targetAngle - currentAngle;
			if (diffAngle > Math.PI) {
				diffAngle -= 2 * Math.PI;
			} else if (diffAngle < -Math.PI) {
				diffAngle += 2 * Math.PI;
			}
			var diffAngleSquared = diffAngle * diffAngle;

			var left;
			var right;
			if (okPosition) {
				if (diffAngleSquared < 0.01) {
					// right direction
					left = 0;
					right = 0;
					until = true;
				} else {
					// wrong direction
					var speed = Math.max(-1, Math.min(diffAngle / Math.PI, 1));
					left = -speed;
					right = speed;
				}
			} else {
				if (diffAngleSquared < (Math.PI / 4) * (Math.PI / 4)) {
					// right direction
					var speed = Math.min(1, distance / 0.1);
					left = Math.min(1, speed - diffAngle / (Math.PI / 4));
					right = Math.min(1, speed + diffAngle / (Math.PI / 4));
				} else {
					// wrong direction
					var speed = Math.max(-1, Math.min(diffAngle / Math.PI, 1));
					left = -speed;
					right = speed;
				}
			}

			console.warn(okPosition, diffAngle, left, right);
			aseba.emit(0, [500 * left, 500 * right]);
		}
	}
}
