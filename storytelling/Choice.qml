import QtQuick 2.0
import QtQuick.Controls 2.0

Wait {
	property var choices
	ListView {
		id: list
		anchors.centerIn: parent
		width: parent.width / 4
		model: choices.length
		delegate: Button {
			width: parent.width
			text: choices[index]
			onClicked: until = true
			Component.onCompleted: list.height += height
		}
	}
}
