pragma Singleton

import QtQuick 2.12

/** @ingroup QML_Singleton
 *  @brief The QML Global for Fonts
 */
Item {
    id: root
    readonly property string robotoRegular: _.fontRobotoRegular.name
    readonly property string robotoLight: _.fontRobotoLight.name
    readonly property string robotoThin: _.fontRobotoThin.name
    readonly property string faIcons: _.fontAwesomeSolid.name
    readonly property string faBrands: _.fontAwesomeBrands.name

    // font sizes - defaults from Google Material Design Guide
    property int fontSizeDisplay4: 112
    property int fontSizeDisplay3: 56
    property int fontSizeDisplay2: 45
    property int fontSizeDisplay1: 34
    property int fontSizeHeadline: 24
    property int fontSizeTitle: 20
    property int fontSizeSubheading: 16
    property int fontSizeBodyAndButton: 14
    property int fontSizeCaption: 12
    property int fontSizeActiveNavigationButton: 14
    property int fontSizeInactiveNavigationButton: 12

    readonly property font fontDisplay4: Qt.font({"family": robotoLight, "pointSize": fontSizeDisplay4})
    readonly property font fontDisplay3: Qt.font({"family": robotoLight, "pointSize": fontSizeDisplay3})
    readonly property font fontDisplay2: Qt.font({"family": robotoLight, "pointSize": fontSizeDisplay2})
    readonly property font fontDisplay1: Qt.font({"family": robotoLight, "pointSize": fontSizeDisplay1})
    readonly property font fontHeadline: Qt.font({"family": robotoLight, "pointSize": fontSizeHeadline})
    readonly property font fontTitle: Qt.font({"family": robotoLight, "pointSize": fontSizeTitle})
    readonly property font fontSubheading: Qt.font({"family": robotoLight, "pointSize": fontSizeSubheading})
    readonly property font fontDefault: Qt.font({"family": robotoLight, "pointSize": fontSizeBodyAndButton})
    readonly property font fontSubTitle: Qt.font({"family": robotoLight, "pointSize": fontSizeBodyAndButton, "weight": Font.Medium})
    readonly property font fontCaption: Qt.font({"family": robotoLight, "pointSize": fontSizeCaption})
    readonly property font fontActiveNavigationButton: Qt.font({"family": robotoLight, "pointSize": fontSizeActiveNavigationButton})
    readonly property font fontInactiveNavigationButton: Qt.font({"family": robotoLight, "pointSize": fontSizeInactiveNavigationButton})

    // private
    QtObject {
        id: _

        readonly property FontLoader fontAwesomeRegular: FontLoader {
            id: fontAwesomeRegular
            source: "qrc:/fonts/Font Awesome 5 Free-Regular-400.otf"
        }

        readonly property FontLoader fontAwesomeSolid: FontLoader {
            id: fontAwesomeSolid
            source: "qrc:/fonts/Font Awesome 5 Free-Solid-900.otf"
        }

        readonly property FontLoader fontAwesomeBrands: FontLoader {
            id: fontAwesomeBrands
            source: "qrc:/fonts/Font Awesome 5 Brands-Regular-400.otf"
        }
        readonly property FontLoader fontRobotoRegular: FontLoader {
            id: fontRobotoRegular
            source: "qrc:/fonts/Roboto-Regular.ttf"
        }
        readonly property FontLoader fontRobotoThin: FontLoader {
            id: fontRobotoThin
            source: "qrc:/fonts/Roboto-Thin.ttf"
        }
        readonly property FontLoader fontRobotoLight: FontLoader {
            id: fontRobotoLight
            source: "qrc:/fonts/Roboto-Light.ttf"
        }
    }
}
