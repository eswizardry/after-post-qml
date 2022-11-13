import QtQuick 2.12
import QtQuick.Controls 2.12

// Base for Page to reduce boilerplate
Page {
    // Use for navigate & reference if use as child of StackView
    property int myIndex: typeof(index) !== "undefined"? index: -1

    focus: true
    topPadding: 16
    bottomPadding: 0
    leftPadding: __unsafeArea.unsafeLeftMargin
    rightPadding: __unsafeArea.unsafeRightMargin

    Component.onCompleted: {
        currentTitle = title
        console.debug("Init done from ", objectName)
    }

    Component.onDestruction: {
        console.debug("Cleanup done ", objectName)
    }
}
