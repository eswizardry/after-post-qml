// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../singletons"
// you must imoplent function doCommunication() and Menus in main.qml !!
FloatingActionMiniButton {
    id: phoneButton
    property string phoneNumber: ""
    imageSource: "qrc:/images/"+iconOnPrimaryFolder+"/call.png"
    showShadow: true
    anchors.right: parent.right
    anchors.top: parent.top
    onClicked: {
        appWindow.doCommunication(phoneButton, phoneButton.phoneNumber)
    }
} // phoneButton
