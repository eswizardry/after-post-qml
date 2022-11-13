// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

MenuItem {
    id: menuItem
    property alias dotColor: theDot.color
    property alias itemText: theLabel.text
    focusPolicy: Qt.NoFocus
    contentItem:
        Row {
        topPadding: 0
        bottomPadding: 0
        spacing: 12
        Rectangle {
            id: theDot
            width: 16
            height: 16
            radius: width / 2
            color: "White"
            anchors.verticalCenter: parent.verticalCenter
        }
        LabelSubheading {
            id: theLabel
            text: ""
            anchors.verticalCenter: parent.verticalCenter
        }
    } // row
}
