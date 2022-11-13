import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import "../singletons"
import "../fontAwesome"

Pane {
    id: comboFake
    Material.elevation: 2
    property int currentIndex: -1
    property string displayText: qsTr("Please select")
    property string currentText: currentIndex < 0? displayText : model[currentIndex]
    property variant model: []
    padding: 0
    Layout.fillWidth: true
    Layout.preferredWidth : 1
    ItemDelegate {
        width: comboFake.width
        contentItem: Label {
            rightPadding: 16
            text: comboFake.currentText
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            font: Fonts.fontSubheading
        }
        FontAwesome {
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            source: "fa-caret-down"
            opacity: comboFake.enabled ? 1.0 : 0.3
            size: 24
        }
        background:
            Rectangle {
            color: "white"
        }
        onClicked: {
            theOptions.open()
        }
        Menu {
            id: theOptions
            implicitWidth: comboFake.width
            modal: true
            dim: false
            closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
            Repeater {
                id: theRepeater
                model: comboFake.model
                MenuItem {
                    implicitWidth: comboFake.width
                    contentItem: Text {
                        id: theOptionsText
                        text: comboFake.model[index]
                        color: index === comboFake.currentIndex? accentColor :  Material.foreground
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background:
                        Rectangle {
                        implicitHeight: 48
                        width: theOptions.width
                        color: index === comboFake.currentIndex? Material.listHighlightColor : Material.background
                    }
                    onTriggered: {
                        comboFake.currentIndex = index
                    }
                } // MenuItem
            } // repeater
            onAboutToShow: {
                appWindow.modalMenuOpen = true
            }
            onAboutToHide: {
                appWindow.modalMenuOpen = false
            }
        } // Menu
    } // itemDelegate
} // comboFake
