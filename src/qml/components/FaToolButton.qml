import QtQuick 2.12
import QtQuick.Controls 2.12

import "../fontAwesome"

ToolButton {
    property alias source: icon.source
    property alias iconOpacity: icon.opacity
    property alias iconColor: icon.color
    property alias iconStyle: icon.style

    implicitWidth: 50
    implicitHeight: 50

    contentItem: FontAwesome {
        id: icon
        anchors.fill: parent
    }
}
