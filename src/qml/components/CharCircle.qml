// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "../singletons"

Item {
    id: charCircle
    property alias text: theLabel.text
    property alias color: theLabel.color
    property int size: 24
    width: size
    height: size
    Rectangle {
        id: charRectangle
        width: charCircle.size
        height: charCircle.size
        color: isDarkTheme? "lightgrey" : "darkgrey"
        radius: width / 2
        Label {
            id: theLabel
            anchors.centerIn: charRectangle
            text: "?"
            font: Fonts.fontDefault
            font.pointSize: charCircle.size*3/4
            color: isDarkTheme? "black" : "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}


