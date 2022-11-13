import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../singletons"

Item {
    property alias model: listView.model
    property alias delegate: listView.delegate
    property alias section: listView.section
    property alias emptyText: emptyText

    Layout.fillWidth: true
    Layout.fillHeight: true

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
    }

    Label {
        id: emptyText
        anchors.centerIn: parent
        color: textOnPrimary
        font: Fonts.fontTitle
        opacity: opacityToggleInactive
        visible : listView.model.count > 0? false: true
    }
}
