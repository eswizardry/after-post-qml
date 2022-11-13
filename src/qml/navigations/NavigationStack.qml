import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "../pages"

StackView {
    id: navStack
    property int myIndex: index
    objectName: "NavigationStack"

    initialItem: HomePage { }

    // triggered from BACK KEYs:
    // a) Android system BACK
    // b) Back Button from TitleBar
    function goBack() {
      // check if goBack is allowed
      navStack.pop()
    }

    Component.onCompleted: {
        init()
    }

    Component.onDestruction: {
        cleanup()
    }

    function init() {
        console.log("Init done from  ", objectName)
        console.log("MyIndex: ", myIndex)
    }
    function cleanup() {
        console.log("Cleanup done from  ", objectName)
    }
} // navStack
