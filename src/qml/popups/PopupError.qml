// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../components"
import "../singletons"
import "../fontAwesome"

Popup {
    id: popup
    closePolicy: Popup.NoAutoClose
    bottomMargin: isLandscape? 24 : 80
    implicitWidth: isLandscape? parent.width * 0.50 : parent.width * 0.80

    x: (safeWidth - implicitWidth) / 2
    y: (safeHeight - height)
    background: Rectangle{
        color: Material.color(Material.Red, isDarkTheme? Material.Shade500 : Material.Shade800)
        radius: 24
        opacity: toastOpacity
    }
    Timer {
        id: errorTimer
        interval: 3000
        repeat: false
        onTriggered: {
            popup.close()
        }
    } // toastTimer
    ColumnLayout {
        width: parent.width - 32
        Layout.fillWidth: true
        Layout.leftMargin: 16
        Layout.rightMargin: 16
        RowLayout {
            Layout.fillWidth: true
            spacing: 16
            FontAwesome {
                id: alarmIcon
                source: "fa-exclamation-triangle"
                size: 36
            }
            Label {
                id: errorLabel
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                rightPadding: 24
                font: Fonts.fontSubheading
                color: "white"
                // TODO Why is WordWrap ignored ?
                wrapMode: Label.WordWrap
            } // errorLabel
        }
    }




    onAboutToShow: {
        errorTimer.start()
    }
    function start(errorText) {
        errorLabel.text = errorText
        if(!errorTimer.running) {
            open()
        } else {
            errorTimer.restart()
        }
    } // function start
} // popup errorPopup
