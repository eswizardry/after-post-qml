import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "../singletons"

ToolButton {
    property alias titleText: titleText.text
    property alias detailText: detailText.text
    property alias iconSource: icon.source
    property alias iconColor: icon.iconColor
    property alias badgeValue: badgeValue.text

    property int myIndex: index
    signal selected

    width: parent.width
    height: col.height * 1.5
    hoverEnabled: false

    ColumnLayout {
        id: col
        width: parent.width
        height: row.height

        RowLayout {
            id: row
            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
            FaButton {
                id: icon
                Layout.alignment: Qt.AlignVCenter
                visible: source == ""? false: true
                iconSize: 24
            }

            LabelSubheading {
                id: titleText
                Layout.leftMargin: 1
                color: textOnPrimary
            }

            Rectangle {
                id: badgeRect
                Layout.topMargin: 16
                Layout.rightMargin: 16
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                color: accentColor
                width: textMetric.advanceWidth + 8
                height: textMetric.height + 4
                radius: 30
                visible: badgeValue.text == ""? false: true
                TextMetrics {
                    id: textMetric
                    text: badgeValue.text
                    font: badgeValue.font
                }

                LabelBody {
                    id: badgeValue
                    color: textOnAccent
                    font: Fonts.fontCaption
                    anchors.centerIn: parent
                }
            }
        }

        Label {
            id: detailText
            Layout.leftMargin: 16
            color: textOnPrimary
            font: Fonts.fontCaption
            opacity: secondaryTextOpacity
        }

        HorizontalListDivider { }
    }
}
