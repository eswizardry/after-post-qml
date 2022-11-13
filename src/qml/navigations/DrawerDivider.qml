// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../singletons"

Item {
    // 8 above and 8 below divider between content
    height: 17
    anchors.left: parent.left
    anchors.right: parent.right
    // https://www.google.com/design/spec/components/dividers.html#dividers-types-of-dividers
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 1
        opacity: dividerOpacity
        color: dividerColor
    }
}
