import QtQuick 2.4
import QtQuick.Layouts 1.1
 import QtQuick.Controls 1.4
import "qrc:/thymio-vpl2"

Item {
	Thymio {
        variables : ({
            "motor.left.target": motorLeftTarget.value,
            "motor.right.target": motorRightTarget.value
        })
    }

    RowLayout {
        anchors.fill: parent
        Rectangle {
            Layout.fillWidth: true
            color: "black"
        }
        Slider {
            id: motorLeftTarget
            Layout.fillHeight: true
            orientation: Qt.Vertical
            minimumValue: -500
            maximumValue: 500
        }
        Rectangle {
            Layout.fillWidth: true
        }
        Slider {
            id: motorRightTarget
            Layout.fillHeight: true
            orientation: Qt.Vertical
            minimumValue: -500
            maximumValue: 500
        }
        Rectangle {
            Layout.fillWidth: true
        }
    }

    MultiPointTouchArea {
        anchors.fill: parent
        mouseEnabled: false

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

            motorLeftTarget.value = left;
            motorRightTarget.value = right;
        }
    }
}
