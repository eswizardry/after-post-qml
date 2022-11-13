// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "../components"
import "../singletons"
import "../fontAwesome"

ToolBar {
    id: myTitleBar
    property alias title: titleLabel.text
    property alias activityIndicator: activityIndicator.visible
    property alias onlineIndicator: isOnlineButton.visible
    property alias favoriteButton: favoriteButton

    topPadding: __unsafeArea.unsafeTopMargin? __unsafeArea.unsafeTopMargin : undefined

    RowLayout {
        focus: false
        spacing: 6
        anchors.fill: parent
        anchors.leftMargin: isTabletInLandscape? drawerWidth : 0
        Item {
            width: 4
        }

        FaToolButton {
            visible: !backButton.visible && !isTabletInLandscape // (!hasOnlyOneMenu)
            focusPolicy: Qt.NoFocus
            source: "fa-bars"

            onClicked: {
                openNavigationBar()
            }
        } // menu button
        // F A K E
        // fake button to avoid flicker and repositioning of titleLabel
        ToolButton {
            visible: !backButton.visible && hasOnlyOneMenu && !isLandscape
            enabled: false
            focusPolicy: Qt.NoFocus
        } // fake button

        FaToolButton {
            id: backButton
            focusPolicy: Qt.NoFocus
            visible: initDone && navigationModel[navigationIndex].canGoBack? destinations.itemAt(navigationIndex).item.depth > 1: false
            source: "fa-arrow-left"

            onClicked: {
                destinations.itemAt(navigationIndex).item.goBack()
            }
        } // backButton

        LabelTitle {
            id: titleLabel
            text: currentTitle
            leftPadding: 6
            rightPadding: 6
            elide: Label.ElideRight
            horizontalAlignment: Qt.platform.os === "android"? Qt.AlignLeft: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            color: textOnPrimary
        }

        ItemDelegate {
            id: activityIndicator
            width: 36
            focusPolicy: Qt.NoFocus
            FontAwesome {
                id: activityIcon
                anchors.centerIn: parent
                source: "fa-sync-alt"
            }
            RotationAnimator on rotation {
              id: activityIconAnimation
              target: activityIcon
              loops: Animation.Infinite
              from: 0; to: 360
              running: true
              duration: 2500
            }
        }
        ItemDelegate {
            id: isOnlineButton
            width: 36
            focusPolicy: Qt.NoFocus
            FontAwesome {
                anchors.centerIn: parent
                source: "fa-cloud-download-alt"
            }
            Rectangle {
                id: onlineMarker
                width: 8
                height: 8
                radius: width / 2
                // adjust colors or position in the middle
                color: isOnline? titleBarOnlineColor : titleBarOfflineColor
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 12
            }
            // colors not working with selected palette:
            // use this diagonal line
            Rectangle {
                visible: !isOnline
                width: 2
                height: 32
                color: textOnPrimary
                anchors.centerIn: parent
                rotation: -45
            }

            onClicked: {
                // implement somethings
            }
        } // isOnlineButton

        FaToolButton {
            id: favoriteButton
            width: 36
            focusPolicy: Qt.NoFocus
        }

        ToolButton {
            width: 36
            focusPolicy: Qt.NoFocus
            visible: (navigationIndex == homeNavigationIndex) && !backButton.visible
            Image {
                id: languageIcon
                anchors.centerIn: parent
                source: dataModel.appLanguage === "th"? "qrc:/images/Flags-Icon-Set/24x24/TH.png":
                                                        dataModel.appLanguage === "cn"? "qrc:/images/Flags-Icon-Set/24x24/CN.png":
                                                        "qrc:/images/Flags-Icon-Set/24x24/US.png"
            }
            onClicked: {
                languageOptionMenu.open()
            }
            Menu {
                id: languageOptionMenu
                modal:true
                dim: false
                closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
                x: parent.width - width
                transformOrigin: Menu.TopRight

                MenuItem {
                    text: "ภาษาไทย"
                    font: Fonts.fontDefault
                    icon.source: "qrc:/images/Flags-Icon-Set/24x24/TH.png"
                    icon.color: "transparent"
                    onTriggered: {
                        logic.languageChanged("th")
                    }
                }
                MenuItem {
                    text: "English"
                    font: Fonts.fontDefault
                    icon.source: "qrc:/images/Flags-Icon-Set/24x24/US.png"
                    icon.color: "transparent"
                    onTriggered: {
                        logic.languageChanged("en_US")
                    }
                }
                MenuItem {
                    text: "中文"
                    font: Fonts.fontDefault
                    icon.source: "qrc:/images/Flags-Icon-Set/24x24/CN.png"
                    icon.color: "transparent"
                    onTriggered: {
                        logic.languageChanged("cn")
                    }
                }

                onAboutToShow: {
                    modalMenuOpen = true
                }
                onAboutToHide: {
                    modalMenuOpen = false
                    resetFocus()
                }
            } // end languageOptionMenu
        } // languageIndicator

        ToolButton {
            id: homeOptionsButton
            visible: navigationIndex == homeNavigationIndex
            focusPolicy: Qt.NoFocus
            FontAwesome {
                anchors.centerIn: parent
                source: "fa-ellipsis-v"
            }

            onClicked: {
                homeOptionsMenu.open()
            }
            Menu {
                id: homeOptionsMenu
                modal:true
                dim: false
                closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
                x: parent.width - width
                transformOrigin: Menu.TopRight

                Menu {
                    title: qsTr("Languages")
                    font: Fonts.fontDefault
                    cascade: true
                    modal:true
                    dim: false
                    closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
                    transformOrigin: Menu.TopLeft
                    MenuItem {
                        text: "ภาษาไทย"
                        font: Fonts.fontDefault
                        icon.source: "qrc:/images/Flags-Icon-Set/24x24/TH.png"
                        icon.color: "transparent"
                        onTriggered: {
                            logic.languageChanged("th")
                        }
                    }
                    MenuItem {
                        text: "English"
                        font: Fonts.fontDefault
                        icon.source: "qrc:/images/Flags-Icon-Set/24x24/US.png"
                        icon.color: "transparent"
                        onTriggered: {
                            logic.languageChanged("en_US")
                        }
                    }
                    MenuItem {
                        text: "中文"
                        font: Fonts.fontDefault
                        icon.source: "qrc:/images/Flags-Icon-Set/24x24/CN.png"
                        icon.color: "transparent"
                        onTriggered: {
                            logic.languageChanged("cn")
                        }
                    }
                }

//                Menu {
//                  title: qsTr("Themes")
//                  cascade: true
//                  modal:true
//                  dim: false
//                  closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
//                  transformOrigin: Menu.TopLeft
//                  MenuItem {
//                    text: qsTr("Dark")
//                    onTriggered: navigationIndex = aboutNavigationIndex
//                  }
//                  MenuItem {
//                      text: qsTr("Light")
//                      onTriggered: navigationIndex = aboutNavigationIndex
//                  }
//                }

                MenuItem {
                    text: qsTr("About")
                    font: Fonts.fontDefault
                    onTriggered: navigationIndex = aboutNavigationIndex
                }

                MenuSeparator { }

                MenuItem {
                    text: qsTr("Quit")
                    font: Fonts.fontDefault
                    onTriggered: Qt.quit()
                }

                onAboutToShow: {
                    modalMenuOpen = true
                }
                onAboutToHide: {
                    modalMenuOpen = false
                    resetFocus()
                }
            } // end optionsMenu

        } // end homeOptionsButton

        // F A K E
        // fake button to avoid flicker and repositioning of titleLabel
        ToolButton {
            visible: !homeOptionsButton.visible
            enabled: false
            focusPolicy: Qt.NoFocus
        } // fake button
    } // end RowLayout
} // end ToolBar


