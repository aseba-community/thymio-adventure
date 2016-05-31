import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtMultimedia 5.5
import "qrc:/thymio-ar" as AR
import "qrc:/thymio-vpl2" as VPL2

ApplicationWindow {
	id: window
	title: qsTr("Thymio Adventure")
	visibility: Qt.platform.os === "android" ? Window.FullScreen : Window.Windowed
	visible: true
	width: 960
	height: 600

	property var vision: loader.item.vision !== undefined ? loader.item.vision : null
	property var vplEditor: loader.item.vplEditor !== undefined ? loader.item.vplEditor : null

	header: ToolBar {
		RowLayout {
			anchors.fill: parent

			ToolButton {
				contentItem: Image {
					anchors.centerIn: parent
					source: "images/ic_menu_white_24px.svg"
				}
				onClicked: drawer.open()
			}

			ToolButton {
				contentItem: Image {
					anchors.centerIn: parent
					source: !!thymio.node ? "images/ic_connection_on1_white_24px.svg" : "images/ic_connection_off_white_24px.svg"
				}
				onClicked: dashelTargetSelector.open()
			}

			Repeater {
				model: vision ? vision.landmarks : 0
				delegate: ToolButton {
					contentItem: Item {
						Image {
							source: modelData.icon
							height: parent.height * 0.8
							width: parent.height * 0.8
						}
						ProgressBar {
							width: parent.width
							to: 0.5
							value: modelData.confidence
							anchors.bottom: parent.bottom
						}
					}
				}
			}

			Label {
				id: compilationLabel
				text: {
					if (!vplEditor)
						return "";
					else  if (vplEditor.minimized)
						return "AR Running" ;
					else if (vplEditor.compiler.error === "")
						return "Compilation success";
					else
						return "Compilation error: " + vplEditor.compiler.error;
				}
				horizontalAlignment: Text.AlignHCenter
				font.pixelSize: 20
				elide: Label.ElideRight
				verticalAlignment: Text.AlignVCenter
				Layout.fillWidth: true
			}

			ToolButton {
				visible: !!vplEditor
				contentItem: Image {
					anchors.centerIn: parent
					source: !thymio.playing ? "images/ic_play_white_48px.svg" : "images/ic_stop_white_48px.svg"
				}
				enabled: !!vplEditor && (vplEditor.compiler.error === "") && (thymio.node !== undefined)
				onClicked: thymio.playing = !thymio.playing
			}

			ToolButton {
				visible: !!vplEditor
				contentItem: Image {
					anchors.centerIn: parent
					source: (!!vplEditor && vplEditor.minimized) ? "images/ic_edit_mode_white_24px.svg" : "images/ic_ar_mode_white_24px.svg"
				}
				onClicked: vplEditor.minimized = !vplEditor.minimized;
			}
		}
	}

	Rectangle {
		anchors.fill: parent
		color: "#200032"
	}

	Camera {
		id: camera
		captureMode: Camera.CaptureViewfinder
		//deviceId: QtMultimedia.availableCameras[1].deviceId // hack to use second camera on laptop
	}

	AR.Thymio {
		id: thymio
		program: playing ? vplEditor.compiler.source : ""
		onNodeChanged: playing = false
	}

	Loader {
		id: loader
		source: "Map.qml"
		//source: "ThymioVpl2Live.qml"
		//source: "Mission2.qml"
		anchors.fill: parent
	}

	ListModel {
		id: menuItems
		ListElement { title: qsTr("world map"); source: "Map.qml"; icon: "images/ic_map_white_24px.svg"}
		ListElement { title: qsTr("free play"); source: "Mission1.qml" ; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("save program"); source: "Mission2.qml" ; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("load program"); source: "Mission1.qml" ; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("about"); source: "ThymioVpl2Live.qml" ; icon: "images/ic_info_white_24px.svg" }

		//ListElement { title: "free play"; source: "ThymioVpl2Live.qml" }
		//ListElement { title: "help"; source: "ThymioVpl2Live.qml" }
		//ListElement { title: "about"; source: "ThymioVpl2Live.qml" }
	}

	Drawer {
		id: drawer
		edge: Qt.LeftEdge
		position: 0
		width: 280
		height: window.height

		contentItem: Pane {
			ListView {
				id: listView
				currentIndex: -1
				anchors.fill: parent

				model: menuItems

				delegate: ItemDelegate {
					contentItem: Row {
						spacing: 24
						VPL2.HDPIImage {
							source: icon
							width: 24
							height: 24
						}
						Text {
							text: model.title
							font.pixelSize: 14
							font.weight: Font.Medium
							color: "white"
						}
					}
					text: model.title
					highlighted: ListView.isCurrentItem
					onClicked: {
						if (listView.currentIndex != index) {
							listView.currentIndex = index;
							loader.source = source;
						}
						drawer.close()
					}

				}

				ScrollIndicator.vertical: ScrollIndicator { }
			}
		}
	}

	Popup {
		id: dashelTargetSelector
		x: (window.width - width) / 2
		y: window.height / 6
		modal: true
		focus: true
		closePolicy: Popup.OnEscape | Popup.OnPressOutside

		onVisibleChanged: {
			if (visible) {
				textInput.text = aseba.target;
			}
		}

		ColumnLayout {
			spacing: 16

			Label {
				text: "Change Dashel target"
				font.bold: true
			}

			TextField {
				id: textInput
				implicitWidth: 300
			}

			RowLayout {
				spacing: 16

				Button {
					id: okButton
					text: "Ok"
					onClicked: {
						aseba.target = textInput.text;
						dashelTargetSelector.close();
					}
				}

				Button {
					id: cancelButton
					text: "Cancel"
					onClicked: {
						dashelTargetSelector.close();
					}
				}
			}
		}
	}

	AR.Aseba {
		id: aseba
	}
}
