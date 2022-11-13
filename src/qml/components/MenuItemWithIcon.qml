// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../fontAwesome"

MenuItem {
    id: menuItem
    property alias imageName: theIcon.source
//    property alias itemText: theLabel.text
    focusPolicy: Qt.NoFocus
    contentItem:
        Row {
        topPadding: 0
        bottomPadding: 0
        spacing: 12
        FontAwesome {
            id: theIcon
        }

        LabelSubheading {
            id: theLabel
            text: ""
            anchors.verticalCenter: parent.verticalCenter
        }
    } // row
}
