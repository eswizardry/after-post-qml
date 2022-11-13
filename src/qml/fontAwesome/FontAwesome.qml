import QtQuick 2.12

import "../singletons"
import "fontAwesome.js" as Icon

Text {
    property string source: ""
    property int size: 16
    property alias style: text.style

    id: text
    font.pointSize: size
    font.family: Fonts.faIcons
    font.styleName: source.indexOf("-O") > 0? "Regular": "Solid"  // required to set this for android/iOS
    height: size
    width: size
    text: Icon.code[source] || ""
    color: "#FFFFFF"
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
