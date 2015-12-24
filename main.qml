import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtMultimedia 5.5
import "qrc:/thymio-ar" as AR

ApplicationWindow {
	title: qsTr("Thymio Adventure")
	visibility: Qt.platform.os === "android" ? Window.FullScreen : Window.Windowed
	visible: true
	width: 1280
	height: 720

	Loader {
		id: loader
		source: "ThymioVpl2Live.qml"
		anchors.fill: parent
	}

	AR.Aseba {
		id: aseba
	}
	Component.onCompleted: {
		aseba.start(Qt.platform.os === "android" ? "android:" : "tcp:localhost;33333")
	}
}
