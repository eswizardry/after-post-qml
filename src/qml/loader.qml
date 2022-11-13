import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12
import QtWebSockets 1.0
import QtGraphicalEffects 1.0
import QtAndroidTools 1.0
import QtQuick.Dialogs 1.2

import "../config.js" as Config
import "singletons"

import StatusBar 0.1

ApplicationWindow {
    id: appWindow
    objectName: "appWindow"
    title: qsTr("After Post")
    visible: true
    // running on mobiles you don't need width and height
    // ApplicationWindow will always fill entire screen
    width: 1920
    height: 1080
    // header per Page, footer global in Portrait + perhaps per Page, too
    // header and footer invisible until initDone
    header: null
    footer: Rectangle {
        width: banner.width
        height: banner.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: "transparent"
        QtAndroidAdMobBanner {
            id: banner
            type: QtAndroidAdMobBanner.TYPE_SMART_BANNER
            unitId: "ca-app-pub-3940256099942544/6300978111" // Test Ads
//            unitId: "ca-app-pub-1002513462481319/1982272413"
//            keywords: ["keyword_1", "keyword_2", "keyword_3"]
        }
        Component.onCompleted: banner.show()
    }
    // this is set from main.cpp
    property bool _DEBUG_MODE
    property string _APP_VERSION

    property alias banner: banner

    // main signal for opening module
    signal intent(string action, var extras)

    property int safeWidth: width - __unsafeArea.unsafeLeftMargin - __unsafeArea.unsafeRightMargin - (isTabletInLandscape? drawerWidth : 0)
    property int safeHeight: height - __unsafeArea.unsafeTopMargin - __unsafeArea.unsafeBottomMargin

    // fills iPhone and iPad devices screen totally
    // ATTENTION: if only setting flags: Qt.MaximizeUsingFullscreenGeometryHint
    // it will work on iOS and Android, but on Android the BACK key wasn't detected anymore
    // so it's important to set both flags
    // found this in JP Nurmis Statusbar project
    // https://github.com/jpnurmi/statusbar/blob/master/example/main.qml
    flags: Qt.platform.os === "ios"? Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint : Qt.Window

    // https://bugreports.qt.io/browse/QTBUG-64574
    // https://stackoverflow.com/questions/46192280/detect-if-the-device-is-iphone-x
    // TODO HowTo deal with Android - Notch - Devices ?
    property int lastOrientation: 0
    property int myOrientation: (Qt.platform.os === "ios")? Screen.orientation : 0
    onMyOrientationChanged: {
        if(lastOrientation === 0) {
            Screen.orientationUpdateMask = Qt.LandscapeOrientation | Qt.PortraitOrientation | Qt.InvertedLandscapeOrientation | Qt.InvertedPortraitOrientation
            console.log("First time orientation changes: set the mask to "+Screen.orientationUpdateMask)
            // detect the device to know about unsafe areas
            __unsafeArea.configureDevice(Screen.height, Screen.width, Screen.devicePixelRatio)
            if (__unsafeArea.isKnownIPad()) {
                isTablet = true
            }
        }
        // triggers unsafe areas and sets margins
        __unsafeArea.orientationChanged(myOrientation)
        lastOrientation = myOrientation
    }

    Connections {
        target: QtAndroidAppPermissions
        onRequestPermissionsResults: {
            for (var i = 0; i < results.length; i++) {
                if(results[i].granted === true) {
                    console.debug("P E R M I S S I O N  -  G R A N T E D: ", results[i].name)
                } else {
                    if(QtAndroidAppPermissions.shouldShowRequestPermissionInfo(results[i].name) === true) {
                        if(results[i].name === permissionsNameList[0])
                            requestPermissionWRITE_EXTERNAL_STORAGE.open();
                    } else {
                        console.debug("P E R M I S S I O N  -  N O T  - A L L O W: ", results[i].name)
                        Qt.quit()
                    }
                }
            }
        }
    }

    MessageDialog {
        id: requestPermissionWRITE_EXTERNAL_STORAGE
        standardButtons: StandardButton.Ok
        title: "Advise"
        text: "This app require WRITE_EXTERNAL_STORAGE permission for store favorite data."
        onAccepted: QtAndroidAppPermissions.requestPermission(permissionsNameList[0])
    }

    Component.onCompleted: {
        mainScreenLoader.active = true

        if (Qt.platform.os === "android") {
            // Ask for android permission
            var permissionsNameList = ["android.permission.WRITE_EXTERNAL_STORAGE"]
            QtAndroidAppPermissions.requestPermissions(permissionsNameList)

            var screenWidthPixel =  Screen.width * Screen.devicePixelRatio
            var screenHeightPixel = Screen.height * Screen.devicePixelRatio
            var pixelPerInch = Screen.pixelDensity * Screen.devicePixelRatio * 25.4
            var screenSizeInch = Math.sqrt(screenWidthPixel * screenWidthPixel + screenHeightPixel * screenHeightPixel) / pixelPerInch;

            console.debug("SCREEN SIZE in INCH: " + screenSizeInch)

            if (screenSizeInch > minTabletSize) {
                isTablet = true
            }
        }

        if (_DEBUG_MODE)
            console.debug("DEBUG MODE")
        console.debug("config:", JSON.stringify(Config, null, 4))
    }

    readonly property bool isLandscape: width > height
    readonly property bool isSmallDevice: !isLandscape && width < 360
    // iOS: set from configure unsafe areas (see above)
    readonly property bool isTablet: Qt.platform.os === "windows"? true : false
    readonly property bool isTabletInLandscape: isTablet && isLandscape
    // Android (checked in startupDelayedTimer)
    readonly property real minTabletSize: 6.9
    readonly property int drawerWidth: Math.min(240,  Math.min(width, height) / 3 * 2 )

    // show TITLE  BARS is delayed until INIT DONE
    property bool initDone: false

    property bool backKeyfreezed: false
    property bool modalPopupActive: false
    property bool modalMenuOpen: false

    // ONLINE - OFFLINE - NETWORK STATE
    property bool isOnline: true
    property color titleBarOnlineColor: "LightGreen"
    property color titleBarOfflineColor: "Red"

    // T H E M E
    // primary and accent properties:
    property variant primaryPalette: __appUi.defaultPrimaryPalette()
    property color primaryLightColor: primaryPalette[0]
    property color primaryColor: primaryPalette[1]
    property color primaryDarkColor: primaryPalette[2]
    property color textOnPrimaryLight: primaryPalette[3]
    property color textOnPrimary: primaryPalette[4]
    property color textOnPrimaryDark: primaryPalette[5]
    property string iconOnPrimaryLightFolder: primaryPalette[6]
    property string iconOnPrimaryFolder: primaryPalette[7]
    property string iconOnPrimaryDarkFolder: primaryPalette[8]
    property variant accentPalette: __appUi.defaultAccentPalette()
    property color accentColor: accentPalette[0]
    property color textOnAccent: accentPalette[1]
    property string iconOnAccentFolder: accentPalette[2]

    // theme Dark vs Light properties:
    property variant themePalette: __appUi.defaultThemePalette()
    property color dividerColor: themePalette[0]
    property color cardAndDialogBackground: themePalette[1]
    property real primaryTextOpacity: themePalette[2]
    property real secondaryTextOpacity: themePalette[3]
    property real dividerOpacity: themePalette[4]
    property real iconActiveOpacity: themePalette[5]
    property real iconInactiveOpacity: themePalette[6]
    property string iconFolder: themePalette[7]
    property int isDarkTheme: themePalette[8]
    property color flatButtonTextColor: themePalette[9]
    property color popupTextColor: themePalette[10]
    property real toolBarActiveOpacity: themePalette[11]
    property real toolBarInactiveOpacity: themePalette[12]
    property color toastColor: themePalette[13]
    property real toastOpacity: themePalette[14]

    // fonts are grouped into primary and secondary with different Opacity
    // to make it easier to get the right property,
    // here's the opacity per size:
    property real opacityDisplay4: secondaryTextOpacity
    property real opacityDisplay3: secondaryTextOpacity
    property real opacityDisplay2: secondaryTextOpacity
    property real opacityDisplay1: secondaryTextOpacity
    property real opacityHeadline: primaryTextOpacity
    property real opacityTitle: primaryTextOpacity
    property real opacitySubheading: primaryTextOpacity
    // body can be both: primary or secondary text
    property real opacityBodyAndButton: primaryTextOpacity
    property real opacityBodySecondary: secondaryTextOpacity
    property real opacityCaption: secondaryTextOpacity
    // using Icons as Toggle to recognize 'checked'
    property real opacityToggleInactive: 0.2
    property real opacityToggleActive: 1.0

    function switchPrimaryPalette(paletteIndex) {
        primaryPalette = __appUi.primaryPalette(paletteIndex)
    }

    function switchAccentPalette(paletteIndex) {
        accentPalette = __appUi.accentPalette(paletteIndex)
    }

    Material.primary: primaryColor
    Material.accent: accentColor
    // 5.7: dropShadowColor is ok - the shadow is darker as the background
    // but not so easy to distinguish as in light theme
    // optional:
    // isDarkTheme? "#E4E4E4" : Material.dropShadowColor
    property color dropShadow: Material.dropShadowColor
    onIsDarkThemeChanged: {
        if (isDarkTheme == 1) {
            Material.theme = Material.Dark
        } else {
            Material.theme = Material.Light
        }
    }
    // end T H E M E

    StatusBar {
        id: statusBar
        theme: StatusBar.Dark
        color: primaryDarkColor
    }

    // R E M O V E  or  C O M M E N T  when  R E L E A S E
    // dummy component for development
    // this make QtCreator detect this file across all children.
    Component {
        id: mainComponent
        Main { }
    }
    // end dummy component

    // Q M L - L I V E - R E L O A D
    // main application content
    // in debug mode fetched from http, in production, builtin version is used
    Loader {
        id: mainScreenLoader
        objectName: "mainScreen"
        source: _DEBUG_MODE ? "%1/qml/Main.qml".arg(Config.api.url) : "qrc:/qml/Main.qml"
        anchors.fill: parent
        asynchronous: false

        function reload() {
            if (mainScreenLoader.status === Loader.Loading)
                return console.log("Ignoring reload request, reload in progress")

            console.log("A P P L I C A T I O N - R E L O A D...")

            // reset footer and header before reload
            appWindow.footer = null
            appWindow.header = null

            var src = source
            source = ""
            __platform.clearCache()
            source = src

            // restart websocket debug server
            wsDebugServer.active = false
            wsDebugServer.active = true
        }
    } // Loader

    // websocket client used for development
    WebSocket {
        id: wsDebugServer
        url: Config.debug.wsurl
        active: _DEBUG_MODE
        onStatusChanged: {
            if(status === WebSocket.Error)
                console.log("W e b  S o c k e t error:", errorString)
        }

        onTextMessageReceived: {
            console.log("W e b  S o c k e t message:", message)
            var msg = JSON.parse(message)
            if(msg.action === "reload")
                mainScreenLoader.reload()
        }
    } // WebSocket

    Label {
        id: errorMessage
        color: "white"
        text: "Unable to load remote qml, check if server is available and running"
        width: 300
        wrapMode: Label.WordWrap
        anchors.centerIn: parent
        enabled: _DEBUG_MODE && mainScreenLoader.status === Loader.Error
        visible: enabled
    }

    Button {
        anchors.top: errorMessage.bottom
        anchors.topMargin: height
        anchors.horizontalCenter: errorMessage.horizontalCenter
        text: "Retry"
        onClicked: mainScreenLoader.reload()
        enabled: errorMessage.enabled
        visible: enabled
    } // end Q M L - L I V E - R E L O A D
} // appWindow
