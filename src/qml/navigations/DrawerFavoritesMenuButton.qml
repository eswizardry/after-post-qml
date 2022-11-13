// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import "../singletons"
import "../fontAwesome"

ToolButton {
    Layout.alignment: Qt.AlignHCenter
    focusPolicy: Qt.NoFocus
    implicitHeight: 56
    implicitWidth: 56
    visible: isComfortNavigationStyle && ! isTabletInLandscape
    Column {
        spacing: 0
        topPadding: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 24
            width: 24
            FontAwesome {
                anchors.fill: parent
                verticalAlignment: Image.AlignTop
                anchors.horizontalCenter: parent.horizontalCenter
                source: "fa-bars"
            }
        }
    }
    onClicked: {
        openNavigationBar()
    }
}
