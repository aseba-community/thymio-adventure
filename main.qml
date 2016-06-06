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
							color: "white"
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
							// load/save dialog
							saveProgramDialog.isSave = save;
							saveProgramDialog.visible = true;
						} else {
							// link to a QML file
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
			spacing: 20

			Label {
				text: "Set Dashel target"
				font.weight: Font.Medium
				font.pointSize: 21
			}

			TextField {
				id: textInput
				implicitWidth: 280
			}

			RowLayout {
				spacing: 16
				Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

				Button {
					id: cancelButton
					text: "Cancel"
					onClicked: {
						dashelTargetSelector.close();
					}
				}

				Button {
					id: okButton
					text: "Ok"
					onClicked: {
						aseba.target = textInput.text;
						dashelTargetSelector.close();
					}
				}
			}
		}
	}

	Popup {
		id: saveProgramDialog
		x: (parent.width - width) / 2
		y: (parent.height - height) / 2
		modal: true
		focus: true
		closePolicy: Popup.OnEscape | Popup.OnPressOutside

		property bool isSave

		ListModel {
			id: programList
		}

		onVisibleChanged: {
			if (visible) {
				// update list of programs
				programList.clear();
				var foundCurrent = false;
				var programs = vplEditor.listPrograms();
				for (var i = 0; i < programs.length; ++i) {
					var name = programs[i].name;
					programList.append({ "name":  name });
					if (name === programName.text)
						foundCurrent = true;
				}
				if (!foundCurrent)
					programName.text = "";
			}
		}

		ColumnLayout {
			spacing: 16

			Label {
				text: saveProgramDialog.isSave ? "Save the program?" : "Load a program?"
				font.weight: Font.Medium
				font.pointSize: 21
			}

			Component {
				id: listHighlight
				Rectangle {
					color: Material.accentColor
					radius: 5
				}
			}

			ListView {
				id: list
				clip: true
				contentWidth: implicitWidth
				contentHeight: contentItem.childrenRect.height
				implicitHeight: saveProgramDialog.isSave ? 100 : 150
				implicitWidth: 300
				spacing: 8
				model: programList
				delegate: Label {
					text: name
					padding: 6
					width: parent.width
					MouseArea {
						anchors.fill: parent
						onClicked: {
							programName.text = parent.text;
							if (!saveProgramDialog.isSave) {
								list.currentIndex = index;
							}
						}
					}
				}
				highlight: saveProgramDialog.isSave ? null : listHighlight
			}

			TextField {
				id: programName
				anchors.left: parent.left
				anchors.right: parent.right
				visible: saveProgramDialog.isSave
			}

			RowLayout {
				spacing: 16
				Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

				Button {
					id: cancelButton2
					text: "Cancel"
					onClicked: saveProgramDialog.close()
				}

				Button {
					id: okButton2
					text: saveProgramDialog.isSave ? "Save" : "Load"
					enabled: programName.text !== ""
					onClicked: {
						if (saveProgramDialog.isSave) {
							vplEditor.saveProgram(programName.text);
						} else {
							vplEditor.loadProgram(programName.text);
						}
						saveProgramDialog.close();
					}
				}
			}
		}
	}

	AR.Aseba {
		id: aseba
	}

	AR.Thymio {
		id: thymio
		program: playing ? vplEditor.compiler.source : ""
		onNodeChanged: playing = false
	}
}
