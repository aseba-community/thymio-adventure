import QtQuick 2.0

Item {
	anchors.fill: parent
	enabled: false

	property bool until

	onEnabledChanged: check()
	onUntilChanged: check()

	function check() {
		if (enabled && until) {
			parent.next();
		}
	}
}
