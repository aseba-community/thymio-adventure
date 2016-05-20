import QtQuick 2.6
import QtQuick.Window 2.2
//import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0
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

	property bool isVPLEditor: loader.item.vplEditor !== undefined

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
					source: "images/ic_connection_off_white_24px.svg"
				}
			}

			Label {
				id: compilationLabel
				text: loader.item.vplEditor.minimized ? "AR Running" : ( loader.item.vplEditor.compiler.error !== "" ? "Compilation error: " + loader.item.vplEditor.compiler.error : "Compilation success")
				//"<img src=\"qrc:/images/ic_menu_white_24px.svg\" /> Prelude to a new world <img src=\"qrc:/images/ic_menu_white_24px.svg\" />" : "Compilation success"
				//horizontalAlignment: arMode ? Text.AlignHCenter : Text.AlignLeft
				horizontalAlignment: Text.AlignHCenter
				font.pixelSize: 20
				elide: Label.ElideRight
				verticalAlignment: Text.AlignVCenter
				Layout.fillWidth: true
			}

			ToolButton {
				visible: isVPLEditor
				contentItem: Image {
					anchors.centerIn: parent
					source: "qrc:/images/ic_play_white_48px.svg"
				}
				onClicked: ; // TODO
			}

			ToolButton {
				visible: isVPLEditor
				contentItem: Image {
					anchors.centerIn: parent
					source: (isVPLEditor && loader.item.vplEditor.minimized) ? "images/ic_edit_mode_white_24px.svg" : "images/ic_ar_mode_white_24px.svg"
				}
				onClicked: loader.item.vplEditor.minimized = !loader.item.vplEditor.minimized;
			}
		}
	}

	Rectangle {
		anchors.fill: parent
		color: "#200032"
	}

	AR.Vision {
		id: vision
		anchors.fill: parent

		landmarkFileNames: [
			":/assets/marker.xml"
		]
	}

	Loader {
		id: loader
		source: "ThymioVpl2Live.qml"
		anchors.fill: parent
	}

	ListModel {
		id: menuItems
		ListElement { title: qsTr("world map"); source: "ThymioVpl2Live.qml"; icon: "images/ic_map_white_24px.svg"}
		ListElement { title: qsTr("free play"); source: "Mission1.qml" ; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("save program"); source: "Mission1.qml" ; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("load program"); source: "Mission1.qml" ; icon: "images/ic_freeplay_white_24px.svg" }
		ListElement { title: qsTr("about"); source: "Mission1.qml" ; icon: "images/ic_info_white_24px.svg" }

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

	AR.Aseba {
		id: aseba
	}
}
