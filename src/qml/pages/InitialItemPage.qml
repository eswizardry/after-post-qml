import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

import "../components"
import "../singletons"
import "../fontAwesome"

AppPage {
    objectName: "InitialItemPage"
    width: safeWidth

    LabelHeadline {
        id: initLabel
        anchors.left: parent.left
        anchors.right: parent.right
        topPadding: 12 + __unsafeArea.unsafeTopMargin
        wrapMode: Label.WordWrap
        horizontalAlignment: Qt.AlignHCenter
        text: qsTr("Welcome to\nAfter Post App.")
    }

    BusyIndicator {
        id: busyIndicator
        topPadding: 24
        property int size: Math.min(drawerNavStack.width, drawerNavStack.height) / 5
        implicitHeight: size
        implicitWidth: size
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: initLabel.bottom
    }

    LabelTitle {
        id: infoLabel
        anchors.top: busyIndicator.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        wrapMode: Label.WordWrap
        horizontalAlignment: Qt.AlignHCenter
        topPadding: 12
        color: primaryColor
    }

    LabelSubheading {
        id: progressLabel
        anchors.top: infoLabel.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        wrapMode: Label.WrapAnywhere
        topPadding: 6
        leftPadding: 16
        rightPadding: 16
        color: accentColor
    }

    Item {
        id: imageItem
        anchors.top: progressLabel.bottom
        property int size: Math.min(400, (drawerNavStack.width - 60))
        width: size
        FontAwesome {
            id: contentImage
            anchors.centerIn: parent
            size: 48
            source: "fa-shipping-fast"
        }
    }

    function showProgress(info) {
        progressLabel.text = info
    }

    function showInfo(info) {
        console.log("INFO: "+info)
        infoLabel.text = info
    }
}
