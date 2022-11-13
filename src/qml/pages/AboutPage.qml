import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import "../components"
import "../singletons"

FlickablePage {
  title: "About"
  objectName: "About"
  contentHeight: root.implicitHeight
  Pane {
      id: root
      anchors.fill: parent
      anchors.leftMargin: __unsafeArea.unsafeLeftMargin
      anchors.rightMargin: __unsafeArea.unsafeRightMargin
      ColumnLayout {
          anchors.right: parent.right
          anchors.left: parent.left
          RowLayout {
              ColumnLayout {
                  Image {
                      source: "qrc:/logo.png"
                  }
                  LabelBodySecondary {
                      text: "Version: " + _APP_VERSION;
                  }
              }
              LabelHeadline {
                  Layout.alignment: Qt.AlignTop
                  leftPadding: 10
                  rightPadding: 10
                  wrapMode: Text.WordWrap
                  text: qsTr("AfterPost\nThailand Post\nParcel Tracking")
                  color: primaryColor
              }
          }

          HorizontalDivider {}
          RowLayout {
              LabelSubheading {
                  leftPadding: 10
                  rightPadding: 10
                  wrapMode: Text.WordWrap
                  text: qsTr("AfterPost Parcel Tracking\ndeveloped by Bancha (@eswizardry)")
                  color: accentColor
              }
          }
          RowLayout {
              LabelSubheading {
                  leftPadding: 10
                  rightPadding: 10
                  wrapMode: Text.WordWrap
                  text: qsTr("This APP is developed with Qt 5.13.2 and <a href=\"http://doc.qt.io/qt-5/qtquickcontrols2-index.html\">QtQuickControls2</a>.")
                  onLinkActivated: Qt.openUrlExternally("http://doc.qt.io/qt-5/qtquickcontrols2-index.html")
              }
          }

          RowLayout {
              LabelSubheading {
                  leftPadding: 10
                  rightPadding: 10
                  wrapMode: Text.WordWrap
                  text: qsTr("When I have some spare time I blog about embeded systems and software development in My blog at <a href=\"https://eswizardry.github.io\">https://eswizardry.github.io</a>")
                  onLinkActivated: Qt.openUrlExternally("https://eswizardry.github.io")
              }
          }
          HorizontalDivider {}
          RowLayout {
              visible: Qt.platform.os !== "ios"
              LabelTitle {
                  leftPadding: 10
                  rightPadding: 10
                  wrapMode: Text.WordWrap
                  text: qsTr("Do you need a crossplatform business APP for Mobile and Desktop ?")
                  color: primaryColor
              }
          }
          RowLayout {
              LabelSubheading {
                  leftPadding: 10
                  rightPadding: 10
                  wrapMode: Text.WordWrap
                  text: qsTr("I am developing Mobile APP, Embedded systems and desktop applications with Qt, QML and C/C++.")
              }
          }
          RowLayout {
              LabelSubheading {
                  leftPadding: 10
                  rightPadding: 10
                  wrapMode: Text.WordWrap
                  text: qsTr("Need an APP or Consulting service about building embedded systems, Qt, QML and C/C++? Ask me.")
              }
          }
          HorizontalDivider {}
          LabelSubheading {
              leftPadding: 10
              rightPadding: 16
              text: qsTr("More Infos ?\nemail: eswizardry@gmail.com\nfollow my blogs: http://eswizardry.github.io")
              font.italic: true
              wrapMode: Text.WordWrap
          }
      } // col layout
  } // root
} // flickable
