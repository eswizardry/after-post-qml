import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "./singletons"
import "fontAwesome"
import "navigations"
import "components"
import "popups"
import "pages"
import "model"
import "logic"
import "soup"

Pane {
    id: rootPane
    objectName: "main"

    DataModel {
        id: dataModel
        dispatcher: logic
    }

    Logic {
        id: logic
    }

    property alias navigationBar: drawerLoader.item
    property alias drawerStatus: drawerLoader.status
    property alias favoritesManu: favoritesLoader.item
    property alias titleBar: titleBarLoader.item
    property alias titleBarFloating: titleBarFloatingLoader.item

    // NAVIGATION STYLE
    // for this app the navigation style, colors (primary, accent) and theme (dark, light) are fix
    property bool isClassicNavigationStyle: false
    property bool isBottomNavigationStyle: false
    property bool isComfortNavigationStyle: true
    property bool hasOnlyOneMenu: true

    // show TITLE  BARS is delayed until INIT DONE
    property bool useDefaultTitleBarInLandscape: false
    property bool highlightActiveNavigationButton : true
    property bool showFavoritesMenu: initDone && (!isLandscape || isTabletInLandscape) && !isClassicNavigationStyle && drawerStatus === Loader.Ready && (isTabletInLandscape || navigationBar.position === 0)

    property string currentTitle
    property int firstActiveDestination: homeNavigationIndex
    property int navigationIndex: firstActiveDestination
    onNavigationIndexChanged: {
        drawerNavStack.activateDestination(navigationIndex)
    }

    // Counter: orders
    // Marker: customer
    property var navigationData: [
        {"counter":0, "marker":""},
        {},
        {"counter":0, "marker":""}
    ]
    // Menu Button
    // plus max 4 from drawer: home, customer, orders, settings
    // favoritesModel maps to index from navigationModel
    // if reordering adjust properties
    property int homeFavoritesIndex: 0

    // TabBar-SwipeView
    // StackView
    property var activationPolicy: { "NONE": 0, "IMMEDIATELY": 1, "LAZY": 2, "WHILE_CURRENT": 3 }

    // NAVIGATION BAR PROPRTIES (a_p == activationPolicy)
    // IMMEDIATELY: Home
    // LAZY: customer, orders
    // WHILE_CURRENT: About, Settings
    // StackView: Home --> QtPage, Settings --> primary / Accent
    // if reordering adjust properties
    property int homeNavigationIndex: 0
    property int aboutNavigationIndex: 2

    property var navigationModel: [
      {"type": "DrawerNavigationButton.qml",  "name": "Home",    "icon": "fa-home", "source": "NavigationStack.qml", "showCounter":false, "showMarker":false, "a_p":1, "canGoBack":true},
      {"type": "DrawerDivider.qml",           "name": "",              "icon": "",         "source": "", "a_p":1, "canGoBack":false},
      {"type": "DrawerNavigationButton.qml",  "name": "About",   "icon": "fa-info-circle", "source": "../pages/AboutPage.qml", "showCounter":false, "showMarker":false, "a_p":3, "canGoBack":false}
    ]

    property var favoritesModel: [
      homeNavigationIndex, aboutNavigationIndex
    ]

    function openNavigationBar() {
      navigationBar.open()
    }
    function closeNavigationBar() {
      if(!isTabletInLandscape) {
          navigationBar.close()
      }
    }
    // end NAVIGATION BARS

    // INIT DONE: show TITLE and NAVIGATION BARS
    // NAVIGATION BARS (DRAWER and FAVORITES)
    // The sliding Drawer
    Loader {
        id: drawerLoader
        active: initDone
        visible: initDone
        sourceComponent: DrawerNavigationBar {
            onPositionChanged: position > 0.0? banner.hide(): banner.show()
        }
    }
    Loader {
        id: favoritesLoader
        active: initDone
        // attention: set also footer !
        visible: false//showFavoritesMenu
        sourceComponent: DrawerFavoritesNavigationBar { }
        onVisibleChanged: visible? appWindow.footer = favoritesManu: null
    }

    Component {
      id: titleBarComponent
      DrawerTitleBar {
        activityIndicator: dataModel.loading
        onlineIndicator: false
        favoriteButton.visible: title === dataModel.trackingNumber
        favoriteButton.source: dataModel.isFavorite()? "fa-heart": "fa-heart-O"
        favoriteButton.onClicked: logic.toggleFavorite()
      }
    }
    Loader {
      id: titleBarLoader
      visible: (!isLandscape || useDefaultTitleBarInLandscape) && initDone
      active: (!isLandscape || useDefaultTitleBarInLandscape) && initDone
      sourceComponent: titleBarComponent
      onActiveChanged: active? appWindow.header = item: null
    }
    // in LANDSCAPE header is null and we have a floating TitleBar
    Loader {
      id: titleBarFloatingLoader
      visible: !useDefaultTitleBarInLandscape && isLandscape && initDone
      active: !useDefaultTitleBarInLandscape && isLandscape && initDone
      sourceComponent: titleBarComponent
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      onActiveChanged: active? appWindow.header = item: null
    }
    // end TITLE BARS
    function resetDefaultTitleBarInLandscape() {
        useDefaultTitleBarInLandscape = false
    }
    function setDefaultTitleBarInLandscape() {
        useDefaultTitleBarInLandscape = true
    }

    //============================= R o o t - S T A C K V I E W
    // STACK VIEW (drawerNavStack)
    // the ROOT contains always only one Page,
    // which will be replaced if root node changed
    StackView {
        id: drawerNavStack
        focus: true
        anchors.top: isLandscape ? titleBarFloatingLoader.bottom : parent.top
        anchors.left: parent.left
        anchors.topMargin: isLandscape ? 6 : 0
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: isTabletInLandscape? drawerWidth : 0

        // STACK VIEW TRANSITIONS
        replaceEnter: Transition {
          PropertyAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 300
          }
        }
        replaceExit: Transition {
          PropertyAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 300
          }
        }
        // end STACKVIEW TRANSITIONS

        // STACK VIEW KEYS and SHORTCUTS
        // support of BACK key
        // can be used from StackView pushed on ROOT
        // or to exit the app
        // https://wiki.qt.io/Qt_for_Android_known_issues
        // By default the Back key will terminate Qt for Android apps, unless the key event is accepted.
        Keys.onBackPressed: {
            event.accepted = true
            if(backKeyfreezed) {
                showToast(qsTr("Please wait. Back key not allowed at the moment."))
                return
            }
            if (modalPopupActive) {
                showToast(qsTr("Back key not allowed - please select an option."))
                return
            }
            // we don't have to check for appWindow.modalMenuOpen
            // because my modal menus allow close by ESCAPE (== Android BACK key)
            if (!initDone) {
                return
            }

            if (navigationModel[navigationIndex].canGoBack && destinations.itemAt(navigationIndex).item.depth > 1) {
                destinations.itemAt(navigationIndex).item.goBack()
                return
            }
            if (initDone && navigationBar.position === 0) {
                openNavigationBar()
                return
            }
            if (Qt.platform.os === "android") {
                popupExitApp.open()
                return
            }
            showToast(qsTr("No more Pages"))
        }
        // TODO some Shortcuts
        // end STACK VIEW KEYS and SHORTCUTS

        // STACK VIEW INITIAL ITEM (BUSY INDICATOR)
        // immediately activated and pushed on stack as initialItem
        Loader {
            id: initialPlaceholder
            property bool isUpdate: false
            sourceComponent: InitialItemPage { }
            active: true
            visible: false
            onLoaded: {
                // Show BUSY INDICATOR
                if (isUpdate) {
                    drawerNavStack.replace(item)

                  // now doing the UPDATE stuff
                    updateTimer.start()
                } else {
                    // Using push instead of initItem due to InitialItem not load item to stack
                    drawerNavStack.push(item)

                    // Now something is VISIBLE - do the other time-consuming stuff
                    startupDelayedTimer.start()
                }
            }
        }
        // end STACK VIEW INITIAL ITEM

        // DELAYED STARTUP TIMER
        // do the hevy stuff while initialItem is visible
        // initialize Data, create Navigation, make Title visible, ...
        Timer {
            id: startupDelayedTimer
            interval: 300
            repeat: false
            onTriggered: {
                console.log("startupDelayedTimer START")

                initialPlaceholder.item.showInfo("Initialize Data ...")

                // show the Navigation Bars (Drawer and Favorites)
                initDone = true
                console.log("init DONE")
                // show first destination (should always be IMMEDIATELY)
                drawerNavStack.activateDestination(firstActiveDestination)
                console.log("startupDelayedTimer DONE")
            }
        }

        function gotoFirstDestination() {
            navigationIndex = firstActiveDestination
        }

        // ASYNC STARTUP: Destinations will be loaded from Timer
        // that's why no model is attached at the beginning
        // startupDelayedTimer will set the model
        Repeater {
            id: destinations
            model: navigationModel
            // Destination encapsulates Loader
            // depends from activationPolicy how to load dynamically
            Destination {
                id: destinationLoader
            }
            // Repeater creates all destinations (Loader)
            // all destinatation items w activationPolicy IMMEDIATELY are activated
        }

        // STACK VIEW (drawerNavStack) FUNCTIONS
        // switch to new Destination
        // Destinations are lazy loaded via Loader
        function activateDestination(navigationIndex) {
            if (destinations.itemAt(navigationIndex).status === Loader.Ready) {
                console.log("replace item on root stack: " + navigationIndex)
                replaceDestination(destinations.itemAt(navigationIndex))
                currentTitle = destinations.itemAt(navigationIndex).item.currentItem.title
            } else {
                console.log("first time item to be replaced: " + navigationIndex)
                destinations.itemAt(navigationIndex).active = true
            }
        }

        // called from activeDestination() and also from Destination.onLoaded()
        function replaceDestination(theItemLoader) {
            var previousItem = drawerNavStack.currentItem
            var previousIndex = previousItem.myIndex
            var previousItemLoader
            if (previousIndex >= 0) {
                previousItemLoader  = destinations.itemAt(previousIndex)
            }
            // because of https://bugreports.qt.io/browse/QTBUG-54260
            // remember currentIndex before being replaced
            console.log("replace destination for name: " + previousItem.objectName)

            // now replace the Page
            drawerNavStack.replace(theItemLoader.item)
            // check if previous should be unloaded

            if (previousIndex >= 0) {
                if(destinations.itemAt(previousIndex).pageActivationPolicy === activationPolicy.WHILE_CURRENT) {
                    destinations.itemAt(previousIndex).active = false
                }
            } else {
                initialPlaceholder.active = false
            }
        }

        // example HowTo set a counter
        // first time called from startupDelayedTimer
        function updateOrderCounter() {
            //            var counter = dataManager.orderPropertyList.length
            //            navigationData[4].counter = counter
            //            navigationBar.navigationButtons.itemAt(4).item.counter = counter
        }
        // update counter if Orders deleted or added
        // connect C++ SIGNAL to QML SLOT
        //        Connections {
        //                target: dataManager
        //                onOrderPropertyListChanged: drawerNavStack.updateOrderCounter()
        //            }

        // example HowTo set a marker
        function updateCustomerMarker(abc) {
            //            switch(abc) {
            //                case 0:
            //                    navigationData[3].marker = "green"
            //                    break;
            //                case 1:
            //                    navigationData[3].marker = "grey"
            //                    break;
            //                case 2:
            //                    navigationData[3].marker = "red"
            //                    break;
            //                default:
            //                    navigationData[3].marker = "transparent"
            //            }
            //            navigationBar.navigationButtons.itemAt(3).item.marker = navigationData[3].marker
        }
    } // drawerNavStack
    //============================= end - R o o t - S T A C  K V I E W

    // APP WINDOW POPUPS
    PopupExit {
        id: popupExitApp
        parent: rootPane
        onAboutToHide: {
            popupExitApp.stopTimer()
            resetFocus()
            if (popupExitApp.isExit) {
                Qt.quit()
            }
        }
    } // popupExitApp
    PopupInfo {
        id: popupInfo
        parent: rootPane
        onAboutToHide: {
            popupInfo.stopTimer()
            resetFocus()
        }
    } // popupInfo
    // PopupToast
    PopupToast {
        id: popupToast
        parent: rootPane
        onAboutToHide: {
            resetFocus()
        }
    } // popupToast
    // PopupToast
    PopupError {
        id: popupError
        parent: rootPane
        onAboutToHide: {
            resetFocus()
        }
    } // popupError
    // end APP WINDOW POPUPS

    // APP WINDOW FUNCTIONS
    // we can loose the focus if Menu or Popup is opened
    function resetFocus() {
        rootPane.focus = true
    }

    function showToast(info) {
        popupToast.start(info)
    }

    function showError(info) {
        popupError.start(info)
    }

    function showInfo(info) {
        popupInfo.text = info
        popupInfo.buttonText = qsTr("OK")
        popupInfo.open()
    }
    // end APP WINDOW FUNCTIONS
}
