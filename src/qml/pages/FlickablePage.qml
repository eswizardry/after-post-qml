import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Flickable {
    // Use for navigate & reference if use as child of StackView
    property int myIndex: typeof(index) !== "undefined"? index: -1
    property string title

    ScrollIndicator.vertical: ScrollIndicator { }

    Component.onCompleted: {
        currentTitle = title
        console.debug("Init done from ", objectName)
    }

    Component.onDestruction: console.debug("Cleanup done ", objectName)
}
