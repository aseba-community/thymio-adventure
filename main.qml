import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtMultimedia 5.5
import Qt.labs.settings 1.0
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
				model: (camera.cameraStatus === Camera.ActiveStatus && vision) ? vision.landmarks : 0
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

			VPL2.CompilationLabel {
				vplEditor: window.vplEditor
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
		cameraState: Camera.LoadedState
		//deviceId: QtMultimedia.availableCameras[1].deviceId // hack to use second camera on laptop
	}

	property rect cameraRect
	VideoOutput {
		id: videoOutput
		anchors.fill: parent
		source: camera
		filters: vision ? [ vision ] : []
		fillMode: VideoOutput.PreserveAspectCrop
		onContentRectChanged: cameraRect = mapNormalizedRectToItem(Qt.rect(0, 0, 1, 1));
	}

	Loader {
		id: loader
		source: "Mission1.qml"
		anchors.fill: parent

		Settings {
			property alias source: loader.source
		}
	}

	ListModel {
		id: menuItems

		ListElement { title: qsTr("world map"); source: "Map.qml"; icon: "images/ic_map_white_24px.svg"}
		ListElement { title: qsTr("free play"); source: "ThymioVpl2Live.qml" ; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("load program"); save: false; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("save program"); save: true; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("new program"); newProgram: true; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("about"); source: "About.qml" ; icon: "images/ic_info_white_24px.svg" }
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
							opacity: enabled ? 1.0 : 0.5
						}
						Text {
							text: model.title
							font.pixelSize: 14
							font.weight: Font.Medium
							color: Material.primaryTextColor
							opacity: enabled ? 1.0 : 0.5
						}
					}
					text: model.title
					highlighted: ListView.isCurrentItem
					enabled: {
						if (source === undefined) {
							// load/save
							return !!vplEditor;
						} else {
							// link to a QML file
							return (loader.source.toString().indexOf(source) === -1);
						}
					}
					onClicked: {
						if (source === undefined) {
							if (newProgram === true) {
								// new program
								vplEditor.clearProgram();
								saveProgramDialog.programName = "";
							} else {
								// load/save dialog
								saveProgramDialog.isSave = save;
								saveProgramDialog.visible = true;
							}
						} else {
							// link to a QML file, load this file
							if (listView.currentIndex != index) {
								listView.currentIndex = index;
								loader.source = source;
							}
						}
						drawer.close()
					}
				}

				ScrollIndicator.vertical: ScrollIndicator { }
			}
		}
	}

	VPL2.DashelTargetDialog {
		id: dashelTargetSelector
		aseba: aseba
	}

	VPL2.LoadSaveDialog {
		id: saveProgramDialog
		vplEditor: window.vplEditor
	}

	VPL2.Aseba {
		id: aseba
		onTargetChanged: console.log("target", target)
		onUserMessage: {
			if (type !== 0) {
				return;
			}
			if (vplEditor === undefined) {
				return;
			}
			vplEditor.compiler.execTransition(data[0], data[1]);
		}
	}

	VPL2.Thymio {
		id: thymio
		property bool playing: false
		events: vplEditor ? vplEditor.compiler.events : {}
		source: playing ? vplEditor.compiler.source : ""
		onNodeChanged: if (!playing) { playing = false; }
		onPlayingChanged: if (vplEditor !== undefined) { vplEditor.compiler.execReset(playing); }
		onErrorChanged: if (error !== "") { vplEditor.compiler.error = error; }
	}
}
