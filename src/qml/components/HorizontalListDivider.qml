// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3
import "../singletons"
// special divider for list elements
// using height 1 ensures that it looks good if highlighted
Item {
    height: 1
    //anchors.left: parent.left
    //anchors.right: parent.right
    Layout.fillWidth: true
    Rectangle {
        width: parent.width
        height: 1
        opacity: dividerOpacity
        color: dividerColor
    }
}
