// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Controls 2.12

Row {
    property alias text: switchLabel.text
    property alias checked: theSwitch.checked
    leftPadding: 6
    LabelBody {
        id: switchLabel
        wrapMode: Text.WordWrap
        anchors.verticalCenter: parent.verticalCenter
    }
    Switch {
        id: theSwitch
        focusPolicy: Qt.NoFocus
        anchors.verticalCenter: parent.verticalCenter
    }
}
