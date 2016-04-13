import QtQuick 2.0

MouseArea {
	anchors.fill: parent

	property int state

	function next() {
		state += 1;
	}

	onClicked: {
		var child = children[state];
		if (child === undefined) {
			return;
		}
		if (child.until !== undefined) {
			return;
		}
		next();
	}

	onStateChanged: update();

	function update() {
		for (var i = 0; i < children.length; ++i) {
			var child = children[i];
			var enabled = i === state;
			child.visible = enabled;
			child.enabled = enabled;
			child.focus = enabled;
		}
	}

	Component.onCompleted: update()
}
