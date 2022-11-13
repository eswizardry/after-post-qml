// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../components"
import "../singletons"
import "../fontAwesome"

ToolButton {
    id: myButton
    property bool isActive: modelData == navigationIndex
    property string theIcon: navigationModel[modelData].icon
    property string theText: navigationModel[modelData].name
    Layout.alignment: Qt.AlignHCenter
    focusPolicy: Qt.NoFocus
    implicitHeight: 56
    // portrait or landscape without visible Drawer
    property int normalButtonWidth: (myBar.width - 56 - 6) / (favoritesModel.length)
    // landscape with visible Drawer
    property int tabletButtonWidth: 56
    implicitWidth: appWindow.isTabletInLandscape? tabletButtonWidth : normalButtonWidth
    Column {
        spacing: 0
        topPadding: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        FontAwesome {
            id: contentImage
            size: 24
            verticalAlignment: Image.AlignTop
            anchors.horizontalCenter: parent.horizontalCenter
            source: theIcon
            opacity: isActive? myBar.activeOpacity : myBar.inactiveOpacity

            ColorOverlay {
                id: colorOverlay
                visible: myButton.isActive
                anchors.fill: parent
                source: parent
                color: primaryColor
            }
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: theText
            opacity: isActive? 1.0 : 0.7
            color: isActive? primaryColor : flatButtonTextColor
            font: Fonts.fontActiveNavigationButton
        } // label
    } // column

    onClicked: {
        navigationIndex = modelData
    }
} // myButton
