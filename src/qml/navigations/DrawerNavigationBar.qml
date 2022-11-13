// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../components"
import "../fontAwesome"

Drawer {
    id: myBar
    z: 1
    topMargin: __unsafeArea.unsafeTopMargin
    topPadding: 0
    leftPadding: __unsafeArea.unsafeLeftMargin
    property alias navigationButtons: navigationButtonRepeater
    property real activeOpacity: iconFolder == "black" ?  0.87 : 1.0
    property real inactiveOpacity: iconFolder == "black" ?  0.56 : 0.87 //  0.26 : 0.56
    width: appWindow.drawerWidth
    height: appWindow.height
    interactive: !appWindow.modalMenuOpen && !appWindow.backKeyfreezed && !appWindow.modalPopupActive && !appWindow.isTabletInLandscape
    modal: !appWindow.isTabletInLandscape
    position: !appWindow.isTabletInLandscape ? 0 : 1
    visible: appWindow.isTabletInLandscape

    Flickable {
        contentHeight: myButtons.height
        anchors.fill: parent
        clip: true
        ColumnLayout {
            id: myButtons
            focus: false
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
            Item {
                //anchors.left: parent.left
                //anchors.right: parent.right
                Layout.fillWidth: true
                height: 120
                Rectangle {
                    anchors.fill: parent
                    color: primaryColor
                }
                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 56
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 16
                        rightPadding: 16
                        LabelBody {
                            text: "AfterPost\nParcel tracking"
                            wrapMode: Text.WordWrap
                            font.weight: Font.Medium
                            color: textOnPrimary
                        }
                        LabelBody {
                            text: "@eswizardry\n"
                            color: textOnPrimary
                        }
                    }
                }
                Item {
                    // space between content - see google material guide
                    height: 8
                }
                Row {
                    x: 16
                    y: 12

                    Item {
                        width: 64
                        height: 64
                        FontAwesome {
                            source: "fa-truck-loading"
                            size: 24
                        }
                    }
                    Item {
                        width: 64
                        height: 64
                        FontAwesome {
                            source: "fa-shipping-fast"
                            size: 24
                        }
                    }
                    Item {
                        width: 64
                        height: 64
                        FontAwesome {
                            source: "fa-plane-departure"
                            size: 24
                        }
                    }
                }
            }
            Item {
                // space between content - see google material guide
                height: 8
            }
            Repeater {
                id: navigationButtonRepeater
                model: navigationModel
                Loader {
                    Layout.fillWidth: true
                    source: modelData.type
                    active: true
                }
            } // repeater
            //
        } // ColumnLayout myButtons
        ScrollIndicator.vertical: ScrollIndicator { }

    } // Flickable

    function replaceIcon(position, theIconName) {
        navigationButtonRepeater.itemAt(position).item.theIcon = theIconName
    }
    function replaceText(position, theText) {
        navigationButtonRepeater.itemAt(position).item.theText = theText
    }

} // drawer
