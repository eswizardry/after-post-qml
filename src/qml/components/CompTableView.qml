import QtQuick 2.12
import QtQuick.Controls 2.12

ListView {
  id: root
  property var headerModel
  property var contentModel
  property var headerColumWidth: [0.2, 0.2, 0.2, 0.2, 0.2]
  property int headerHeight: height * 0.2

  contentWidth: headerItem.width
  interactive: false
  model: contentModel
  orientation : "Vertical"
  focus: true

  header: Row {
    id: headerRow
    z: 2
    height: headerHeight

    function itemAt(index) {
      return repeater.itemAt(index)
    }

    Repeater {
      id: repeater
      model: headerModel

      Label {
        id: headerLabel
        height: parent.height
        width: root.width * headerColumWidth[index]
        text: modelData
        color: guiColors.getColor_C1()
        font: guiFonts.smallFontThin
        padding: 10

        background: Rectangle {
          color: guiColors.getColor_C7()
          border.color: guiColors.getColor_C6()
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
      } // Label
    } // Repeater
  } // header: Row

  ScrollBar.vertical: ScrollBar {
    anchors.top: parent.top
    anchors.topMargin: root.headerItem.implicitHeight
    visible: false
  }
} // ListView
