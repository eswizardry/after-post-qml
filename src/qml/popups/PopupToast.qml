// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../components"
import "../singletons"

Popup {
    id: popup
    closePolicy: Popup.NoAutoClose
    bottomMargin: isLandscape? 24 : 80
    x: (safeWidth - width) / 2
    y: (safeHeight - height)
    background: Rectangle{
        color: toastColor
        radius: 24
        opacity: toastOpacity
    }
    Timer {
        id: toastTimer
        interval: 3000
        repeat: false
        onTriggered: {
            popup.close()
        }
    } // toastTimer
    Label {
        id: toastLabel
        width: parent.width
        leftPadding: 16
        rightPadding: 16
        font: Fonts.fontSubheading
        color: "white"
        wrapMode: Label.WordWrap
    } // toastLabel
    onAboutToShow: {
        toastTimer.start()
    }
    function start(toastText) {
        toastLabel.text = toastText
        if(!toastTimer.running) {
            open()
        } else {
            toastTimer.restart()
        }
    } // function start
} // popup toastPopup
