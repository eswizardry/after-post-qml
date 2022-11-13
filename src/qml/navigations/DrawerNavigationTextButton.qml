// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../components"
import "../singletons"

ItemDelegate {
    id: myButton
    property bool isActive: index == navigationIndex
    property string myIconFolder: iconFolder
    property int counter: navigationData[index].counter
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    focusPolicy: Qt.NoFocus
    height: 48
    width: myBar.width

    // Material.buttonPressColor
    Rectangle {
        visible: highlightActiveNavigationButton && myButton.isActive
        height: myButton.height
        width: myButton.width
        color:  Material.listHighlightColor
    }

    Row {
        spacing: 0
        topPadding: 0
        leftPadding: 16
        rightPadding: modelData.showCounter? 24 :  16
        anchors.verticalCenter: parent.verticalCenter
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: modelData.name
            opacity: 0.87 // isActive? 1.0 : 0.7
            color: isActive? primaryColor : dividerColor // flatButtonTextColor
            font: Fonts.fontSubTitle
        } // label
    } // row
    Label {
        rightPadding: 16
        visible: modelData.showCounter
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        text: counter
        opacity: 0.87 // isActive? 1.0 : 0.7
        color: isActive? primaryColor : dividerColor // flatButtonTextColor
        font: Fonts.fontSubTitle
    } // label
    Rectangle {
        visible: modelData.showMarker
        anchors.right: parent.right
        width: 6
        height: parent.height
        color: navigationData[index].marker
    }

    onClicked: {
        navigationIndex = index
        closeNavigationBar()
    }
} // myButton
