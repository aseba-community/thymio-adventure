import QtQuick 2.4
import QtQuick.Layouts 1.1
import "qrc:/thymio-ar" as AR

MultiPointTouchArea {
    anchors.fill: parent

    onTouchUpdated: {
        var leftY = undefined;
        var rightY = undefined;
        for (var i = 0; i < touchPoints.length; ++i) {
            var point = touchPoints[i];
            if (point.startX < width / 2) {
                if (leftY === undefined) {
                    leftY = point.sceneY;
                }
            } else {
                if (rightY === undefined) {
                    rightY = point.sceneY;
                }
            }
        }

        var left = leftY !== undefined ? 500 - (leftY * 1000 / height) : 0;
        var right = rightY !== undefined ? 500 - (rightY * 1000 / height) : 0;

        thymio.variables = {
            "motor.left.target": left,
            "motor.right.target": right
        };
    }

    AR.Thymio {
        id: thymio
    }
}
