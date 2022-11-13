// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../singletons"
import "../fontAwesome"

Button {
    id: button
    // default Image Size 24x24
    property alias imageName: theIcon.source
    property alias imageSize: theIcon.size
    focusPolicy: Qt.NoFocus
    contentItem: FontAwesome {
        id: theIcon
    }
    background:
        Rectangle {
        id: buttonBackground
        implicitHeight: imageSize + 24
        implicitWidth: imageSize + 24
        color: button.pressed ? accentColor : "transparent"
        opacity: button.pressed ? 0.12 : 1.0
    } // background
}
