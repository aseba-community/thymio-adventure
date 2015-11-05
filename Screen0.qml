import QtQuick 2.0

Screen0Form {
    button1.onClicked: loader.source = "Screen1.qml"
    button2.onClicked: loader.source = "Screen2.qml"
    button3.onClicked: loader.source = "Screen3.qml"
}
