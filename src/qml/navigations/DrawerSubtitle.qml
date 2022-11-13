// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../singletons"

Item {
    height:24
    Label {
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 16
        font: Fonts.fontSubTitle
        opacity: myBar.inactiveOpacity
        text: modelData.name
    }
}


