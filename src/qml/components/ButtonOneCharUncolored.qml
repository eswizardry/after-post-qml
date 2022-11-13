// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "../singletons"

Button {
    id: characterButton
    property int buttonSize: 24
    text: "S"
    font: Fonts.fontDefault
    font.pointSize: buttonSize*3/4
    implicitWidth: buttonSize
    implicitHeight: buttonSize

    contentItem: Label {
        id: buttonLabel
        text: characterButton.text
        font: characterButton.font
        color: isDarkTheme? "black" : "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    } // content Label

    background: Rectangle {
        id: backgroundRectangle
        color: isDarkTheme? "lightgrey" : "darkgrey"
        radius: width / 2
    }
} // characterButton
