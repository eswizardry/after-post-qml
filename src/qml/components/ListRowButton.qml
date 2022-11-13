// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Button {
    id: button
    focusPolicy: Qt.NoFocus
    anchors.fill: parent
    contentItem: Text {
        text: ""
    }
    background:
        Rectangle {
        color: button.pressed ? Material.listHighlightColor : "transparent"
        radius: 2
    } // background
} // button
